// To parse this JSON data, do
//
//     final ticketPriceResponse = ticketPriceResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TicketPriceResponse ticketPriceResponseFromJson(String str) => TicketPriceResponse.fromJson(json.decode(str));

String ticketPriceResponseToJson(TicketPriceResponse data) => json.encode(data.toJson());

class TicketPriceResponse {
  TicketPriceResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  Data data;

  factory TicketPriceResponse.fromJson(Map<String, dynamic> json) => TicketPriceResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.idTempatWisata,
    required this.tarifWeekend,
    required this.tarifWeekday,
    required this.createdAt,
    required this.updatedAt,
    required this.quota,
  });

  int id;
  int idTempatWisata;
  int tarifWeekend;
  int tarifWeekday;
  DateTime createdAt;
  DateTime updatedAt;
  int quota;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    idTempatWisata: json["id_tempat_wisata"],
    tarifWeekend: json["tarif_weekend"],
    tarifWeekday: json["tarif_weekday"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    quota: json["quota"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_tempat_wisata": idTempatWisata,
    "tarif_weekend": tarifWeekend,
    "tarif_weekday": tarifWeekday,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "quota": quota,
  };
}
