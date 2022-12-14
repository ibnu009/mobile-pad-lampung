import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/holder/ticket_home_content_holder.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../core/data/repositories/ticket_repository.dart';
import 'ticket_home_event.dart';
import 'ticket_home_state.dart';

class TicketHomeBloc extends Bloc<TicketHomeEvent, TicketHomeState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketHomeBloc({required this.repository, required this.storage})
      : super(InitiateTicketHomeState()) {
    on<GetTicketQuota>((event, emit) async {
      emit(LoadingTicketHome());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";

      var data = await repository.fetchTicketHomeContent(token, idWisata);
      var dataTransaction =
          await repository.fetchOnlineTicketTransaction(token, idWisata);

      data.fold((failure) {
        emit(FailedShowTicketQuota(failure.error ?? ""));
      }, (data) {
        dataTransaction.fold((failure) {
          emit(FailedShowTicketQuota(failure.error ?? ""));
        }, (dataTransaction) {

          TicketHomeContentHolder dataHolder = TicketHomeContentHolder(
              wisataName: wisataName,
              jumlahTiketTerjual: data.data?.jumlahTiketTerjual ?? 0,
              quota: data.data?.quota ?? 0,
              ticketTransactions: dataTransaction.data);

          if (data.code == 401) {
            emit(ShowTokenExpired(data.message));
            return;
          }

          emit(SuccessShowTicketQuota(dataHolder));
        });
      });
    });
  }
}
