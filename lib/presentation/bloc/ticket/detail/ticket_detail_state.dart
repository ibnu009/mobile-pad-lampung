
abstract class TicketDetailState {}

class InitiateTicketDetailState extends TicketDetailState {}

class LoadingTicketDetail extends TicketDetailState {}

class SuccessShowTicketDetail extends TicketDetailState {
  final String tanggal;
  final int quantity;
  SuccessShowTicketDetail(this.tanggal, this.quantity);
}

class FailedShowTicketDetail extends TicketDetailState {
  String message;
  FailedShowTicketDetail(this.message);
}
