import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/auth_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../core/data/repositories/park_repository.dart';
import 'starter_event.dart';
import 'starter_state.dart';

class StarterBloc extends Bloc<StarterEvent, StarterState> {
  final AppPreferences storage;

  StarterBloc({required this.storage}) : super(InitiateStarterState()) {
    on<StartSplashScreen>((event, emit) async {
      try {
        String token = await storage.readSecureData(tokenKey) ?? "";
        String employeeType = await storage.readSecureData(userTypeKey) ?? "";
        String? lastTransactionUrl = await storage.readSecureData(lastTransactionUrlKey);

        await Future.delayed(const Duration(seconds: 2));

        if (token.isNotEmpty) {
          if (employeeType == "2") {
            emit(NavigateToHomeParking(lastTransactionUrl));
          } else {
            emit(NavigateToHomeTicket(lastTransactionUrl));
          }
        } else {
          emit(NavigateToLogin());
        }
      } catch (e) {
        emit(NavigateToLogin());
      }
    });
  }
}
