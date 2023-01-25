import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/response/detail_parking_response.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_event.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

import '../../../bloc/park/detail/parking_detail_state.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/dropdown/generic_dropdown.dart';
import '../../../components/image/image_network.dart';
import 'transaction_parkir_payment_type_page.dart';

class VehicleCheckOutPage extends StatefulWidget {
  final String parkingId;

  const VehicleCheckOutPage({Key? key, required this.parkingId})
      : super(key: key);

  @override
  State<VehicleCheckOutPage> createState() => _VehicleCheckOutPageState();
}

class _VehicleCheckOutPageState extends State<VehicleCheckOutPage> {
  String selectedItem = "Mobil";
  int fee = 1000;
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

        if (state is ShowTokenExpiredParkirDetail) {
          showWarningDialog(
              context: context,
              title: "Perhatian",
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
              BlocBuilder(
                bloc: context.read<ParkingDetailBloc>(),
                builder: (ctx, state) {
                  if (state is LoadingParkingDetail) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }

                  if (state is SuccessShowParkingDetail) {
                    return buildContent(state.data);
                  }

                  return const Center(
                    child: LoadingWidget(),
                  );
                },
              )
            ],
          ),
        )),
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
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
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
                child: GenericImageNetwork(
                    width: double.infinity,
                    imageUrl: data.transaksiBookingParkir[0].pathFotoKendaraan),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowDetailData('ID Parkir', widget.parkingId),
              buildRowDetailData(
                  'Masuk', data.transaksiBookingParkir[0].waktuMasuk ?? '-'),
              buildRowDetailData(
                  'Keluar ', data.transaksiBookingParkir[0].waktuKeluar ?? '-'),
            ],
          ),
        ),
        Visibility(
          visible: data.online != 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(
              'Pastikan kendaraan sesuai dengan gambar',
              style: AppTheme.text1,
            )),
          ),
        ),

        Visibility(
          visible: data.online == 0,
          child: GenericDropdown(
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
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: data.online != 0 ? 16 : 0.0),
          child: Center(
            child: Visibility(
              visible: data.online != 0,
              child: PrimaryButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.7,
                  isEnabled: true,
                  onPressed: () {



                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (ctx) => TransactionParkirPaymentTypePage(
                          price: fee,
                          noPol: data.nopol,
                          noTransaksi: widget.parkingId, idTransaksi: data.id,
                        ),
                      ),
                    );
                  },
                  horizontalPadding: 0,
                  height: 45,
                  text: 'Lanjutkan'),
            ),
          ),
        ),


        Visibility(
          visible: data.online == 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (ctx) => TransactionParkirPaymentTypePage(
                                  price: fee,
                                  noPol: data.nopol,
                                  noTransaksi: widget.parkingId, idTransaksi: data.id,
                                ),
                              ),
                            );
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
          flex: 2,
          child: Text(data),
        ),
      ],
    );
  }

}
