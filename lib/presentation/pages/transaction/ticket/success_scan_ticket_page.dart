import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/home_page.dart';
import 'package:pad_lampung/presentation/utils/extension/list_bluetooth_device_ext.dart';
import 'package:pad_lampung/presentation/utils/helper/printer_helper.dart';

class SuccessScanTicketPage extends StatefulWidget {
  final String? successMessage;

  const SuccessScanTicketPage({Key? key, this.successMessage})
      : super(key: key);

  @override
  State<SuccessScanTicketPage> createState() => _SuccessScanTicketPageState();
}

class _SuccessScanTicketPageState extends State<SuccessScanTicketPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  final PrinterHelper printerHelper = PrinterHelper();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}
    bluetooth.onStateChanged().listen((state) {});
    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {});
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

  void _connectAndPrint(
      String deviceName, String wisataName, List<String> ticketCodes) {
    print('device name is $deviceName');
    if (deviceName == '-') {
      showWarningDialog(
          context: context,
          title: 'Perhatian',
          message:
              'Kamu belum setting perangkat printer di pengaturan untuk action ini..');
      return;
    }

    BluetoothDevice? selectedDevice = _devices.getProperDevice(deviceName);
    if (selectedDevice != null) {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected == false) {
          bluetooth.connect(selectedDevice).then((value) {
            if (value == false) return;
            printerHelper.printTicket(
                ticketCodes: ticketCodes, location: wisataName);
          }).catchError((error) {});
          printerHelper.printTicket(
              ticketCodes: ticketCodes, location: wisataName);
          return;
        }

        if (isConnected == true) {
          printerHelper.printTicket(
              ticketCodes: ticketCodes, location: wisataName);
        }
      });
    } else {}
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
            widget.successMessage ?? 'Berhasil scan ticket...',
            style: AppTheme.subTitle,
          ),
        ),
        const SizedBox(
          height: 16,
        ),

        PrimaryButton(
            context: context,
            isEnabled: true,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                      builder: (context) => const HomePageTicket()),
                  (Route<dynamic> route) => false);
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Kembali ke Home'),
      ],
    );
  }
}
