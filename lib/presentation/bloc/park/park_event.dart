import 'dart:io';

import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';

abstract class ParkEvent {}

class ParkingCheckIn extends ParkEvent {
  final String noParking;
  final int locationId;

  ParkingCheckIn({
    required this.noParking,
    required this.locationId,
  });
}

class ParkingCheckInWithOutBooking extends ParkEvent {
  final int idJenisKendaraan;
  final File fotoKendaraan;
  final GenericDelegate delegate;

  ParkingCheckInWithOutBooking( {
    required this.fotoKendaraan,
    required this.idJenisKendaraan,
    required this.delegate,
  });
}

class GetVehicleType extends ParkEvent {}

class ParkingCheckOut extends ParkEvent {
  final String noParking;
  final int vehicleTypeId, fee;

  ParkingCheckOut({
    required this.noParking,
    required this.vehicleTypeId,
    required this.fee,
  });
}
