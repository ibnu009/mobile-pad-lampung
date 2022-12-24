import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:pad_lampung/common/api_path.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/core/data/model/request/proses_transaksi_tiket_request.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_income_total_response.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../../../../common/exception.dart';
import '../../model/response/error_response.dart';
import '../../model/response/scan_ticket_response.dart';
import '../../model/response/ticket_booking_response.dart';
import '../../model/response/ticket_detail_response.dart';
import '../../model/response/ticket_income_response.dart';
import '../../model/response/ticket_list_response.dart';
import '../../model/response/ticket_price_response.dart';
import '../../model/response/ticket_quota_response.dart';
import '../../service/remote/network_service.dart';

class TicketRemoteDataSourceImpl extends NetworkService {
  TicketRemoteDataSourceImpl();

  TicketRemoteDataSourceImpl._privateConstructor();

  static final TicketRemoteDataSourceImpl _instance =
      TicketRemoteDataSourceImpl._privateConstructor();

  static TicketRemoteDataSourceImpl get instance => _instance;

  Future<Either<ErrorResponse, TicketQuotaResponse>> fetchTicketQuota(
      String accessToken, String idWisata) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      String dateNow = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');

      final response = await getMethod(
          "$BASE_URL/tempat-wisata/status-quota-tiket/$idWisata/$dateNow",
          header);

      return Right(TicketQuotaResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseTicketIncomeTotal>> fetchIncomeTotal(
      String accessToken, String idWisata) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      String dateNow = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');

      final response = await getMethod(
          "$BASE_URL/transaksi-booking/report_custom/$dateNow",
          header);

      return Right(ResponseTicketIncomeTotal.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, TicketPriceResponse>> fetchTicketPrice(
      String accessToken, String idWisata) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/tarif-tiket/get-by-id-tempat-wisata/$idWisata", header);
      return Right(TicketPriceResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseProsesTransaksiTiket>>
      processTicketBooking(
          String accessToken, RequestProsesTransaksiTiket request) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod(
          "$BASE_URL/transaksi-booking/proses-booking",
          body: request.toJson(),
          headers: header);
      return Right(ResponseProsesTransaksiTiket.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      log('Error is $ex');
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, GenericResponse>> checkPaymentStatus(
      String accessToken, String transactionNumber) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-booking/konfirmasi-pembayaran/$transactionNumber",
          header);
      return Right(GenericResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      log('Error is $ex');
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseTicket>> fetchTicketTransactionList(
      String accessToken,
      String idWisata,
      String todayDate,
      bool isOnline, int offset, int limit) async {
    print('isOnline $isOnline');
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-booking-tiket/get-by-tanggal/$idWisata/$todayDate/$isOnline?limit=$limit&offset=$offset",
          header);
      return Right(ResponseTicket.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      log('Error is $ex', stackTrace: stackTrace);
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseIncomeTicket>> fetchTicketIncomeList(
      String accessToken,
      String idWisata,
      String todayDate,
      bool isOnline, int offset, int limit) async {
    print('isOnline $isOnline');
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-booking/report/$todayDate/$isOnline?limit=$limit&offset=$offset",
          header);
      return Right(ResponseIncomeTicket.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      log('Error is $ex', stackTrace: stackTrace);
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseScanTicket>> scanOnlineTicket(
      String accessToken, String noTransaksi) async {
    try {
      Map<String, dynamic> body = {
        "no_transaksi": noTransaksi,
      };

      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await postMethod(
          "$BASE_URL/transaksi-booking-tiket/scan",
          headers: header,
          body: body);

      return Right(ResponseScanTicket.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      log('Error is $ex', stackTrace: stackTrace);
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }

  Future<Either<ErrorResponse, ResponseDetailTicket>> fetchTicketTransactionDetail(
      String accessToken, String transactionNumber) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-booking/get-by-no-transaksi/$transactionNumber",
          header);
      return Right(ResponseDetailTicket.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } on Exception catch (ex, stackTrace) {
      log('Error is $ex', stackTrace: stackTrace);
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }
}
