abstract class SettingEvent {}

class InitiateConnectedDevice extends SettingEvent {}

class SaveDevice extends SettingEvent {
  final String deviceName, localKey;

  SaveDevice({required this.deviceName, required this.localKey});
}