import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import '../../../utils/delegate/generic_delegate.dart';
import 'ticket_price_event.dart';
import 'ticket_price_state.dart';

class TicketPriceBloc extends Bloc<TicketPriceEvent, TicketPriceState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketPriceBloc({required this.repository, required this.storage})
      : super(InitiateTicketPriceState()) {
    GenericDelegate? delegate;

    on<GetTicketPrice>((event, emit) async {
      emit(LoadingTicketPrice());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";

      var data = await repository.fetchTicketPrice(token, idWisata);
      data.fold((failure) {
        emit(FailedShowTicketPrice(failure.error ?? ""));
      }, (response) {
        bool isWeekend = DateTime.now().isWeekend();
        if (isWeekend) {
          emit(SuccessShowTicketPrice(
              response.data.tarifWeekend, response.data.id));
        } else {
          emit(SuccessShowTicketPrice(
              response.data.tarifWeekday, response.data.id));
        }
      });
    });

    on<ProcessTicketBooking>((event, emit) async {
      delegate = event.delegate;
      delegate?.onLoading();
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "0";
      String userEmail = await storage.readSecureData(petugasEmailKey) ?? "";
      String phoneNumber = await storage.readSecureData(petugasNoTelpKey) ?? "";

      var data = await repository.processTicketBooking(
          accessToken: token,
          phoneNumber: phoneNumber,
          email: userEmail,
          paymentMethod: event.paymentMethod,
          idTempatWisata: int.parse(idWisata),
          quantity: event.quantity,
          idTarif: event.idTarif);
      data.fold((failure) {
        delegate?.onFailed(failure.error ?? "");
      }, (response) {
        delegate?.onSuccess(response.data.noTransaksi);
      });
    });
  }
}
