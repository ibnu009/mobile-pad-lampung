import 'package:pad_lampung/core/data/model/response/xendit_payment_method_response.dart';

abstract class MethodXenditState {}

class InitiateMethodXenditState extends MethodXenditState {}

class LoadingMethodXendit extends MethodXenditState {}

class FailedMethodXenditState extends MethodXenditState {
  String message;
  FailedMethodXenditState(this.message);
}

class ShowXenditMethodMethod extends MethodXenditState {
  final List<XenditPaymentMethod> data;
  ShowXenditMethodMethod(this.data);
}
