import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import '../../../utils/delegate/generic_delegate.dart';
import 'ticket_detail_event.dart';
import 'ticket_detail_state.dart';

class TicketDetailBloc extends Bloc<TicketDetailEvent, TicketDetailState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketDetailBloc({required this.repository, required this.storage})
      : super(InitiateTicketDetailState()) {
    on<GetTicketDetail>((event, emit) async {
      emit(LoadingTicketDetail());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String ticketName = await storage.readSecureData(printerTicketKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";

      var data = await repository.fetchTicketTransactionDetail(
          token, event.transactionNumber);
      data.fold((failure) {
        emit(FailedShowTicketDetail(failure.error ?? ""));
      }, (response) {
        emit(SuccessShowTicketDetail(
            response.data.transaksiBookingTiket.scanTime,
            response.data.transaksiBookingTiket.jumlah,
            ticketName,
            wisataName));
      });
    });
  }
}
