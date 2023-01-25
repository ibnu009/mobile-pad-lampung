import 'dart:convert';

ResponseTicket responseTicketFromJson(String str) => ResponseTicket.fromJson(json.decode(str));

String responseTicketToJson(ResponseTicket data) => json.encode(data.toJson());

class ResponseTicket {
  ResponseTicket({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
    required this.length,
  });

  int code;
  bool status;
  String message;
  List<Ticket> data;
  int length;

  factory ResponseTicket.fromJson(Map<String, dynamic> json) => ResponseTicket(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Ticket>.from(json["data"].map((x) => Ticket.fromJson(x))),
    length: json["length"] ?? 0
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "length": length
  };
}

class Ticket {
  Ticket({
    required this.id,
    required this.noTransaksi,
    required this.noTelp,
    required this.scanTime,
    required this.quantity,
  });

  int id;
  String noTransaksi;
  String noTelp;
  String scanTime;
  int quantity;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    noTransaksi: json["no_transaksi"],
    noTelp: json["no_telp"],
    scanTime: json["scan_time"] ?? '-',
    quantity: json["jumlah"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_transaksi": noTransaksi,
    "no_telp": noTelp,
    "scan_time": scanTime,
  };
}
