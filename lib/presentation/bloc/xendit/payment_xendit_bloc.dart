import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/holder/last_transaction_holder.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/bloc/xendit/payment_xendit_event.dart';
import 'package:pad_lampung/presentation/bloc/xendit/payment_xendit_state.dart';
import 'package:pad_lampung/presentation/utils/delegate/xendit_payment_delegate.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../core/data/repositories/ticket_repository.dart';

class PaymentXenditBloc extends Bloc<PaymentXenditEvent, PaymentXenditState> {
  final TicketRepository repository;
  final AppPreferences storage;

  PaymentXenditBloc({required this.repository, required this.storage})
      : super(InitiatePaymentXenditState()) {
    String invoiceId = '';
    String noTransaksi = '';
    int idTransaction = 0;
    XenditPaymentDelegate? delegate;
    bool isCurrentPaymentNeedListening = false;

    void encodeAndSaveTransaction(
        int totalPrice,
        int price,
        int quantity,
        String paymentMethod,
        int servicePrice,
        String url,
        int idTarif,
        int idTransaksi) {
      LastTransactionHolder dataHolder = LastTransactionHolder(
          totalPrice: totalPrice,
          price: price,
          quantity: quantity,
          paymentMethod: paymentMethod,
          noTransaksi: noTransaksi,
          invoiceId: invoiceId,
          servicePrice: servicePrice,
          idTarif: idTarif,
          idTransaction: idTransaksi,
          urlPayment: url);

      String jsonData = dataHolder.toJsonString();
      storage.writeSecureData(lastTransactionUrlKey, jsonData);
    }

    on<CreateXenditPayment>((event, emit) async {
      emit(LoadingPaymentXendit());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String wisataId = await storage.readSecureData(wisataIdKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";

      String email = await storage.readSecureData(petugasEmailKey) ?? "";

      var data = await repository.processTicketBooking(
          accessToken: token,
          paymentMethod: event.paymentMethod,
          idTempatWisata: int.parse(wisataId),
          quantity: event.quantity,
          idTarif: event.idTarif);

      data.fold((failure) {
        emit(FailedPaymentXenditState(failure.error ?? ""));
      }, (data) {
        if (data.code.isStatusSuccess()) {
          noTransaksi = data.data.noTransaksi;
          idTransaction = data.data.id;
          return;
        } else {
          emit(FailedPaymentXenditState(data.message));
        }
      });

      var dataXendit = await repository.createPaymentXendit(
          accessToken: token,
          email: email,
          totalPrice: event.totalPrice,
          price: event.price,
          quantity: event.quantity,
          paymentMethod: event.paymentMethod,
          wisataName: wisataName,
          servicePrice: event.servicePrice,
          noTransaksi: noTransaksi);

      dataXendit.fold((dataXenditFailure) {
        emit(FailedPaymentXenditState(dataXenditFailure.error ?? ""));
      }, (dataXenditResponse) {
        if (dataXenditResponse.code.isStatusSuccess()) {
          invoiceId = dataXenditResponse.data.id;

          encodeAndSaveTransaction(
              event.totalPrice,
              event.price,
              event.quantity,
              event.paymentMethod,
              event.servicePrice,
              dataXenditResponse.data.invoiceUrl,
              event.idTarif,
              idTransaction);

          emit(SuccessCreateXenditPayment(dataXenditResponse.data.invoiceUrl));
          return;
        } else {
          emit(FailedPaymentXenditState(dataXenditResponse.message));
        }
      });
    });

    on<CreateParkirXenditPayment>((event, emit) async {
      emit(LoadingPaymentXendit());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String wisataId = await storage.readSecureData(wisataIdKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";

      String email = await storage.readSecureData(petugasEmailKey) ?? "";
      idTransaction = event.idTransaksi;

      var dataXendit = await repository.createPaymentXendit(
          accessToken: token,
          email: email,
          totalPrice: event.price,
          price: event.price,
          quantity: 1,
          paymentMethod: event.paymentMethod,
          wisataName: wisataName,
          servicePrice: event.servicePrice,
          noTransaksi: event.noTransaksi);

      dataXendit.fold((dataXenditFailure) {
        emit(FailedPaymentXenditState(dataXenditFailure.error ?? ""));
      }, (dataXenditResponse) {
        if (dataXenditResponse.code.isStatusSuccess()) {
          invoiceId = dataXenditResponse.data.id;
          noTransaksi = event.noTransaksi;

          encodeAndSaveTransaction(
              event.price,
              event.price,
              1,
              event.paymentMethod,
              event.servicePrice,
              dataXenditResponse.data.invoiceUrl,
              0,
              0);

          emit(SuccessCreateXenditPayment(dataXenditResponse.data.invoiceUrl));
          return;
        } else {
          emit(FailedPaymentXenditState(dataXenditResponse.message));
        }
      });
    });

    on<CheckXenditPayment>((event, emit) async {
      delegate = event.delegate;
      isCurrentPaymentNeedListening = true;
      String token = await storage.readSecureData(tokenKey) ?? "";
      print('Called check payment');
      var data =
          await repository.checkPaymentXendit(token, noTransaksi, invoiceId);

      data.fold((failure) {
        delegate?.onPaymentFailed(failure.error ?? "");
      }, (data) async {
        if (data.data.status == "PENDING") {
          await Future.delayed(const Duration(seconds: 4));
          if (isCurrentPaymentNeedListening) {
            delegate?.onNeedRepeatRequest();
          }
        } else if (data.data.status == "EXPIRED") {
          delegate?.onPaymentFailed('Transaksi telah kadaluarsa');
        } else {
          delegate?.onPaymentSuccess(noTransaksi);
        }
      });
    });

    on<CancelXenditPayment>((event, emit) async {
      delegate ??= event.delegate;
      String token = await storage.readSecureData(tokenKey) ?? "";
      isCurrentPaymentNeedListening = false;
      print('Called check payment with id $idTransaction');
      await storage.deleteSecureData(lastTransactionUrlKey);

      var data = await repository.deletePaymentXendit(
          token,
          event.idTransaction == null
              ? idTransaction.toString()
              : event.idTransaction.toString());

      data.fold((failure) {
        delegate?.onPaymentFailed(failure.error ?? "");
      }, (data) async {
        delegate?.onPaymentCanceled();
      });
    });

    on<CancelParkirXenditPayment>((event, emit) async {
      isCurrentPaymentNeedListening = false;
      await storage.deleteSecureData(lastTransactionUrlKey);

      delegate?.onPaymentCanceled();
    });

    on<GetXenditPaymentMethod>((event, emit) async {
      emit(LoadingPaymentXendit());
      String token = await storage.readSecureData(tokenKey) ?? "";
      var data = await repository.fetchXenditPaymentMethod(token);
      data.fold((failure) {
        emit(FailedPaymentXenditState(failure.message ?? ""));
      }, (data) async {
        emit(ShowXenditPaymentMethod(data.data));
      });
    });
  }
}
