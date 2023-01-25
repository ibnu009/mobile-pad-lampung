import 'package:pad_lampung/core/data/model/response/parking_quota_response.dart';

class ParkingHomeContentHolder {
  ParkingHomeContentHolder({
    required this.wisataName,
    required this.motorQuota,
    required this.carQuota,
    required this.busQuota,
    required this.vehicleTotal,

  });

  String wisataName;
  ParkingQuota? motorQuota;
  ParkingQuota? carQuota;
  ParkingQuota? busQuota;
  int vehicleTotal;
}
