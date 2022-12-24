import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_state.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/utils/extension/list_bluetooth_device_ext.dart';
import 'package:pad_lampung/presentation/utils/helper/printer_helper.dart';

import '../../home/ticket/home_page.dart';

class PostTicketTransactionPage extends StatefulWidget {
  final String transactionNumber;
  final int price;

  const PostTicketTransactionPage(
      {Key? key, required this.transactionNumber, required this.price})
      : super(key: key);

  @override
  State<PostTicketTransactionPage> createState() =>
      _PostTicketTransactionPageState();
}

class _PostTicketTransactionPageState extends State<PostTicketTransactionPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<String> ticketCodes = [];
  int currentPrintedTicket = 0;
  int currentPrintedTicketIndex = 0;
  String wisataName = '';
  final PrinterHelper printerHelper = PrinterHelper();

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  String printerTicketName = "-";
  String printerStructName = "-";

  bool _connected = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    context
        .read<TicketPaymentStatusBloc>()
        .add(GetPaymentStatus(widget.transactionNumber));
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
    double widthButton = MediaQuery.of(context).size.width * 0.7;

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
            BlocBuilder(
              bloc: context.read<TicketPaymentStatusBloc>(),
              builder: (ctx, state) {
                if (state is SuccessShowTicketPayment) {
                  ticketCodes.clear();
                  ticketCodes.addAll(state.ticketCodes);
                  wisataName = state.wisataName;
                  printerStructName = state.printerStructName;
                  printerTicketName = state.printerTicketName;

                  return buildSuccessWidget(
                      widthButton,
                      state.ticketCodes.length,
                      context,
                      state.printerStructName,
                      state.printerTicketName);
                }

                if (state is LoadingTicketPaymentStatus) {
                  return buildLoadingWidget();
                }

                if (state is FailedShowTicketPayment) {
                  return buildLoadingWidget();
                }
                return buildLoadingWidget();
              },
            ),
            const Spacer(),
            SizedBox(
                width: 100, child: Image.asset('assets/images/logo_pesat.png')),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildSuccessWidget(double widthButton, int totalTicket,
      BuildContext context, String structName, String ticketName) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset('assets/images/bx-badge-check.svg'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            'Pembayaran Berhasil...',
            style: AppTheme.subTitle,
          ),
        ),
        PrimaryButton(
            context: context,
            isEnabled: true,
            width: widthButton,
            onPressed: () async {
              _connectAndPrint(true, structName);

              showLoadingDialog(
                  context: context, loadingText: 'Struk sedang dicetak..');
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) return;
              Navigator.pop(context);
              showSuccessDialog(
                  context: context,
                  title: 'Berhasil',
                  message: "Struk telah berhasil dicetak..",
                  onTap: () {
                    bluetooth.disconnect();
                    Navigator.pop(context);
                  });
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Cetak Struk'),
        const SizedBox(
          height: 16,
        ),
        PrimaryButton(
            context: context,
            isEnabled: true,
            width: widthButton,
            onPressed: () async {
              _connectAndPrint(false, ticketName);
              showLoadingDialog(
                  context: context, loadingText: 'Tiket sedang dicetak..');
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) return;
              Navigator.pop(context);
              showSuccessDialog(
                  context: context,
                  title: 'Berhasil',
                  message: "Tiket telah berhasil dicetak",
                  onTap: () {
                    bluetooth.disconnect();
                    Navigator.pop(context);
                  });
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Cetak Tiket Masuk'),
        const SizedBox(
          height: 16,
        ),
        PrimaryButton(
            context: context,
            isEnabled: true,
            width: widthButton,
            onPressed: () {
              // bluetooth.disconnect();
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (c) => const HomePageTicket()));
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Kembali Ke Home'),
      ],
    );
  }

  Widget buildLoadingWidget() {
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
          child: const LoadingWidget(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            'Menunggu Pembayaran...',
            style: AppTheme.subTitle,
          ),
        ),
        PrimaryButton(
            context: context,
            isEnabled: true,
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.red,
            horizontalPadding: 32,
            height: 45,
            text: 'Batal'),
      ],
    );
  }

  void _connectAndPrint(bool isPrintStruct, String deviceName) {
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
            if (isPrintStruct) {
              printerHelper.printStruct(
                  transactionCode: widget.transactionNumber,
                  location: wisataName,
                  total: ticketCodes.length,
                  price: widget.price);
            } else {
              printerHelper.printTicket(
                  ticketCodes: ticketCodes, location: wisataName);
            }
          }).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
          if (isPrintStruct) {
            printerHelper.printStruct(
                transactionCode: widget.transactionNumber,
                location: wisataName,
                total: ticketCodes.length,
                price: widget.price);
          } else {
            printerHelper.printTicket(
                ticketCodes: ticketCodes, location: wisataName);
          }
          return;
        }

        if (isConnected == true) {
          setState(() => _connected = true);
          if (isPrintStruct) {
            printerHelper.printStruct(
                transactionCode: widget.transactionNumber,
                location: wisataName,
                total: ticketCodes.length,
                price: widget.price);
          } else {
            printerHelper.printTicket(
                ticketCodes: ticketCodes, location: wisataName);
          }
        }
      });
    } else {}
  }
}
