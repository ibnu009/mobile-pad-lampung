abstract class TicketPagingEvent {}

class GetTicket extends TicketPagingEvent {
  final int offset, limit;

  GetTicket(this.offset, this.limit);
}