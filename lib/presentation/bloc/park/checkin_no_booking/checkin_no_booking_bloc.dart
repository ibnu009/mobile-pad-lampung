import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/park_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';

import 'checkin_no_booking_event.dart';
import 'checkin_no_booking_state.dart';

class CheckInNoBookingBloc extends Bloc<CheckInNoBookingEvent, CheckInNoBookingState> {
  final ParkRepository repository;
  final AppPreferences storage;

  CheckInNoBookingBloc({required this.repository, required this.storage})
      : super(InitiateCheckInNoBookingState()) {

    GenericDelegate? delegate;

    on<ParkingCheckInWithOutBooking>((event, emit) async {
      delegate = event.delegate;
      delegate?.onLoading();
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "1";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";
      String ticketPrinter = await storage.readSecureData(printerTicketKey) ?? "";

      print('token adalah $token dan id is ${event.idJenisKendaraan}');

      var data = await repository.checkInTanpaBooking(
          event.fotoKendaraan, int.parse(idWisata), event.idJenisKendaraan, token);
      data.fold((failure) {
        delegate?.onFailed(failure.error ?? "");
      }, (success) {
        delegate?.onSuccess('$wisataName, ${success.data}, $ticketPrinter');
      });
    });

    on<GetVehicleType>((event, emit) async {
      emit(LoadingGetVehicleType());
      String token = await storage.readSecureData(tokenKey) ?? "";
      print('token adalah $token');
      var data = await repository.fetchVehicleType(token);
      data.fold((failure) {
        emit(FailedGetVehicleType(failure.error ?? ""));
      }, (success) {
        emit(SuccessGetVehicleType(success.data));
      });
    });
  }
}
