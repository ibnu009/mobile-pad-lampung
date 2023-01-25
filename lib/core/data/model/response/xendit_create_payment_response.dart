class XenditCreatePaymentResponse {
  XenditCreatePaymentResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  XenditData data;

  factory XenditCreatePaymentResponse.fromJson(Map<String, dynamic> json) => XenditCreatePaymentResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: XenditData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class XenditData {
  XenditData({
    required this.id,
    required this.externalId,
    required this.status,
    required this.merchantName,
    required this.amount,
    required this.description,
    required this.expiryDate,
    required this.invoiceUrl,
  });

  String id;
  String externalId;
  String status;
  String merchantName;
  int amount;
  String description;
  DateTime expiryDate;
  String invoiceUrl;

  factory XenditData.fromJson(Map<String, dynamic> json) => XenditData(
    id: json["id"],
    externalId: json["external_id"],
    status: json["status"],
    merchantName: json["merchant_name"],
    amount: json["amount"],
    description: json["description"],
    expiryDate: DateTime.parse(json["expiry_date"]),
    invoiceUrl: json["invoice_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "external_id": externalId,
    "status": status,
    "merchant_name": merchantName,
    "amount": amount,
    "description": description,
    "expiry_date": expiryDate.toIso8601String(),
    "invoice_url": invoiceUrl,
  };
}
