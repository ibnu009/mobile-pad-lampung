import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/income/offline/ticket_income_offline_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/income/offline/ticket_income_offline_event.dart';
import 'package:pad_lampung/presentation/components/button/icon_primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_bluetooth_device_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_ticket_income_ext.dart';
import 'package:pad_lampung/presentation/utils/helper/printer_helper.dart';

import '../../../bloc/ticket/income/offline/ticket_income_offline_state.dart';

class OfflineIncomeTab extends StatefulWidget {
  const OfflineIncomeTab({Key? key}) : super(key: key);

  @override
  State<OfflineIncomeTab> createState() => _OfflineIncomeTabState();
}

class _OfflineIncomeTabState extends State<OfflineIncomeTab> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  String selectedItem = initialDataShown;
  final PrinterHelper printerHelper = PrinterHelper();

  int currentPage = 0;
  int itemPerPage = 5;
  int offset = 0;

  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    context
        .read<TicketIncomeOfflineBloc>()
        .add(GetOfflineTicketIncome(offset: offset, limit: itemPerPage));
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
      print('memanggil bounded bluetooth');
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {});
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {});
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {});
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {});
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {});
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {});
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {});
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {});
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder(
            bloc: context.read<TicketIncomeOfflineBloc>(),
            builder: (ctx, state) {
              if (state is SuccessShowOfflineTicketIncome) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 0, 4),
                            child: Text(
                              DateTime.now().toFormattedDate(),
                              style: AppTheme.bodyText,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 16, 4),
                            child: Text(
                              state.grandTotal.toRupiah(),
                              style: AppTheme.smallTitle,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Text('Show'),
                            GenericDropdown(
                              selectedItem: selectedItem,
                              height: 40,
                              items: dataShownItem,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedItem = value ?? initialDataShown;
                                  itemPerPage = int.parse(selectedItem);
                                  currentPage = 0;
                                });
                              },
                            ),
                            const Spacer(),
                            IconPrimaryButton(
                              width: 100,
                                context: context,
                                isEnabled: true,
                                icon: Icons.local_print_shop_outlined,
                                onPressed: () async {
                                  _connectAndPrint(
                                      state.deviceName,
                                      state.wisataName,
                                      state.operatorName,
                                      state.grandTotal);

                                  showLoadingDialog(
                                      context: context,
                                      loadingText: 'Laporan sedang dicetak..');
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  showSuccessDialog(
                                      context: context,
                                      title: 'Berhasil',
                                      message: "Laporan telah berhasil dicetak..",
                                      onTap: () {
                                        bluetooth.disconnect();
                                        Navigator.pop(context);
                                      });
                                },
                                height: 40,
                                text: 'Cetak')
                          ],
                        ),
                      ),
                      state.data.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: Text('Data kosong')),
                            )
                          : Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: state.data.toDataRow(),
                            ),
                    ],
                  ),
                );
              }
              if (state is LoadingTicketIncomeOffline) {
                return const Center(child: LoadingWidget());
              }
              return const SizedBox();
            },
          ),
          BlocBuilder(
            bloc: context.read<TicketIncomeOfflineBloc>(),
            builder: (ctx, state) {
              if (state is SuccessShowOfflineTicketIncome) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  child: NumberPaginator(
                    numberPages:
                        state.totalData.getTotalPageByTotalData(itemPerPage),
                    config: NumberPaginatorUIConfig(
                      // default height is 48
                      height: 46,
                      buttonShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: Colors.black,
                      buttonUnselectedBackgroundColor: AppTheme.neutralColor,
                      buttonSelectedBackgroundColor: AppTheme.primaryColor,
                    ),
                    initialPage: currentPage,
                    onPageChange: (int index) {
                      setState(() {
                        offset = (index * itemPerPage);
                        currentPage = index;
                      });
                      context.read<TicketIncomeOfflineBloc>().add(
                          GetOfflineTicketIncome(
                              offset: offset, limit: itemPerPage));
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  void _connectAndPrint(
      String deviceName, String location, String operatorName, int total) {
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
            printerHelper.printIncome(
                location: location, operatorName: operatorName, total: total);
          }).catchError((error) {});
          return;
        }

        if (isConnected == true) {
          printerHelper.printIncome(
              location: location, operatorName: operatorName, total: total);
        }
      });
    } else {}
  }
}
