abstract class TicketPaymentStatusState {}

class InitiateTicketPaymentStatusState extends TicketPaymentStatusState {}

class LoadingTicketPaymentStatus extends TicketPaymentStatusState {}

class SuccessShowTicketPayment extends TicketPaymentStatusState {}

class FailedShowTicketPayment extends TicketPaymentStatusState {
  String message;
  FailedShowTicketPayment(this.message);
}
