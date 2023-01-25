import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/auth_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository repository;
  final AppPreferences storage;

  ForgotPasswordBloc({required this.repository, required this.storage})
      : super(InitiateForgotPasswordState()) {
    on<ResetPassword>((event, emit) async {
      emit(LoadingForgotPassword());
      var data = await repository.resetPassword(event.email);
      data.fold((failure) {
        emit(FailedForgotPassword(failure.error ?? ""));
      }, (success) {
        storage.writeSecureData(temporaryPasswordKey, success.newPassword);
        emit(SuccessForgotPassword(''));
      });
    });

    on<SendOtpConfirmation>((event, emit) async {
      emit(LoadingForgotPassword());
      var data = await repository.confirmOtp(event.email, event.otp);
      data.fold((failure) {
        emit(FailedForgotPassword(failure.error ?? ""));
      }, (success) async {
        emit(SuccessOtp());
      });
    });

    on<HandleOtpSuccess>((event, emit) async {
      emit(LoadingForgotPassword());
      String passwordNew =
          await storage.readSecureData(temporaryPasswordKey) ?? "";

      var data = await repository.submitLogin(event.email, passwordNew);
      data.fold((failure) {
        emit(FailedForgotPassword(failure.error ?? ""));
      }, (success) {
        emit(SuccessActivateOtp(success.accessToken, success.user.tipeUser));
      });
    });

    on<SendChangePasswordRequest>((event, emit) async {
      emit(LoadingForgotPassword());
      String passwordTemp =
          await storage.readSecureData(temporaryPasswordKey) ?? "";
      var data = await repository.changePassword(
          event.tempToken, passwordTemp, event.newPassword);
      data.fold((failure) {
        emit(FailedForgotPassword(failure.error ?? ""));
      }, (success) async {
        emit(SuccessForgotPassword(''));
      });
    });
  }
}
