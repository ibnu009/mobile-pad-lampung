import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pad_lampung/common/api_path.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/core/data/model/request/proses_transaksi_tiket_request.dart';
import 'package:pad_lampung/core/data/model/response/generic_response.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../../../../common/exception.dart';
import '../../model/response/error_response.dart';
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
      String dateNow = DateTime.now().toFormattedDate(format: 'yyyy-mm-dd');

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

  Future<Either<ErrorResponse, GenericResponse>> processTicketBooking(
      String accessToken, RequestProsesTransaksiTiket request) async {
    try {
      var header = {contentType: applicationJson, token: "Bearer $accessToken"};
      final response = await getMethod(
          "$BASE_URL/transaksi-booking/proses-booking", header);
      return Right(GenericResponse.fromJson(response));
    } on ServerException catch (e) {
      var res = json.decode(e.message);
      return Left(ErrorResponse.fromJson(res));
    } catch (ex) {
      return Left(ErrorResponse(error: 'Terjadi kesalahan'));
    }
  }
}
