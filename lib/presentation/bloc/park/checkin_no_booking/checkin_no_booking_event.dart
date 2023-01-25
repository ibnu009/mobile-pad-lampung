import 'dart:io';

import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';

abstract class CheckInNoBookingEvent {}

class ParkingCheckInWithOutBooking extends CheckInNoBookingEvent {
  final int idJenisKendaraan;
  final File fotoKendaraan;
  final GenericDelegate delegate;

  ParkingCheckInWithOutBooking( {
    required this.fotoKendaraan,
    required this.idJenisKendaraan,
    required this.delegate,
  });
}

class GetVehicleType extends CheckInNoBookingEvent {}