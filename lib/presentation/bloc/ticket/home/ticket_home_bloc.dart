import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/holder/ticket_home_content_holder.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
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

      try {
        var data = await repository.fetchTicketHomeContent(token, idWisata);
        var dataTotal = await repository.fetchTicketIncomeTotal(token, idWisata);

        data.fold((failure) {
          print('failure data is ${failure.error}');
          emit(FailedShowTicketQuota(failure.error ?? ""));
        }, (data) {
          dataTotal.fold((failure) {
            print('failure dataTotal is $failure');
            emit(FailedShowTicketQuota(failure.error ?? ""));
          }, (dataTotalResponse) {
            if (data.code == 401 || dataTotalResponse.code == 401) {
              emit(ShowTokenExpiredHome(data.message));
              return;
            }

            TicketHomeContentHolder dataHolder = TicketHomeContentHolder(
                wisataName: wisataName,
                jumlahTiketTerjual: data.data[1].jumlahTiketTerjual,
                jumlahTransaksi: data.transactionTotal,
                quota: data.data[0].quota,
                totalTunai: dataTotalResponse.totalOffline,
                totalNonTunai: dataTotalResponse.totalOnline);

            emit(SuccessShowTicketQuota(dataHolder));
          });
        });
      } catch (e) {
        log(e.toString());
        emit(FailedShowTicketQuota("Terjadi kesalahan"));
      }
    });
  }
}
