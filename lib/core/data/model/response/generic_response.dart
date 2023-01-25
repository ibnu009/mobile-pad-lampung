// To parse this JSON data, do
//
//     final ticketPriceResponse = ticketPriceResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenericResponse ticketPriceResponseFromJson(String str) => GenericResponse.fromJson(json.decode(str));

String ticketPriceResponseToJson(GenericResponse data) => json.encode(data.toJson());

class GenericResponse {
  GenericResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  dynamic data;


  factory GenericResponse.fromJson(Map<String, dynamic> json) => GenericResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
  };
}
