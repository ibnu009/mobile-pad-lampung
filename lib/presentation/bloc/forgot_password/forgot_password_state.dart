abstract class ForgotPasswordState {}

class InitiateForgotPasswordState extends ForgotPasswordState {}

class LoadingForgotPassword extends ForgotPasswordState {}

class SuccessForgotPassword extends ForgotPasswordState {
  String temporaryToken;
  SuccessForgotPassword(this.temporaryToken);
}

class SuccessActivateOtp extends ForgotPasswordState {
  String temporaryToken;
  int userType;
  SuccessActivateOtp(this.temporaryToken, this.userType);
}

class SuccessOtp extends ForgotPasswordState {}

class FailedForgotPassword extends ForgotPasswordState {
  String message;
  FailedForgotPassword(this.message);
}