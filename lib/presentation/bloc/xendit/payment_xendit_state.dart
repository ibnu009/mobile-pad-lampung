import 'package:pad_lampung/core/data/model/response/xendit_payment_method_response.dart';

abstract class PaymentXenditState {}

class InitiatePaymentXenditState extends PaymentXenditState {}

class LoadingPaymentXendit extends PaymentXenditState {}

class SuccessCreateXenditPayment extends PaymentXenditState {
  final String paymentUrl;
  SuccessCreateXenditPayment(this.paymentUrl);
}

class FailedPaymentXenditState extends PaymentXenditState {
  String message;
  FailedPaymentXenditState(this.message);
}

class ShowXenditPaymentMethod extends PaymentXenditState {
  final List<XenditPaymentMethod> data;
  ShowXenditPaymentMethod(this.data);
}
