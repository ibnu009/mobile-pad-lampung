import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../../core/data/repositories/park_repository.dart';
import 'park_home_event.dart';
import 'park_home_state.dart';

class ParkingHomeBloc extends Bloc<ParkingHomeEvent, ParkingHomeState> {
  final ParkRepository repository;
  final AppPreferences storage;

  ParkingHomeBloc({required this.repository, required this.storage})
      : super(InitiateParkingHomeState()) {
    on<GetParkingData>((event, emit) async {
      emit(LoadingParkingHome());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";
      String wisataName = await storage.readSecureData(wisataNameKey) ?? "";

      var data = await repository.fetchParkingData(token, idWisata, 1, 1);
      data.fold((failure) {
        emit(FailedShowParkingQuota(failure.error ?? ""));
      }, (data) {
        if (data.code == 401) {
          emit(ShowTokenExpired(data.message));
          return;
        }
        emit(SuccessShowParkingingData(data.data));
      });
    });
  }
}
