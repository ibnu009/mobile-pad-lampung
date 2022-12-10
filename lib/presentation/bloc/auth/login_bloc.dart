
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/auth_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;
  final AppPreferences storage;

  LoginBloc({required this.repository, required this.storage}) : super(InitiateLoginState()) {

    on<LoginUser>((event, emit) async {
      emit(LoadingLogin());

      var data = await repository.submitLogin(event.email, event.password);
      data.fold((failure) {
        emit(FailedLogin(failure.error ?? ""));
      }, (success) {
        storage.writeSecureData(tokenKey, success.accessToken);
        storage.writeSecureData(wisataIdKey, success.user.petugas.idTempatWisata.toString());
        storage.writeSecureData(wisataNameKey, success.user.petugas.tempatWisata.namaTempatWisata);
        storage.writeSecureData(userTypeKey, success.user.tipeUser.toString());
        storage.writeSecureData(petugasEmailKey, success.user.email);
        storage.writeSecureData(userTypeKey, success.user.petugas.noTelp);
        emit(SuccessLogin());
      });
    });

    on<LogoutUser>((event, emit) async {
      storage.deleteSecureData(tokenKey);
    });

  }
}