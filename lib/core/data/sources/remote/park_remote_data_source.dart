import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pad_lampung/common/api_path.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/core/data/model/request/park_checkin_request.dart';
import 'package:pad_lampung/core/data/model/request/park_checkout_request.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';

import '../../../../common/exception.dart';
import '../../model/response/error_response.dart';
import '../../service/remote/network_service.dart';

class ParkRemoteDataSourceImpl extends NetworkService {
  ParkRemoteDataSourceImpl();

  ParkRemoteDataSourceImpl._privateConstructor();

  static final ParkRemoteDataSourceImpl _instance =
      ParkRemoteDataSourceImpl._privateConstructor();

  static ParkRemoteDataSourceImpl get instance => _instance;

  Future<Either<ErrorResponse, LoginResponse>> parkingCheckIn(ParkCheckInRequest request, String accessToken) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod("$BASE_URL/auth/parkir-masuk",
          body: request.toJson(), headers: header);
      return Right(LoginResponse.fromJson(response));
    } on ServerException catch(e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex){
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, LoginResponse>> parkingCheckOut(ParkCheckOutRequest request, String accessToken) async {
    try {

      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod("$BASE_URL/auth/parkir-keluar",
          body: request.toJson(), headers: header);

      return Right(LoginResponse.fromJson(response));
    } on ServerException catch(e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex){
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

}
