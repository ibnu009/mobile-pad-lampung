import 'dart:convert';

TicketQuotaResponse ticketQuotaResponseFromJson(String str) => TicketQuotaResponse.fromJson(json.decode(str));

String ticketQuotaResponseToJson(TicketQuotaResponse data) => json.encode(data.toJson());

class TicketQuotaResponse {
  TicketQuotaResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
    required this.transactionTotal,
  });

  int code;
  bool status;
  String message;
  List<Data> data;
  int transactionTotal;

  factory TicketQuotaResponse.fromJson(Map<String, dynamic> json) => TicketQuotaResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    transactionTotal: json["jumlah_transaksi"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "jumlah_transaksi": transactionTotal,
  };
}

class Data {
  Data({
    required this.quota,
    required this.jumlahTiketTerjual,
  });

  int quota;
  int jumlahTiketTerjual;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    quota: json["quota"] ?? 0,
    jumlahTiketTerjual: json["jumlah_tiket_terjual"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "quota": quota,
    "jumlah_tiket_terjual": jumlahTiketTerjual,
  };
}
