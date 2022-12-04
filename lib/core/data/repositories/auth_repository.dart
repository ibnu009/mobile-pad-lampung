import 'package:pad_lampung/common/failure.dart';
import 'package:pad_lampung/core/data/model/request/login_request.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:dartz/dartz.dart';

import '../model/response/error_response.dart';
import '../sources/remote/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSourceImpl dataSource;

  AuthRepository(this.dataSource);

  final String applicationJson = "application/json; charset=UTF-8";

  Future<Either<ErrorResponse, LoginResponse>> submitLogin(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);
    return dataSource.loginUser(request);
  }
}
