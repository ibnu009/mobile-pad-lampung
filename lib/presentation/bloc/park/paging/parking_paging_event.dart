abstract class ParkingPagingEvent {}

class GetParking extends ParkingPagingEvent {
  final int offset, limit;

  GetParking({required this.offset, required this.limit});
}