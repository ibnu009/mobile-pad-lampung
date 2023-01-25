import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/park_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import 'parking_paging_event.dart';
import 'parking_paging_state.dart';

class ParkingPagingBloc extends Bloc<ParkingPagingEvent, ParkingPagingState> {
  final ParkRepository repository;
  final AppPreferences storage;

  ParkingPagingBloc({required this.repository, required this.storage})
      : super(InitiateParkingPagingState()) {
    on<GetParking>((event, emit) async {
      emit(LoadingParkingPagingState());
      String token = await storage.readSecureData(tokenKey) ?? "";
      String idWisata = await storage.readSecureData(wisataIdKey) ?? "";

      print('Value limit is ${event.limit} and offset is ${event.offset}');

      var dataTransaction = await repository.fetchParkingData(
        token,
        idWisata,
        event.limit,
        event.offset,
      );

      dataTransaction.fold((failure) {
        emit(FailedShowParkingData(failure.error ?? ""));
      }, (data) {
        if (data.code == 401) {
          emit(ShowTokenPagingExpired(data.message));
          return;
        }

        emit(SuccessShowParkingPagingData(data.data, data.length));
      });
    });
  }
}
