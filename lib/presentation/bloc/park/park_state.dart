import '../../../core/data/model/response/jenis_kendaraan_response.dart';

abstract class ParkState {}

class InitiateParkState extends ParkState {}

class LoadingPark extends ParkState {}

class LoadingCheckInPark extends ParkState {}

class LoadingGetVehicleType extends ParkState {}

class SuccessGetVehicleType extends ParkState {
  final List<VehicleType> data;

  SuccessGetVehicleType(this.data);
}

class FailedGetVehicleType extends ParkState {
  String message;
  FailedGetVehicleType(this.message);
}


class SuccessPark extends ParkState {}

class SuccessCheckInPark extends ParkState {}

class FailedPark extends ParkState {
  String message;
  FailedPark(this.message);
}

class FailedCheckInPark extends ParkState {
  String message;
  FailedCheckInPark(this.message);
}