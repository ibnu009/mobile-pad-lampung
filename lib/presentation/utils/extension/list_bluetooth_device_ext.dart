import 'package:blue_thermal_printer/blue_thermal_printer.dart';

extension BluetoothDeviceExtention on List<BluetoothDevice> {
  BluetoothDevice? getProperDevice(String name) {
    BluetoothDevice? selectedDevice;
    for (int i = 0; i < length; i++) {
      if (this[i].name?.toLowerCase() == name.toLowerCase()){
        selectedDevice = this[i];
        break;
      }
    }
    return selectedDevice;
  }
}
