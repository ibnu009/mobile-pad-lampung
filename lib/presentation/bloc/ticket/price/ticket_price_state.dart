
abstract class TicketPriceState {}

class InitiateTicketPriceState extends TicketPriceState {}

class LoadingTicketPrice extends TicketPriceState {}

class SuccessShowTicketPrice extends TicketPriceState {
  final int price, idTarif;
  SuccessShowTicketPrice(this.price, this.idTarif);
}

class FailedShowTicketPrice extends TicketPriceState {
  String message;
  FailedShowTicketPrice(this.message);
}
