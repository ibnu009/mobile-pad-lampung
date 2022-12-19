

abstract class TicketDetailEvent {}

class GetTicketDetail extends TicketDetailEvent {
  final String transactionNumber;
  GetTicketDetail(this.transactionNumber);
}
