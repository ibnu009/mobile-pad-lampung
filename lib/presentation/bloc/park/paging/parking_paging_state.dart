import 'package:pad_lampung/core/data/model/response/parking_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';


abstract class ParkingPagingState {}

class InitiateParkingPagingState extends ParkingPagingState {}

class LoadingParkingPagingState extends ParkingPagingState {}

class SuccessShowParkingPagingData extends ParkingPagingState {
  final List<ParkingData> data;
  final int totalData;
  SuccessShowParkingPagingData(this.data, this.totalData);
}

class FailedShowParkingData extends ParkingPagingState {
  String message;
  FailedShowParkingData(this.message);
}

class ShowTokenPagingExpired extends ParkingPagingState {
  String message;
  ShowTokenPagingExpired(this.message);
}