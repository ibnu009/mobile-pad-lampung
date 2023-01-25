import 'dart:convert';

XenditPaymentMethodResponse xenditPaymentMethodResponseFromJson(String str) => XenditPaymentMethodResponse.fromJson(json.decode(str));

String xenditPaymentMethodResponseToJson(XenditPaymentMethodResponse data) => json.encode(data.toJson());

class XenditPaymentMethodResponse {
  XenditPaymentMethodResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  List<XenditPaymentMethod> data;

  factory XenditPaymentMethodResponse.fromJson(Map<String, dynamic> json) => XenditPaymentMethodResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<XenditPaymentMethod>.from(json["data"].map((x) => XenditPaymentMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class XenditPaymentMethod {
  XenditPaymentMethod({
    required this.id,
    required this.bankName,
    required this.bankCode,
    required this.costType,
    required this.costValue,
    required this.bankImage,
  });

  int id;
  String bankName;
  String bankCode;
  String costType;
  double costValue;
  String bankImage;

  factory XenditPaymentMethod.fromJson(Map<String, dynamic> json) => XenditPaymentMethod(
    id: json["id"],
    bankName: json["bank_name"],
    bankCode: json["bank_code"],
    costType: json["cost_type"],
    costValue: json["cost_value"].toDouble(),
    bankImage: json["bank_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "bank_code": bankCode,
    "cost_type": costType,
    "cost_value": costValue,
    "bank_image": bankImage,
  };
}
