
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/auth_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../core/data/repositories/park_repository.dart';
import 'park_event.dart';
import 'park_state.dart';

class ParkBloc extends Bloc<ParkEvent, ParkState> {
  final ParkRepository repository;
  final AppPreferences storage;

  ParkBloc({required this.repository, required this.storage}) : super(InitiateParkState()) {

    on<ParkingCheckIn>((event, emit) async {
      emit(LoadingCheckInPark());
      String token = await storage.readSecureData(tokenKey) ?? "";
      print('token adalah $token');
      var data = await repository.submitParkCheckIn(event.noParking, event.locationId, token);
      data.fold((failure) {
        emit(FailedCheckInPark(failure.error ?? ""));
      }, (success) {
        emit(SuccessCheckInPark());
      });
    });

    on<ParkingCheckOut>((event, emit) async {
      emit(LoadingPark());
      String token = await storage.readSecureData(tokenKey) ?? "";
      print('token adalah $token');
      var data = await repository.submitParkCheckOut(event.noParking, event.vehicleTypeId, event.fee, token);
      data.fold((failure) {
        emit(FailedPark(failure.error ?? ""));
      }, (success) {
        emit(SuccessPark());
      });
    });

  }
}