abstract class TicketPaymentStatusState {}

class InitiateTicketPaymentStatusState extends TicketPaymentStatusState {}

class LoadingTicketPaymentStatus extends TicketPaymentStatusState {}

class SuccessShowTicketPayment extends TicketPaymentStatusState {
  final List<String> ticketCodes;
  final String wisataName;
  SuccessShowTicketPayment({required this.ticketCodes, required this.wisataName});
}

class FailedShowTicketPayment extends TicketPaymentStatusState {
  String message;
  FailedShowTicketPayment(this.message);
}
