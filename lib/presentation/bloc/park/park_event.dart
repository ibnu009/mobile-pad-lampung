abstract class ParkEvent {}

class ParkingCheckIn extends ParkEvent {
  final String noParking;
  final int locationId;

  ParkingCheckIn({
    required this.noParking,
    required this.locationId,
  });
}

class ParkingCheckOut extends ParkEvent {
  final String noParking;
  final int vehicleTypeId, fee;

  ParkingCheckOut({
    required this.noParking,
    required this.vehicleTypeId,
    required this.fee,
  });
}