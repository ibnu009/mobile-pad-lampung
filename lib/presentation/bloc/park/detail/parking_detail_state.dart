
import 'package:pad_lampung/core/data/model/response/detail_parking_response.dart';

abstract class ParkingDetailState {}

class InitiateParkingDetailState extends ParkingDetailState {}

class LoadingParkingDetail extends ParkingDetailState {}

class SuccessShowParkingDetail extends ParkingDetailState {
  final ParkingDataDetail data;
  SuccessShowParkingDetail(this.data);
}

class FailedShowParkingDetail extends ParkingDetailState {
  String message;
  FailedShowParkingDetail(this.message);
}
