import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/pages/transaction/post_transaction_page.dart';

import '../../components/dropdown/dropdown_value.dart';
import '../../components/dropdown/generic_dropdown.dart';

class DetailVehiclePage extends StatefulWidget {
  const DetailVehiclePage({Key? key}) : super(key: key);

  @override
  State<DetailVehiclePage> createState() => _DetailVehiclePageState();
}

class _DetailVehiclePageState extends State<DetailVehiclePage> {
  String selectedItem = initialVehicleDataShown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    buildRowDetailData('ID Parkir', '7374279849'),
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
                        'Rp 0',
                        style: AppTheme.title2,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: PrimaryButton(
                          context: context,
                          isEnabled: true,
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (c) => const PostTransactionPage()));
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
