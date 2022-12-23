import 'dart:io';

import 'package:pad_lampung/common/failure.dart';
import 'package:pad_lampung/core/data/model/request/login_request.dart';
import 'package:pad_lampung/core/data/model/request/park_checkin_request.dart';
import 'package:pad_lampung/core/data/model/response/detail_parking_response.dart';
import 'package:pad_lampung/core/data/model/response/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:pad_lampung/core/data/model/response/parking_response.dart';
import 'package:pad_lampung/presentation/bloc/park/park_event.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../model/request/masuk_tanpa_booking_request.dart';
import '../model/request/park_checkout_request.dart';
import '../model/response/error_response.dart';
import '../model/response/generic_response.dart';
import '../model/response/jenis_kendaraan_response.dart';
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
      String noTransaksiPark,
      int vehicleTypeId,
      int fee,
      String accessToken) async {
    ParkCheckOutRequest request = ParkCheckOutRequest(
      noTransaksiPark: noTransaksiPark,
      jenisKendaraan: vehicleTypeId,
      tarif: fee,
    );
    return dataSource.parkingCheckOut(request, accessToken);
  }

  Future<Either<ErrorResponse, GenericResponse>> checkInTanpaBooking(
      File fotoKendaraan,
      int locationId,
      int idJenisKendaraan,
      String accessToken) async {
    RequestMasukTanpaBooking request = RequestMasukTanpaBooking(
        idTempatWisata: locationId,
        idJenisKendaraan: idJenisKendaraan,
        fotoKendaraan: fotoKendaraan);
    return dataSource.parkingCheckInTanpaBooking(request, accessToken);
  }

  Future<Either<ErrorResponse, ResponseJenisKendaraan>> fetchVehicleType(
      String accessToken) async {
    return dataSource.fetchVehicleType(accessToken);
  }

  Future<Either<ErrorResponse, ResponseParking>> fetchParkingData(
      String accessToken, String idWisata, int limit, int offset, ) async {
    String today = DateTime.now().toFormattedDate(format: 'yyyy-MM-dd');
    return dataSource.fetchParkingTransactionList(accessToken, idWisata, today, limit, offset);
  }

  Future<Either<ErrorResponse, ResponseDetailParking>> fetchDetailParking(
      String accessToken, String noTransaksi) async {
    return dataSource.fetchParkingTransactionDetail(accessToken, noTransaksi);
  }

  Future<Either<ErrorResponse, GenericResponse>> checkOutParkingNew(
      String noTransaksi,  String nopol,  String accessToken) async {
    return dataSource.parkingCheckOutNew(noTransaksi, nopol, accessToken);
  }
}
