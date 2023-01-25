import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/pages/home/parking/home_page.dart';
import 'package:pad_lampung/presentation/utils/extension/list_bluetooth_device_ext.dart';

import '../../utils/helper/printer_helper.dart';

class SuccessParkPage extends StatefulWidget {
  final String? successMessage,
      parkingCode,
      vehicleType,
      requiredPrinter,
      location;

  const SuccessParkPage(
      {Key? key,
      this.successMessage,
      this.parkingCode,
      this.vehicleType,
      this.requiredPrinter,
      this.location})
      : super(key: key);

  @override
  State<SuccessParkPage> createState() => _SuccessParkPageState();
}

class _SuccessParkPageState extends State<SuccessParkPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  final PrinterHelper printerHelper = PrinterHelper();
  bool _connected = false;
  List<BluetoothDevice> _devices = [];


  @override
  void initState() {
    super.initState();
    print('hasil is printer ${widget.requiredPrinter},parking code ${widget.parkingCode}');
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
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(
              width: double.infinity,
            ),
            buildSuccessWidget(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/logo_pesat.png')),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSuccessWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200.0,
          height: 200.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset('assets/images/bx-badge-check.svg'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            widget.successMessage ?? 'Berhasil...',
            style: AppTheme.subTitle,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Visibility(
          visible: widget.parkingCode != null,
          child: PrimaryButton(
              context: context,
              isEnabled: true,
              onPressed: () async {
                _connectAndPrint(
                    widget.requiredPrinter ?? '', widget.location ?? '');
                showLoadingDialog(
                    context: context, loadingText: 'Struk sedang dicetak..');
                await Future.delayed(const Duration(seconds: 2));
                if (!mounted) return;
                Navigator.pop(context);
                showSuccessDialog(
                    context: context,
                    title: 'Berhasil',
                    message: "Tiket Parkir telah berhasil dicetak..",
                    onTap: () {
                      bluetooth.disconnect();
                      Navigator.pop(context);
                    });
              },
              horizontalPadding: 32,
              height: 45,
              text: 'Cetak Tiket Parkir'),
        ),
        SizedBox(height: 16,),
        PrimaryButton(
            context: context,
            isEnabled: true,
            onPressed: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (c) => const HomePage()));
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Kembali Ke Home'),
      ],
    );
  }

  void _connectAndPrint(String deviceName, String wisataName) {
    print('device name is $deviceName');
    if (deviceName == '-') {
      showWarningDialog(
          context: context,
          title: 'Perhatian',
          message:
              'Kamu belum setting perangkat printer di pengaturan untuk action ini..');
      return;
    }

    // setState(() => _device = _devices.getProperDevice(deviceName));
    BluetoothDevice? selectedDevice = _devices.getProperDevice(deviceName);
    print('selected device name is ${selectedDevice?.name}');

    if (selectedDevice != null) {
      bluetooth.isConnected.then((isConnected) {
        print('isConnected $isConnected');
        if (isConnected == false) {
          bluetooth.connect(selectedDevice).then((value) {
            print('Status is $value');
            if (value == false) return;
            printerHelper.printTicketParkir(
                code: widget.parkingCode ?? '',
                location: wisataName,
                vehicleType: widget.vehicleType ?? '');
          }).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
          printerHelper.printTicketParkir(
              code: widget.parkingCode ?? '',
              location: wisataName,
              vehicleType: widget.vehicleType ?? '');
          return;
        }

        if (isConnected == true) {
          setState(() => _connected = true);
          printerHelper.printTicketParkir(
              code: widget.parkingCode ?? '',
              location: wisataName,
              vehicleType: widget.vehicleType ?? '');
        }
      });
    } else {}
  }
}
