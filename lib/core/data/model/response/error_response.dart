import 'dart:convert';

class ErrorResponse {
  ErrorResponse({
    this.error,
    this.message,
    this.code,
  });

  String? error;
  String? message;
  int? code;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        error: json["error"] ?? null,
        message: json["message"] ?? null,
        code: json["code"] ?? null,
      );
}
