import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/holder/parking_home_content_holder.dart';
import 'package:pad_lampung/core/data/model/response/parking_quota_response.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/extension/iterable_ext.dart';

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

      var data = await repository.fetchParkingQuota(token, idWisata);
      data.fold((failure) {
        emit(FailedShowParkingQuota(failure.error ?? ""));
      }, (data) {
        if (data.code == 401) {
          emit(ShowTokenExpired(data.message ?? ''));
          return;
        }

        ParkingQuota? motorQuota = data.data.firstWhereOrNull(
            (element) => (element.namaJenisKendaraan ?? '') == 'Motor');
        ParkingQuota? carQuota = data.data.firstWhereOrNull(
            (element) => (element.namaJenisKendaraan ?? '') == 'Mobil');
        ParkingQuota? busQuota = data.data.firstWhereOrNull(
            (element) => (element.namaJenisKendaraan ?? '') == 'pppp');

        int motorTotal = motorQuota?.jumlah ?? 0;
        int carTotal = carQuota?.jumlah ?? 0;
        int busTotal = busQuota?.jumlah ?? 0;
        int vehicleTotal = motorTotal + carTotal + busTotal;

        print(
            'data motor is null ${motorQuota == null}, dan data mobile is null ${carQuota == null}, dan data bus is null ${busQuota == null}');

        ParkingHomeContentHolder parkingData = ParkingHomeContentHolder(
            wisataName: wisataName,
            motorQuota: motorQuota,
            carQuota: carQuota,
            busQuota: busQuota,
            vehicleTotal: vehicleTotal);

        emit(SuccessShowParkingingData(parkingData));
      });
    });
  }
}
