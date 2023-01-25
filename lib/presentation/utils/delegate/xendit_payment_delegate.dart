abstract class XenditPaymentDelegate {
  void onNeedRepeatRequest();
  void onPaymentSuccess(String transactionNumber);
  void onPaymentFailed(String message);
  void onPaymentCanceled();
}