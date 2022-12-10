import 'dart:convert';

TicketQuotaResponse ticketQuotaResponseFromJson(String str) => TicketQuotaResponse.fromJson(json.decode(str));

String ticketQuotaResponseToJson(TicketQuotaResponse data) => json.encode(data.toJson());

class TicketQuotaResponse {
  TicketQuotaResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  Data? data;

  factory TicketQuotaResponse.fromJson(Map<String, dynamic> json) => TicketQuotaResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    required this.jumlahTiketTerjual,
    required this.quota,
  });

  int jumlahTiketTerjual;
  int quota;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    jumlahTiketTerjual: json["jumlah_tiket_terjual"],
    quota: json["quota"],
  );

  Map<String, dynamic> toJson() => {
    "jumlah_tiket_terjual": jumlahTiketTerjual,
    "quota": quota,
  };
}
