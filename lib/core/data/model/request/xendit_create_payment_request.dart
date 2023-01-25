// To parse this JSON data, do
//
//     final xenditCreatePaymentRequest = xenditCreatePaymentRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

XenditCreatePaymentRequest xenditCreatePaymentRequestFromJson(String str) => XenditCreatePaymentRequest.fromJson(json.decode(str));

String xenditCreatePaymentRequestToJson(XenditCreatePaymentRequest data) => json.encode(data.toJson());

class XenditCreatePaymentRequest {
  XenditCreatePaymentRequest({
    required this.externalId,
    required this.noTransaksi,
    required this.amount,
    required this.payerEmail,
    required this.description,
    required this.paymentMethods,
    required this.items,
  });

  String externalId;
  String noTransaksi;
  int amount;
  String payerEmail;
  String description;
  List<String> paymentMethods;
  List<PaymentItem> items;

  factory XenditCreatePaymentRequest.fromJson(Map<String, dynamic> json) => XenditCreatePaymentRequest(
    externalId: json["external_id"],
    noTransaksi: json["no_transaksi"],
    amount: json["amount"],
    payerEmail: json["payer_email"],
    description: json["description"],
    paymentMethods: List<String>.from(json["payment_methods"].map((x) => x)),
    items: List<PaymentItem>.from(json["items"].map((x) => PaymentItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "external_id": externalId,
    "amount": amount,
    "no_transaksi": noTransaksi,
    "payer_email": payerEmail,
    "description": description,
    "payment_methods": List<dynamic>.from(paymentMethods.map((x) => x)),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class PaymentItem {
  PaymentItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  String name;
  int quantity;
  int price;

  factory PaymentItem.fromJson(Map<String, dynamic> json) => PaymentItem(
    name: json["name"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "price": price,
  };
}
