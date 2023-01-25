import 'package:pad_lampung/core/data/model/response/scan_ticket_response.dart';

abstract class TicketScanState {}

class InitiateTicketScanState extends TicketScanState {}

class LoadingTicketScan extends TicketScanState {}

class SuccessScanTicket extends TicketScanState {
  final List<DataTicketMasuk> data;

  SuccessScanTicket(this.data);

}

class FailedScanTicket extends TicketScanState {
  String message;
  FailedScanTicket(this.message);
}

class ShowTokenExpired extends TicketScanState {
  String message;
  ShowTokenExpired(this.message);
}