abstract class TicketPaymentStatusEvent {}

class GetPaymentStatus extends TicketPaymentStatusEvent {
  String transactionNumber;
  GetPaymentStatus(this.transactionNumber);
}