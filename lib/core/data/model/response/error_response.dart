import 'dart:convert';

class ErrorResponse {
  ErrorResponse({
    required this.error,
    this.code,
  });

  String? error;
  int? code;


  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    error: json["message"] ?? null,
    code: json["code"] ?? null,
  );
}
