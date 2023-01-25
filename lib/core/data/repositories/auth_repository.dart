import 'package:pad_lampung/common/failure.dart';
import 'package:pad_lampung/core/data/model/request/login_request.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/response/reset_password_response.dart';

import '../model/response/error_response.dart';
import '../sources/remote/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSourceImpl dataSource;

  AuthRepository(this.dataSource);

  Future<Either<ErrorResponse, LoginResponse>> submitLogin(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);
    return dataSource.loginUser(request);
  }

  Future<Either<ErrorResponse, ResetPasswordResponse>> resetPassword(String email) async {
    return dataSource.resetPassword(email);
  }

  Future<Either<ErrorResponse, GenericResponse>> confirmOtp(String email, String code) async {
    return dataSource.confirmOtp(email, code);
  }

  Future<Either<ErrorResponse, GenericResponse>> changePassword(String accessToken, String oldPassword, String newPassword) async {
    return dataSource.changePassword(accessToken, oldPassword, newPassword);
  }
}
