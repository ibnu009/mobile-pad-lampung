abstract class TicketPriceEvent {}

class GetTicketPrice extends TicketPriceEvent {}

class ProcessTicketBooking extends TicketPriceEvent {
  final String paymentMethod;
  final int quantity, idTarif;

  ProcessTicketBooking(
      {required this.paymentMethod,
      required this.quantity,
      required this.idTarif});
}
