import 'dart:convert';

class LastTransactionHolder {
  LastTransactionHolder({
    required this.totalPrice,
    required this.price,
    required this.quantity,
    required this.servicePrice,
    this.idTarif,
    this.idTransaction,
    required this.paymentMethod,
    required this.noTransaksi,
    required this.invoiceId,
    required this.urlPayment,
  });

  int totalPrice;
  int price;
  int quantity;
  int servicePrice;
  int? idTarif;
  int? idTransaction;
  String paymentMethod;
  String noTransaksi;
  String invoiceId;
  String urlPayment;

  factory LastTransactionHolder.fromJson(String source) {
    Map<String, dynamic> res = json.decode(source);
    return LastTransactionHolder(
      totalPrice: res['totalPrice'],
      price: res['price'],
      quantity: res['quantity'],
      paymentMethod: res['paymentMethod'],
      noTransaksi: res['noTransaksi'],
      invoiceId: res['invoiceId'],
      urlPayment: res['urlPayment'],
      servicePrice: res['servicePrice'],
      idTransaction: res['idTransaction'],
      idTarif: res['idTarif'],
    );
  }

  String toJsonString() => jsonEncode({
        "totalPrice": totalPrice,
        "price": price,
        "quantity": quantity,
        "idTransaction": idTransaction,
        "idTarif": idTarif,
        "paymentMethod": paymentMethod,
        "noTransaksi": noTransaksi,
        "invoiceId": invoiceId,
        "urlPayment": urlPayment,
        "servicePrice": servicePrice,
      });
}
