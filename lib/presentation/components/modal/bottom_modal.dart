import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pad_lampung/common/app_const.dart';
import 'package:pad_lampung/presentation/components/button/icon_border_button.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../button/border_button.dart';
import '../text/generic_text_input_hint.dart';

const double hPadding = 2;
const double buttonHeight = 45;

class HomeBottomModal extends StatefulWidget {
  const HomeBottomModal({Key? key}) : super(key: key);

  @override
  State<HomeBottomModal> createState() => _HomeBottomModalState();
}

class _HomeBottomModalState extends State<HomeBottomModal> {
  bool? isKendaraanKeluar;
  bool? isNewest;

  String selectedVehicleType = '';
  String selectedDate = '';
  String selectedTime = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 18,
              ),
              const GenericTextInputHint(
                text: 'Filter',
              ),
              const SizedBox(
                height: 18,
              ),
              GenericTextInputHint(
                text: 'Tanggal & Jam',
                style: AppTheme.smallTitle,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: BorderIconButton(
                        context: context,
                        isEnabled: true,
                        contentPadding: 8,
                        maxAxisAlignment: MainAxisAlignment.start,
                        color: selectedDate.isEmpty ? Colors.black38 : AppTheme.primaryColor,
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime(DateTime.now().year + 1))
                          .then((date) {
                            print('date is $date');
                            setState(() {
                              if (date == null) return;
                              selectedDate = date.toFormattedDate(format: 'dd-MM-yyyy');
                            });
                          });
                        },
                        height: buttonHeight,
                        leftPadding: hPadding,
                        rightPadding: hPadding,
                        horizontalMargin: hPadding,
                        text: selectedDate.isEmpty ? 'DD-MM-YYYY' : selectedDate,
                        icon: Icons.calendar_month_outlined,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      flex: 1,
                      child: BorderButton(
                          context: context,
                          isEnabled: true,
                          color: selectedTime.isEmpty ? Colors.black38 : AppTheme.primaryColor,
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((picked) {
                              if (picked != null) {
                                setState(() {
                                  String formattedDate = picked.format(context);
                                  selectedTime = formattedDate;
                                });
                              }
                            });
                          },
                          height: buttonHeight,
                          leftPadding: hPadding,
                          rightPadding: hPadding,
                          horizontalMargin: hPadding,
                          text: selectedTime.isEmpty ? '00:00' : selectedTime)),
                ],
              ),

              //!! Kendaraan Keluar
              const SizedBox(
                height: 18,
              ),
              GenericTextInputHint(
                text: 'Kendaraan Keluar',
                style: AppTheme.smallTitle,
              ),
              Row(
                children: [
                  Expanded(
                      child: BorderButton(
                          context: context,
                          isEnabled: isKendaraanKeluar == null
                              ? false
                              : !isKendaraanKeluar!,
                          onPressed: () {},
                          onNotActivePressed: () {
                            print("current kendaraan, $isKendaraanKeluar");
                            setState(() {
                              isKendaraanKeluar = false;
                            });
                          },
                          height: buttonHeight,
                          leftPadding: hPadding,
                          rightPadding: hPadding,
                          horizontalMargin: hPadding,
                          text: 'Belum Keluar')),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: BorderButton(
                          context: context,
                          isEnabled: isKendaraanKeluar ?? false,
                          height: buttonHeight,
                          leftPadding: hPadding,
                          rightPadding: hPadding,
                          horizontalMargin: hPadding,
                          onNotActivePressed: () {
                            print("current kendaraan, $isKendaraanKeluar");
                            setState(() {
                              isKendaraanKeluar = true;
                            });
                          },
                          onPressed: () {},
                          text: 'Sudah Keluar')),
                  const Spacer(),
                ],
              ),

              //!! Jenis Kendaraan
              const SizedBox(
                height: 18,
              ),
              GenericTextInputHint(
                text: 'Kendaraan Keluar',
                style: AppTheme.smallTitle,
              ),
              Row(
                children: [
                  Expanded(
                      child: BorderIconButton(
                    context: context,
                    isEnabled: selectedVehicleType.isSelectedBike(),
                    onPressed: () {},
                    onNotActivePressed: () {
                      print("current kendaraan, $isKendaraanKeluar");
                      setState(() {
                        selectedVehicleType = motorType;
                      });
                    },
                    height: buttonHeight,
                    leftPadding: hPadding,
                    rightPadding: hPadding,
                    horizontalMargin: hPadding,
                    text: 'Motor',
                    icon: Icons.motorcycle_outlined,
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: BorderIconButton(
                    context: context,
                    isEnabled: selectedVehicleType.isSelectedCar(),
                    height: buttonHeight,
                    leftPadding: hPadding,
                    rightPadding: hPadding,
                    horizontalMargin: hPadding,
                    onNotActivePressed: () {
                      setState(() {
                        selectedVehicleType = carType;
                      });
                    },
                    onPressed: () {},
                    text: 'Mobil',
                    icon: Icons.drive_eta,
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: BorderIconButton(
                    context: context,
                    isEnabled: selectedVehicleType.isSelectedBus(),
                    height: buttonHeight,
                    leftPadding: hPadding,
                    rightPadding: hPadding,
                    horizontalMargin: hPadding,
                    onNotActivePressed: () {
                      setState(() {
                        selectedVehicleType = busType;
                      });
                    },
                    onPressed: () {},
                    text: 'Bus',
                    icon: Icons.directions_bus,
                  )),
                ],
              ),

              //!! Urutkan
              const SizedBox(
                height: 18,
              ),
              GenericTextInputHint(
                text: 'Urutkan',
                style: AppTheme.smallTitle,
              ),
              Row(
                children: [
                  Expanded(
                      child: BorderButton(
                          context: context,
                          isEnabled: isNewest == null ? false : !isNewest!,
                          onPressed: () {},
                          onNotActivePressed: () {
                            setState(() {
                              isNewest = false;
                            });
                          },
                          height: buttonHeight,
                          leftPadding: hPadding,
                          rightPadding: hPadding,
                          horizontalMargin: hPadding,
                          text: 'Paling Baru')),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: BorderButton(
                          context: context,
                          isEnabled: isNewest ?? false,
                          height: buttonHeight,
                          leftPadding: hPadding,
                          rightPadding: hPadding,
                          horizontalMargin: hPadding,
                          onNotActivePressed: () {
                            setState(() {
                              isNewest = true;
                            });
                          },
                          onPressed: () {},
                          text: 'Paling Lama')),
                  const Spacer(),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Center(
                    child: PrimaryButton(
                        context: context,
                        width: MediaQuery.of(context).size.width * 0.7,
                        isEnabled: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Terapkan')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
