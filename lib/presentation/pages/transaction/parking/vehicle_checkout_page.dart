import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/response/detail_parking_response.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_event.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

import '../../../bloc/park/detail/parking_detail_state.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/dropdown/dropdown_value.dart';
import '../../../components/dropdown/generic_dropdown.dart';
import '../../detail/success_checkout_park_page.dart';

class VehicleCheckOutPage extends StatefulWidget {
  final String parkingId;
  const VehicleCheckOutPage({Key? key, required this.parkingId}) : super(key: key);

  @override
  State<VehicleCheckOutPage> createState() => _VehicleCheckOutPageState();
}

class _VehicleCheckOutPageState extends State<VehicleCheckOutPage> with GenericDelegate{
  String selectedItem = "Mobil";
  int fee = 20000;
  int vehicleId = 0;

  @override
  void initState() {
    super.initState();
    context.read<ParkingDetailBloc>().add(GetParkingDetail(widget.parkingId));
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<ParkingDetailBloc>(),
      listener: (ctx, state) {
        if (state is FailedShowParkingDetail) {
          showFailedDialog(
              context: context,
              title: "Gagal",
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
          child : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: GenericAppBar(url: '', title: 'Detail Kendaraan'),
                ),

                BlocBuilder(
                  bloc: context.read<ParkingDetailBloc>(),
                  builder: (ctx, state) {
                    if (state is LoadingParkingDetail) {
                      return const Center(child: LoadingWidget(),);
                    }

                    if (state is SuccessShowParkingDetail) {
                      return buildContent(state.data);
                    }

                    return const Center(child: LoadingWidget(),);
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget buildContent(ParkingDataDetail data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
              buildRowDetailData('Masuk', data.waktuMasuk ?? '-'),
              buildRowDetailData('Keluar ', data.waktuKeluar ?? '-'),
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
                  data.tarif.toRupiah(),
                  style: AppTheme.title2,
                ),
              ),
              Expanded(
                flex: 3,
                child: PrimaryButton(
                    context: context,
                    isEnabled: true,
                    onPressed: () {
                      context.read<ParkingDetailBloc>().add(CheckOutParkingNew(widget.parkingId, data.nopol ?? '', this));
                    },
                    horizontalPadding: 0,
                    height: 45,
                    text: 'Bayar'),
              )
            ],
          ),
        )

      ],
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

  @override
  void onFailed(String message) {
    showFailedDialog(context: context, title: 'Gagal', message: message);
  }

  @override
  void onLoading() {
    showLoadingDialog(context: context);
  }

  @override
  void onSuccess(String message) {
    Navigator.push(context, CupertinoPageRoute(builder: (c) => SuccessCheckoutParkPage()));
  }
}
