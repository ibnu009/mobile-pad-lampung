import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/ticket_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import 'ticket_income_offline_event.dart';
import 'ticket_income_offline_state.dart';

class TicketIncomeOfflineBloc
    extends Bloc<TicketIncomeOfflineEvent, TicketIncomeOfflineState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketIncomeOfflineBloc({required this.repository, required this.storage})
      : super(InitiateTicketIncomeOfflineState()) {
    on<GetOfflineTicketIncome>((event, emit) async {
      emit(LoadingTicketIncomeOffline());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";
      String reportDevice =
          await storage.readSecureData(printerReportKey) ?? "";
      String petugasName = await storage.readSecureData(petugasNameKey) ?? "";

      var data = await repository.fetchOfflineIncomeTicket(
          token, idWisata, event.offset, event.limit);

      data.fold((failure) {
        emit(FailedShowOfflineTicket(failure.error ?? ""));
      }, (data) {
        if (data.code == 401) {
          emit(ShowTokenExpiredIncomeOffline(data.message));
          return;
        }
        emit(SuccessShowOfflineTicketIncome(
            data: data.data,
            totalData: data.length,
            grandTotal: data.grandTotal,
            wisataName: wisataName,
            operatorName: data.namaPegawai,
            deviceName: reportDevice,
            total: data.total));
      });
    });
  }
}
