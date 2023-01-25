abstract class ForgotPasswordEvent {}

class ResetPassword extends ForgotPasswordEvent {
  final String email;

  ResetPassword({
    required this.email,
  });
}

class SendOtpConfirmation extends ForgotPasswordEvent {
  final String email, otp;

  SendOtpConfirmation({
    required this.email,
    required this.otp,
  });
}


class SendChangePasswordRequest extends ForgotPasswordEvent {
  final String newPassword;
  final String tempToken;

  SendChangePasswordRequest({
    required this.newPassword,
    required this.tempToken,
  });
}

class HandleOtpSuccess extends ForgotPasswordEvent {
  final String email;

  HandleOtpSuccess({
    required this.email,
  });
}