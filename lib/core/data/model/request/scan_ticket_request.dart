import 'dart:convert';

RequestScanTicket requestScanTicketFromJson(String str) => RequestScanTicket.fromJson(json.decode(str));

String requestScanTicketToJson(RequestScanTicket data) => json.encode(data.toJson());

class RequestScanTicket {
  RequestScanTicket({
    required this.noTransaksi,
  });

  String noTransaksi;

  factory RequestScanTicket.fromJson(Map<String, dynamic> json) => RequestScanTicket(
    noTransaksi: json["no_transaksi"],
  );

  Map<String, dynamic> toJson() => {
    "no_transaksi": noTransaksi,
  };
}
