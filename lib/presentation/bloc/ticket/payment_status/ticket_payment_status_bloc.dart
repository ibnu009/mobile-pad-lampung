import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_data_ticket_masuk_ext.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import 'ticket_payment_status_event.dart';
import 'ticket_payment_status_state.dart';

class TicketPaymentStatusBloc
    extends Bloc<TicketPaymentStatusEvent, TicketPaymentStatusState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketPaymentStatusBloc({required this.repository, required this.storage})
      : super(InitiateTicketPaymentStatusState()) {
    on<GetPaymentStatus>((event, emit) async {
      emit(LoadingTicketPaymentStatus());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";
      String printerTicket =
          await storage.readSecureData(printerTicketKey) ?? "-";
      String printerStruct =
          await storage.readSecureData(printerStructKey) ?? "-";

      var data =
          await repository.checkPaymentStatus(token, event.transactionNumber);
      var dataScan =
          await repository.scanTicket(token, event.transactionNumber);

      data.fold((failure) {
        emit(FailedShowTicketPayment(failure.error ?? ""));
      }, (data) {
        dataScan.fold((dataScanFailure) {
          emit(FailedShowTicketPayment(dataScanFailure.error ?? ""));
        }, (dataScanResponse) {
          if (dataScanResponse.code.isStatusSuccess()) {
            emit(SuccessShowTicketPayment(
                ticketCodes: dataScanResponse.data.extractTicketCode(),
                wisataName: wisataName,
                printerTicketName: printerTicket,
                printerStructName: printerStruct));
            return;
          } else {
            emit(FailedShowTicketPayment(data.message));
          }
        });
      });
    });
  }
}
