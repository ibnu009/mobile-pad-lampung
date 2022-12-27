import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/sources/shared_preferences.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/setting/setting_bloc.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';

import '../../bloc/setting/setting_event.dart';
import '../../bloc/setting/setting_state.dart';
import '../../components/appbar/custom_generic_appbar.dart';

class BluetoothSettingPage extends StatefulWidget {
  const BluetoothSettingPage({Key? key}) : super(key: key);

  @override
  State<BluetoothSettingPage> createState() => _BluetoothSettingPageState();
}

class _BluetoothSettingPageState extends State<BluetoothSettingPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  String selectedItem = initialDeviceFunctionality;

  String pencetakTiket = "-";
  String pencetakStruk = "-";
  String pencetakGelang = "-";
  String pencetakReport = "-";

  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(InitiateConnectedDevice());
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  void saveDevice(){
    if (selectedItem == deviceFunctionalities[0]) {
      //Tiket
      setState(() {
        pencetakTiket = _device?.name ?? "-";
      });
      saveToLocal(printerTicketKey);
      return;
    }

    if (selectedItem == deviceFunctionalities[1]) {
      //Struk
      saveToLocal(printerStructKey);
      setState(() {
        pencetakStruk = _device?.name ?? "-";
      });
      return;
    }

    if (selectedItem == deviceFunctionalities[2]) {
      //Gelang
      saveToLocal(printerGelangKey);
      setState(() {
        pencetakGelang = _device?.name ?? "-";
      });
      return;
    }

    if (selectedItem == deviceFunctionalities[3]) {
      //Report
      saveToLocal(printerReportKey);
      setState(() {
        pencetakReport = _device?.name ?? "-";
      });
      return;
    }
  }

  void saveToLocal(String localKey){
    context.read<SettingBloc>().add(SaveDevice(deviceName: _device?.name ?? "-", localKey: localKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: GenericAppBarNoThumbnail(url: '', title: 'Bluetooth'),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                padding: const EdgeInsets.only(left: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Pilih Perangkat Bluetooth: ',
                          style: AppTheme.subTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (BluetoothDevice? value) =>
                            setState(() => _device = value),
                        value: _device,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:
                          Text('Pilih Fungsi Alat: ', style: AppTheme.subTitle),
                    ),
                    GenericDropdown(
                      selectedItem: selectedItem,
                      height: 40,
                      items: deviceFunctionalities,
                      onChanged: (String? value) {
                        setState(() {
                          selectedItem = value ?? initialDataShown;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: PrimaryButton(
                        height: 40,
                          context: context,
                          isEnabled: true,
                          onPressed: () => saveDevice(),
                          text: 'Simpan'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                padding: const EdgeInsets.only(left: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: BlocBuilder(
                  bloc: this.context.read<SettingBloc>(),
                  builder: (ctx, state) {
                    if (state is ShowConnectedDevice) {
                      state.printerGelang;
                      state.printerStruct;
                       state.printerTicket;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Perangkat: ', style: AppTheme.subTitle),
                          ),
                          ListTile(
                            title: const Text('1. Pencetak Struk'),
                            subtitle: Text(pencetakStruk == "-" ? state.printerStruct : pencetakStruk),
                          ),
                          ListTile(
                            title: const Text('2. Pencetak Tiket'),
                            subtitle: Text(pencetakTiket == "-" ? state.printerTicket : pencetakTiket),
                          ),
                          ListTile(
                            title: const Text('3. Pencetak Gelang'),
                            subtitle: Text(pencetakGelang == "-" ? state.printerGelang : pencetakGelang),
                          ),
                          ListTile(
                            title: const Text('4. Pencetak Laporan'),
                            subtitle: Text(pencetakReport == "-" ? state.printerReport : pencetakReport),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    }

                    return SizedBox();
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      for (var device in _devices) {
        items.add(DropdownMenuItem(
          value: device,
          child: Text(device.name ?? ""),
        ));
      }
    }
    return items;
  }
}
