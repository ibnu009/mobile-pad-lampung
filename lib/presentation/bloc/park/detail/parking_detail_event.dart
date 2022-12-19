import '../../../utils/delegate/generic_delegate.dart';

abstract class ParkingDetailEvent {}

class GetParkingDetail extends ParkingDetailEvent {
  final String transactionNumber;
  GetParkingDetail(this.transactionNumber);
}

class CheckOutParkingNew extends ParkingDetailEvent {
  final String transactionNumber, nopol;
  final GenericDelegate delegate;
  CheckOutParkingNew(this.transactionNumber, this.nopol, this.delegate);
}
