abstract class TicketScanState {}

class InitiateTicketScanState extends TicketScanState {}

class LoadingTicketScan extends TicketScanState {}

class SuccessScanTicket extends TicketScanState {
  final String message;

  SuccessScanTicket(this.message);

}

class FailedScanTicket extends TicketScanState {
  String message;
  FailedScanTicket(this.message);
}

class ShowTokenExpired extends TicketScanState {
  String message;
  ShowTokenExpired(this.message);
}