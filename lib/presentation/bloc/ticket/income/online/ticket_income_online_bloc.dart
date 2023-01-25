import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/ticket_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import 'ticket_income_online_event.dart';
import 'ticket_income_online_state.dart';

class TicketIncomeOnlineBloc
    extends Bloc<TicketIncomeOnlineEvent, TicketIncomeOnlineState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketIncomeOnlineBloc({required this.repository, required this.storage})
      : super(InitiateTicketIncomeOnlineState()) {
    on<GetOnlineTicketIncome>((event, emit) async {
      emit(LoadingTicketIncomeOnline());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";
      String petugasName = await storage.readSecureData(petugasNameKey) ?? "";

      var data = await repository.fetchOnlineIncomeTicket(
          token, idWisata, event.offset, event.limit);

      data.fold((failure) {
        emit(FailedShowOnlineTicket(failure.error ?? ""));
      }, (data) {
        if (data.code == 401) {
          emit(ShowTokenExpiredIncomeOnline(data.message));
          return;
        }
        emit(SuccessShowOnlineTicketIncome(data.data, data.length, data.grandTotal, data.namaPegawai, data.total));
      });
    });
  }
}
