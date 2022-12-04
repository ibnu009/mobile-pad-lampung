import 'package:flutter/material.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../components/appbar/custom_generic_appbar.dart';
import '../../components/button/primary_button.dart';
import '../../components/dropdown/dropdown_value.dart';
import '../../components/dropdown/generic_dropdown.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String selectedItem = initialVehicleDataShown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Foto Kendaraan',
                        style: AppTheme.subTitle,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: Image.asset(
                          'assets/images/default_profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GenericDropdown(
                  selectedItem: selectedItem,
                  items: vehicleDataShown,
                  height: 45,
                  width: double.infinity,
                  hint: 'Pilih Jenis Kendaraan',
                  backgroundColor: Colors.white,
                  borderColor: Colors.transparent,
                  onChanged: (String? value) {
                    setState(() {
                      selectedItem = value ?? initialDataShown;
                    });
                  },
                ),
              ),
              PrimaryButton(
                  context: context,
                  isEnabled: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  horizontalPadding: 52,
                  height: 45,
                  text: 'Cetak')
            ],
          ),
        ),
      ),
    );
  }
}
