abstract class SettingState {}

class InitiateSettingState extends SettingState {}

class ShowConnectedDevice extends SettingState {
  final String printerTicket, printerStruct, printerGelang, printerReport;

  ShowConnectedDevice(
      {required this.printerTicket,
      required this.printerStruct,
      required this.printerGelang,
      required this.printerReport});
}
