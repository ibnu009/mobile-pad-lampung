
import 'package:pad_lampung/core/data/model/holder/parking_home_content_holder.dart';

import '../../../../core/data/model/response/parking_response.dart';

abstract class ParkingHomeState {}

class InitiateParkingHomeState extends ParkingHomeState {}

class LoadingParkingHome extends ParkingHomeState {}

class SuccessShowParkingingData extends ParkingHomeState {
  final ParkingHomeContentHolder data;
  SuccessShowParkingingData(this.data);
}

class FailedShowParkingQuota extends ParkingHomeState {
  String message;
  FailedShowParkingQuota(this.message);
}

class ShowTokenExpired extends ParkingHomeState {
  String message;
  ShowTokenExpired(this.message);
}