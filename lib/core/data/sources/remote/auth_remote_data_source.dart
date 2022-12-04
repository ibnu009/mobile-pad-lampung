import 'dart:convert';

import 'package:pad_lampung/common/api_path.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/common/failure.dart';
import 'package:pad_lampung/core/data/model/request/login_request.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../common/exception.dart';
import '../../model/response/error_response.dart';
import '../../service/remote/network_service.dart';

class AuthRemoteDataSourceImpl extends NetworkService {
  AuthRemoteDataSourceImpl();

  AuthRemoteDataSourceImpl._privateConstructor();

  static final AuthRemoteDataSourceImpl _instance =
      AuthRemoteDataSourceImpl._privateConstructor();

  static AuthRemoteDataSourceImpl get instance => _instance;

  Future<Either<ErrorResponse, LoginResponse>> loginUser(LoginRequest request) async {
    try {
      final response = await postMethod("$BASE_URL/auth/mobile/login",
          body: request.toJson(), headers: genericHeader);
      print("masuk sini");
      return Right(LoginResponse.fromJson(response));
    } on ServerException catch(e) {
      print("masuk sanaaaa ${e.message}");
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    }
  }

}
