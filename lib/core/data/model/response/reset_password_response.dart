// To parse this JSON data, do
//
//     final ticketPriceResponse = ticketPriceResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ResetPasswordResponse {
  ResetPasswordResponse({
    required this.code,
    required this.newPassword,
    required this.message,
  });

  int code;
  String newPassword;
  String message;

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
    code: json["code"],
    newPassword: json["new_password"],
    message: json["message"],
  );
}
