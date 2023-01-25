import '../response/ticket_list_response.dart';

class TicketHomeContentHolder {
  TicketHomeContentHolder({
    required this.wisataName,
    required this.jumlahTiketTerjual,
    required this.jumlahTransaksi,
    required this.quota,
    required this.totalTunai,
    required this.totalNonTunai,
  });

  String wisataName;
  int jumlahTiketTerjual;
  int jumlahTransaksi;
  int quota;
  int totalTunai;
  int totalNonTunai;
}
