abstract class LoginEvent {}

class LoginUser extends LoginEvent {
  final String email, password;

  LoginUser({
    required this.email,
    required this.password,
  });
}

class LogoutUser extends LoginEvent {}