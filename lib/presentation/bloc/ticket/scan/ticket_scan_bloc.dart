import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import 'ticket_scan_event.dart';
import 'ticket_scan_state.dart';

class TicketScanBloc extends Bloc<TicketScanEvent, TicketScanState> {
  final TicketRepository repository;
  final AppPreferences storage;

  TicketScanBloc({required this.repository, required this.storage})
      : super(InitiateTicketScanState()) {
    on<ScanTicket>((event, emit) async {
      emit(LoadingTicketScan());
      String token = await storage.readSecureData(tokenKey) ?? "";

      var data = await repository.scanTicket(token, event.transactionCode);

      data.fold((failure) {
        emit(FailedScanTicket(failure.error ?? ""));
      }, (data) {
        if (data.code == 401) {
          emit(ShowTokenExpired(data.message));
          return;
        }
        emit(SuccessScanTicket());
      });
    });
  }
}
