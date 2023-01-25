
abstract class TicketDetailState {}

class InitiateTicketDetailState extends TicketDetailState {}

class LoadingTicketDetail extends TicketDetailState {}

class SuccessShowTicketDetail extends TicketDetailState {
  final String tanggal, deviceName, wisataname;
  final int quantity;
  SuccessShowTicketDetail(this.tanggal, this.quantity, this.deviceName, this.wisataname);
}

class FailedShowTicketDetail extends TicketDetailState {
  String message;
  FailedShowTicketDetail(this.message);
}
