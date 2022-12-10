import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import 'ticket_price_event.dart';
import 'ticket_price_state.dart';

class TicketPriceBloc extends Bloc<TicketPriceEvent, TicketPriceState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketPriceBloc({required this.repository, required this.storage})
      : super(InitiateTicketPriceState()) {
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
          emit(SuccessShowTicketPrice(response.data.tarifWeekend, response.data.id));
        } else {
          emit(SuccessShowTicketPrice(response.data.tarifWeekday, response.data.id));
        }
      });
    });
  }
}
