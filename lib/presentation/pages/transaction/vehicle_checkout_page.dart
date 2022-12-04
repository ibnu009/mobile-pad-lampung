import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/park/park_event.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/pages/transaction/post_transaction_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

import '../../bloc/park/park_bloc.dart';
import '../../bloc/park/park_state.dart';
import '../../components/dialog/dialog_component.dart';
import '../../components/dropdown/dropdown_value.dart';
import '../../components/dropdown/generic_dropdown.dart';

class VehicleCheckOutPage extends StatefulWidget {
  final String parkingId;
  const VehicleCheckOutPage({Key? key, required this.parkingId}) : super(key: key);

  @override
  State<VehicleCheckOutPage> createState() => _VehicleCheckOutPageState();
}

class _VehicleCheckOutPageState extends State<VehicleCheckOutPage> {
  String selectedItem = initialVehicleDataShown;
  int fee = 20000;
  int vehicleId = 0;

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<ParkBloc>(),
      listener: (ctx, state) {
        if (state is LoadingPark) {
          showLoadingDialog(context: context);
          return;
        }

        if (state is SuccessPark) {
          Navigator.pop(context);
          Navigator.push(context, CupertinoPageRoute(builder: (c) => const PostTransactionPage()));
          return;
        }

        if (state is FailedPark) {
          Navigator.pop(context);
          showFailedDialog(
              context: context,
              title: "Gagal Park",
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
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: blocListener(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: GenericAppBar(url: '', title: 'Detail Kendaraan'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Text(
                        'Foto Kendaraan',
                        style: AppTheme.subTitle,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset('assets/images/default_profile.png'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRowDetailData('ID Parkir', widget.parkingId),
                      buildRowDetailData('Masuk', '10:00 / 01 Des 2022'),
                      buildRowDetailData('Keluar ', '15:00 / 01 Des 2022'),
                    ],
                  ),
                ),
                GenericDropdown(
                  selectedItem: selectedItem,
                  items: vehicleDataShown,
                  height: 45,
                  width: double.infinity,
                  backgroundColor: Colors.white,
                  borderColor: Colors.transparent,
                  onChanged: (String? value) {
                    setState(() {
                      selectedItem = value ?? initialDataShown;
                      vehicleId = selectedItem.toVehicleId();
                    });
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: Text(
                    'Total Pembayaran',
                    style: AppTheme.subTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          fee.toRupiah(),
                          style: AppTheme.title2,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: PrimaryButton(
                            context: context,
                            isEnabled: true,
                            onPressed: () {
                              context
                                  .read<ParkBloc>()
                                  .add(ParkingCheckOut(noParking: widget.parkingId, vehicleTypeId: vehicleId, fee: fee));
                            },
                            horizontalPadding: 0,
                            height: 45,
                            text: 'Bayar'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRowDetailData(String tittle, String data) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            tittle,
            style: AppTheme.subTitle,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(data),
        ),
      ],
    );
  }
}
