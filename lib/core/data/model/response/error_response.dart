import 'dart:convert';

class ErrorResponse {
  ErrorResponse({
    required this.error,
  });

  String? error;


  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    error: json["message"] ?? null,
  );
}
