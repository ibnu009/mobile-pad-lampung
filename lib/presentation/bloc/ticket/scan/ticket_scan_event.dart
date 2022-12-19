abstract class TicketScanEvent {}

class ScanTicket extends TicketScanEvent {
  final String transactionCode;

  ScanTicket(this.transactionCode);

}