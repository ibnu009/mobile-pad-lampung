abstract class LoginState {}

class InitiateLoginState extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {}

class FailedLogin extends LoginState {
  String message;
  FailedLogin(this.message);
}