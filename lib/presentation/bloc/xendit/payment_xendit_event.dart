import 'package:pad_lampung/presentation/utils/delegate/xendit_payment_delegate.dart';

abstract class PaymentXenditEvent {}

class CreateXenditPayment extends PaymentXenditEvent {
  final String paymentMethod;
  final int quantity, idTarif, price, totalPrice, servicePrice;

  CreateXenditPayment(
      {required this.price,
      required this.totalPrice,
        required this.servicePrice,
        required this.paymentMethod,
      required this.quantity,
      required this.idTarif});
}

class CreateParkirXenditPayment extends PaymentXenditEvent {
  final String paymentMethod, noTransaksi;
  final int price, idTransaksi, servicePrice;

  CreateParkirXenditPayment({
    required this.paymentMethod,
    required this.noTransaksi,
    required this.price,
    required this.idTransaksi,
    required this.servicePrice
  });
}

class CheckXenditPayment extends PaymentXenditEvent {
  final XenditPaymentDelegate delegate;

  CheckXenditPayment(this.delegate);
}

class CancelXenditPayment extends PaymentXenditEvent {
  int? idTransaction;
  XenditPaymentDelegate? delegate;
  CancelXenditPayment({this.idTransaction, this.delegate});
}

class CancelParkirXenditPayment extends PaymentXenditEvent {}


class GetXenditPaymentMethod extends PaymentXenditEvent {}
