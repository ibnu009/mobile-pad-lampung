import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../../core/data/repositories/ticket_repository.dart';
import 'method_xendit_event.dart';
import 'method_xendit_state.dart';

class MethodXenditBloc extends Bloc<MethodXenditEvent, MethodXenditState> {
  final TicketRepository repository;
  final AppPreferences storage;

  MethodXenditBloc({required this.repository, required this.storage})
      : super(InitiateMethodXenditState()) {

    on<GetXenditPaymentMethod>((event, emit) async {
      emit(LoadingMethodXendit());
      String token = await storage.readSecureData(tokenKey) ?? "";
      var data = await repository.fetchXenditPaymentMethod(token);
      data.fold((failure) {
        emit(FailedMethodXenditState(failure.message ?? ""));
      }, (data) async {
        emit(ShowXenditMethodMethod(data.data));
      });
    });
  }
}
