import '../../../utils/delegate/generic_delegate.dart';

abstract class TicketPriceEvent {}

class GetTicketPrice extends TicketPriceEvent {}

class ProcessTicketBooking extends TicketPriceEvent {
  final String paymentMethod;
  final int quantity, idTarif;
  final GenericDelegate delegate;

  ProcessTicketBooking(
      {required this.paymentMethod,
      required this.quantity,
      required this.idTarif,
      required this.delegate});
}
