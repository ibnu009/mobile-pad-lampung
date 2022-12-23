abstract class TicketOnlineEvent {}

class GetOnlineTicketBooking extends TicketOnlineEvent {
  final int offset, limit;
  final String query;
  GetOnlineTicketBooking( {required this.offset, required this.limit, required this.query,});
}