import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import 'ticket_online_event.dart';
import 'ticket_online_state.dart';

class TicketOnlineBloc extends Bloc<TicketOnlineEvent, TicketOnlineState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketOnlineBloc({required this.repository, required this.storage})
      : super(InitiateTicketOnlineState()) {
    on<GetOnlineTicketBooking>((event, emit) async {
      emit(LoadingTicketOnline());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";

      var dataTransaction =
          await repository.fetchOnlineTicketTransaction(token, idWisata, event.offset, event.limit);

      dataTransaction.fold((failure) {
        emit(FailedShowOnlineTicket(failure.error ?? ""));
      }, (dataTransaction) {
        if (dataTransaction.code == 401) {
          emit(ShowTokenExpired(dataTransaction.message));
          return;
        }
        emit(SuccessShowOnlineTicket(dataTransaction.data, dataTransaction.length));
      });
    });
  }
}
