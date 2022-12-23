import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/holder/ticket_home_content_holder.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import 'ticket_paging_event.dart';
import 'ticket_paging_state.dart';

class TicketPagingBloc extends Bloc<TicketPagingEvent, TicketPagingState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketPagingBloc({required this.repository, required this.storage})
      : super(InitiateTicketPagingState()) {
    on<GetTicket>((event, emit) async {
      emit(LoadingTicketPagingState());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";

      var dataTransaction =
          await repository.fetchEmployeeTicketTransaction(token, idWisata , event.offset, event.limit);

      dataTransaction.fold((failure) {
        emit(FailedShowTicketQuota(failure.error ?? ""));
      }, (data) {

        if (data.code == 401) {
          emit(ShowTokenExpired(data.message));
          return;
        }

        emit(SuccessShowTicketData(data.data, data.length));
      });
    });
  }
}
