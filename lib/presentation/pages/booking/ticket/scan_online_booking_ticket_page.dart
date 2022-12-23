import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/online/ticket_online_state.dart';
import 'package:pad_lampung/presentation/bloc/ticket/scan/ticket_scan_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/scan/ticket_scan_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/scan/ticket_scan_state.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_no_border.dart';
import 'package:pad_lampung/presentation/pages/booking/ticket/ticket_checkout_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/appbar/custom_generic_appbar.dart';

class ScanOnlineBookingTicketPage extends StatefulWidget {
  const ScanOnlineBookingTicketPage({Key? key}) : super(key: key);

  @override
  State<ScanOnlineBookingTicketPage> createState() =>
      _ScanOnlineBookingTicketPageState();
}

class _ScanOnlineBookingTicketPageState
    extends State<ScanOnlineBookingTicketPage> {
  final TextEditingController? codeController = TextEditingController();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final _formKey = GlobalKey<FormState>();

  String code = "";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<TicketScanBloc>(),
      listener: (ctx, state) {
        if (state is LoadingTicketScan) {
          showLoadingDialog(
              context: context, loadingText: 'Memverifikasi tiket..');
          return;
        }

        if (state is SuccessScanTicket) {
          Navigator.pop(context);
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (c) => TicketCheckOutPage(ticketId: code)));
          return;
        }

        if (state is FailedScanTicket) {
          Navigator.pop(context);
          showFailedDialog(
              context: context,
              title: "Gagal!",
              message: state.message,
              onTap: () {
                Navigator.pop(context);
              });
          return;
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 250.0;

    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: blocListener(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: GenericAppBar(url: '', title: 'Pindai Tiket'),
                ),
                SizedBox(height: 14,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Pindai Tiket Wisata',
                        style: AppTheme.subTitle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Text(
                          'Tempatkan tiket didalam bingkai untuk di scan. Tolong jaga agar perangkat anda tetap stabil saat memindai untuk memastikan hasil yang akurat.',
                          textAlign: TextAlign.center,
                          style: AppTheme.smallBodyGrey,
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child: InkWell(
                          onTap: () async {
                            await controller?.resumeCamera();
                          },
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                            overlay: QrScannerOverlayShape(
                                borderColor: Colors.red,
                                borderRadius: 10,
                                borderLength: 30,
                                borderWidth: 10,
                                cutOutSize: scanArea),
                            onPermissionSet: (ctrl, p) =>
                                _onPermissionSet(context, ctrl, p),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Tekan kotak ditengah untuk memulai pemindai.',
                            textAlign: TextAlign.center,
                            style: AppTheme.smallBodyGrey,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Input Kode Barcode',
                    style: AppTheme.subTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Gunakan jika scanner tidak merespon.',
                    style: AppTheme.smallBodyGrey,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: GenericTextInputNoBorder(
                          controller: codeController!,
                          inputType: TextInputType.text,
                          hintText: 'xxx-xxx-xxx',
                          radius: 16,
                          maxLines: 1,
                          horizontalMargin: 8,
                          prefixIcon: const Icon(
                            Icons.qr_code_scanner,
                            size: 18,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: PrimaryButton(
                          context: context,
                          margin: 4,
                          isEnabled: true,
                          width: double.infinity,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String? transactionCode =
                                  codeController?.value.text ?? "";
                              handleActions(transactionCode);
                            }
                          },
                          text: 'Lanjutkan',
                          horizontalPadding: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print("Data is ${scanData.code}");
        result = scanData;
      });

      controller.pauseCamera();
      handleActions(scanData.code ?? "Haha");
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void handleActions(String? transactionCode) {
    controller?.pauseCamera();

    if (transactionCode?.isEmpty ?? true) {
      showWarningDialog(
          context: context,
          title: 'Perhatian',
          message: 'Code Transaksi kosong!');
      return;
    }

    code = transactionCode ?? "";
    context.read<TicketScanBloc>().add(ScanTicket(transactionCode ?? ""));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
