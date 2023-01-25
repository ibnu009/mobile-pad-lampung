import 'dart:convert';

import 'package:pad_lampung/common/api_path.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/core/data/model/request/login_request.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/response/reset_password_response.dart';

import '../../../../common/exception.dart';
import '../../model/response/error_response.dart';
import '../../service/remote/network_service.dart';

class AuthRemoteDataSourceImpl extends NetworkService  {
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

  Future<Either<ErrorResponse, ResetPasswordResponse>> resetPassword(String email) async {
    try {

      var body = {
        "email": email,
      };

      final response = await postMethod("$BASE_URL/reset-password-mobile",
          body: body, headers: genericHeader);
      return Right(ResetPasswordResponse.fromJson(response));
    } on ServerException catch(e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (e) {
      return Left(ErrorResponse(error: "Terjadi Kesalahan"));
    }
  }

  Future<Either<ErrorResponse, GenericResponse>> confirmOtp(String email, String code) async {
    try {

      var body = {
        "email": email,
        "otp": code
      };

      final response = await postMethod("$BASE_URL/confirmation-otp-mobile",
          body: body, headers: genericHeader);
      return Right(GenericResponse.fromJson(response));
    } on ServerException catch(e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (e) {
      return Left(ErrorResponse(error: "Terjadi Kesalahan"));
    }
  }

  Future<Either<ErrorResponse, GenericResponse>> changePassword(String accessToken, String oldPassword, String newPassword ) async {
    try {

      var body = {
        "password": oldPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPassword,
      };
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};

      final response = await postMethod("$BASE_URL/auth/change-password",
          body: body, headers: header);
      return Right(GenericResponse.fromJson(response));
    } on ServerException catch(e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (e) {
      return Left(ErrorResponse(error: "Terjadi Kesalahan"));
    }
  }

}
