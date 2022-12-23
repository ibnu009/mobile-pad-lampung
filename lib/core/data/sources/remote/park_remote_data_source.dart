import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:pad_lampung/common/api_path.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/core/data/model/request/masuk_tanpa_booking_request.dart';
import 'package:pad_lampung/core/data/model/request/park_checkin_request.dart';
import 'package:pad_lampung/core/data/model/request/park_checkout_request.dart';
import 'package:pad_lampung/core/data/model/response/detail_parking_response.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:pad_lampung/core/data/model/response/parking_response.dart';

import '../../../../common/exception.dart';
import '../../model/response/error_response.dart';
import '../../model/response/jenis_kendaraan_response.dart';
import '../../service/remote/network_service.dart';

class ParkRemoteDataSourceImpl extends NetworkService {
  ParkRemoteDataSourceImpl();

  ParkRemoteDataSourceImpl._privateConstructor();

  static final ParkRemoteDataSourceImpl _instance =
      ParkRemoteDataSourceImpl._privateConstructor();

  static ParkRemoteDataSourceImpl get instance => _instance;

  Future<Either<ErrorResponse, LoginResponse>> parkingCheckIn(
      ParkCheckInRequest request, String accessToken) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod("$BASE_URL/auth/parkir-masuk",
          body: request.toJson(), headers: header);
      return Right(LoginResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, LoginResponse>> parkingCheckOut(
      ParkCheckOutRequest request, String accessToken) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod("$BASE_URL/auth/parkir-keluar",
          body: request.toJson(), headers: header);

      return Right(LoginResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, GenericResponse>> parkingCheckInTanpaBooking(
      RequestMasukTanpaBooking request, String accessToken) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};

      var body = {
        "id_tempat_wisata" : "${request.idTempatWisata}",
        "id_jenis_kendaraan" : "${request.idJenisKendaraan}",
      };

      debugPrint('id IS ${request.idJenisKendaraan}');

      final response = await multipartPostNew("$BASE_URL/transaksi-parkir/masuk-parkir",
          body: body, header: header, file: request.fotoKendaraan);
      return Right(GenericResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      debugPrint('Error is $ex. ${stackTrace}');
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseJenisKendaraan>> fetchVehicleType(String accessToken) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod("$BASE_URL/jenis-kendaraan", header);
      return Right(ResponseJenisKendaraan.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseParking>> fetchParkingTransactionList(
      String accessToken,
      String idWisata,
      String todayDate, int limit, int offset) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-parkir/get-by-tanggal/$idWisata/$todayDate?limit=$limit&offset=$offset",
          header);
      return Right(ResponseParking.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      log('Error is $ex', stackTrace: stackTrace);
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, GenericResponse>> parkingCheckOutNew(
      String noTransaksi,  String nopol,  String accessToken) async {

    var body = {
      "no_transaksi_parkir": noTransaksi,
      "nopol": nopol
    };

    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod("$BASE_URL/transaksi-parkir/keluar-parkir",
          body: body, headers: header);

      return Right(GenericResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseDetailParking>> fetchParkingTransactionDetail(
      String accessToken, String transactionNumber) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-parkir/get-by-no-transaksi-parkir/$transactionNumber",
          header);
      return Right(ResponseDetailParking.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      log('Error is $ex', stackTrace: stackTrace);
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

}
