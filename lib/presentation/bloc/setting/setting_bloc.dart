import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/repositories/auth_repository.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';

import '../../../core/data/repositories/park_repository.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AppPreferences storage;

  SettingBloc({required this.storage}) : super(InitiateSettingState()) {
    on<InitiateConnectedDevice>((event, emit) async {
      String printerTicket =
          await storage.readSecureData(printerTicketKey) ?? "-";
      String printerStruct =
          await storage.readSecureData(printerStructKey) ?? "-";
      String printerGelang =
          await storage.readSecureData(printerGelangKey) ?? "-";
      String printerReport =
          await storage.readSecureData(printerReportKey) ?? "-";

      emit(ShowConnectedDevice(
          printerTicket: printerTicket,
          printerStruct: printerStruct,
          printerGelang: printerGelang,
          printerReport: printerReport));
    });

    on<SaveDevice>((event, emit) async {
      storage.writeSecureData(event.localKey, event.deviceName);
      print('saved');
    });
  }
}
