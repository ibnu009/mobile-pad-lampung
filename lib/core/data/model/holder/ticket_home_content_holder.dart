import '../response/ticket_list_response.dart';

class TicketHomeContentHolder {
  TicketHomeContentHolder({
    required this.wisataName,
    required this.jumlahTiketTerjual,
    required this.quota,
    required this.ticketTransactions,
  });

  String wisataName;
  int jumlahTiketTerjual;
  int quota;
  List<Ticket> ticketTransactions;

}