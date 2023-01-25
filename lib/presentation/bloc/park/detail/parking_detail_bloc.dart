import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/park_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import '../../../utils/delegate/generic_delegate.dart';
import 'parking_detail_event.dart';
import 'parking_detail_state.dart';

class ParkingDetailBloc extends Bloc<ParkingDetailEvent, ParkingDetailState> {
  final ParkRepository repository;
  final AppPreferences storage;

  ParkingDetailBloc({required this.repository, required this.storage})
      : super(InitiateParkingDetailState()) {
    GenericDelegate? delegate;
    on<GetParkingDetail>((event, emit) async {
      emit(LoadingParkingDetail());
      String token = await storage.readSecureData(tokenKey) ?? "";
      var data = await repository.fetchDetailParking(token, event.transactionNumber);
      data.fold((failure) {
        emit(FailedShowParkingDetail(failure.error ?? ""));
      }, (response) {

        if (response.code == 401) {
          emit(ShowTokenExpiredParkirDetail(response.message));
          return;
        }

        emit(SuccessShowParkingDetail(response.data));
      });
    });

    on<CheckOutParkingNew>((event, emit) async {
      delegate = event.delegate;
      delegate?.onLoading();
      String token = await storage.readSecureData(tokenKey) ?? "";
      var data = await repository.checkOutParkingNew(event.transactionNumber, event.nopol, token);
      data.fold((failure) {
        delegate?.onFailed(failure.error ?? "");
      }, (response) {
        delegate?.onSuccess('');
      });
    });


  }
}
