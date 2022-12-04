abstract class ParkState {}

class InitiateParkState extends ParkState {}

class LoadingPark extends ParkState {}

class LoadingCheckInPark extends ParkState {}


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