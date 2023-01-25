import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_state.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/list_bluetooth_device_ext.dart';
import 'package:pad_lampung/presentation/utils/helper/printer_helper.dart';

import '../../../components/dialog/dialog_component.dart';
import '../success_print_ticket_page.dart';

class TicketCheckOutPage extends StatefulWidget {
  final String ticketId;
  final List<String> ticketCodes;

  const TicketCheckOutPage({Key? key, required this.ticketId, required this.ticketCodes})
      : super(key: key);

  @override
  State<TicketCheckOutPage> createState() => _TicketCheckOutPageState();
}

class _TicketCheckOutPageState extends State<TicketCheckOutPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  final PrinterHelper printerHelper = PrinterHelper();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    context.read<TicketDetailBloc>().add(GetTicketDetail(widget.ticketId));
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
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
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
      setState(() {});
    }
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
                child: GenericAppBar(url: '', title: 'Data Pesanan'),
              ),
              BlocBuilder(
                  bloc: context.read<TicketDetailBloc>(),
                  builder: (context, state) {
                    if (state is SuccessShowTicketDetail) {
                      return buildContent(state.quantity, state.tanggal, state.deviceName , state.wisataname);
                    }

                    if (state is FailedShowTicketDetail) {
                      showFailedDialog(
                          context: context,
                          title: 'Terjadi Kesalahan',
                          onTap: () => Navigator.pop(context),
                          message: state.message);
                      return const LoadingWidget();
                    }

                    return const LoadingWidget();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(int ticketSold, String scanDate, String wisataName, String deviceName) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowDetailData('ID Pesanan', widget.ticketId),
              buildRowDetailData('Jumlah', '$ticketSold Tiket'),
              buildRowDetailData('Tanggal ', scanDate),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        PrimaryButton(
            context: context,
            width: MediaQuery.of(context).size.width * 0.55,
            isEnabled: true,
            onPressed: () async {
              _connectAndPrint(deviceName, wisataName, widget.ticketCodes);
              showLoadingDialog(
                  context: context, loadingText: 'Mencetak Tiket..');
              await Future.delayed(const Duration(seconds: 4));
              if (!mounted) return;
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (c) => const PrintTicketSuccessPage()));
            },
            text: 'Cetak Tiket')
      ],
    );
  }

  void _connectAndPrint( String deviceName, String wisataName, List<String> ticketCodes) {
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
    print('selected device name is ${selectedDevice?.name}');

    if (selectedDevice != null) {
      bluetooth.isConnected.then((isConnected) {
        print('isConnected $isConnected');
        if (isConnected == false) {
          bluetooth.connect(selectedDevice).then((value) {
            print('Status is $value');
            if (value == false) return;
            printerHelper.printTicket(
                ticketCodes: ticketCodes, location: wisataName);
          }).catchError((error) {
          });
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


  Widget buildRowDetailData(String tittle, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              tittle,
              style: AppTheme.smallTitle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(data),
          ),
        ],
      ),
    );
  }
}
