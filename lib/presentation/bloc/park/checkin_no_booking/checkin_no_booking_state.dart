import '../../../../core/data/model/response/jenis_kendaraan_response.dart';

abstract class CheckInNoBookingState {}

class InitiateCheckInNoBookingState extends CheckInNoBookingState {}

class LoadingGetVehicleType extends CheckInNoBookingState {}

class SuccessGetVehicleType extends CheckInNoBookingState {
  final List<VehicleType> data;

  SuccessGetVehicleType(this.data);
}

class FailedGetVehicleType extends CheckInNoBookingState {
  String message;
  FailedGetVehicleType(this.message);
}