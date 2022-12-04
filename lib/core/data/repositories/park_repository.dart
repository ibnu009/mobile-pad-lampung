import 'package:pad_lampung/common/failure.dart';
import 'package:pad_lampung/core/data/model/request/login_request.dart';
import 'package:pad_lampung/core/data/model/request/park_checkin_request.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:dartz/dartz.dart';

import '../model/request/park_checkout_request.dart';
import '../model/response/error_response.dart';
import '../sources/remote/auth_remote_data_source.dart';
import '../sources/remote/park_remote_data_source.dart';

class ParkRepository {
  final ParkRemoteDataSourceImpl dataSource;

  ParkRepository(this.dataSource);

  final String applicationJson = "application/json; charset=UTF-8";

  Future<Either<ErrorResponse, LoginResponse>> submitParkCheckIn(
      String noTransaksiPark, int locationId, String accessToken) async {
    ParkCheckInRequest request = ParkCheckInRequest(
        noTransaksiPark: noTransaksiPark, locationId: locationId);
    return dataSource.parkingCheckIn(request, accessToken);
  }

  Future<Either<ErrorResponse, LoginResponse>> submitParkCheckOut(
      String noTransaksiPark, int vehicleTypeId, int fee, String accessToken) async {
    ParkCheckOutRequest request = ParkCheckOutRequest(
      noTransaksiPark: noTransaksiPark,
      jenisKendaraan: vehicleTypeId,
      tarif: fee,
    );
    return dataSource.parkingCheckOut(request, accessToken);
  }
}
