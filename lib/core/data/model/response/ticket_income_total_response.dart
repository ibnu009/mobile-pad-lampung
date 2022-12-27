import 'dart:convert';

ResponseTicketIncomeTotal responseTicketIncomeFromJson(String str) => ResponseTicketIncomeTotal.fromJson(json.decode(str));

String responseTicketIncomeToJson(ResponseTicketIncomeTotal data) => json.encode(data.toJson());

class ResponseTicketIncomeTotal {
  ResponseTicketIncomeTotal({
    required this.code,
    required this.status,
    required this.message,
    required this.totalOffline,
    required this.totalOnline,
  });

  int code;
  bool status;
  String message;
  int totalOffline;
  int totalOnline;

  factory ResponseTicketIncomeTotal.fromJson(Map<String, dynamic> json) => ResponseTicketIncomeTotal(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    totalOffline: json["total_offline"],
    totalOnline: json["total_online"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "total_offline": totalOffline,
    "total_online": totalOnline,
  };
}
