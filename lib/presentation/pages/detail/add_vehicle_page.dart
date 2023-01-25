import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pad_lampung/core/data/model/response/jenis_kendaraan_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';
import 'package:pad_lampung/presentation/utils/extension/list_tipe_kendaraan_ext.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../bloc/park/checkin_no_booking/checkin_no_booking_bloc.dart';
import '../../bloc/park/checkin_no_booking/checkin_no_booking_event.dart';
import '../../bloc/park/checkin_no_booking/checkin_no_booking_state.dart';
import '../../components/appbar/custom_generic_appbar.dart';
import '../../components/button/primary_button.dart';
import '../../components/dialog/dialog_component.dart';
import '../../components/dropdown/dropdown_value.dart';
import '../../components/dropdown/generic_dropdown.dart';
import '../../components/generic/loading_widget.dart';
import 'success_park_page.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> with GenericDelegate {
  String? selectedItem;
  String placeHolderItem = '';
  File? image;
  final picker = ImagePicker();
  int idJenisKendaraan = 0;
  String jenisKendaraan = '';
  List<VehicleType> dataParking = [];

  @override
  void initState() {
    super.initState();
    context.read<CheckInNoBookingBloc>().add(GetVehicleType());
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<CheckInNoBookingBloc>(),
      listener: (ctx, state) {
        if (state is SuccessGetVehicleType) {
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
                    image != null ? buildImageHolder() : buildPlaceHolder()
                  ],
                ),
              ),
              BlocBuilder(
                bloc: this.context.read<CheckInNoBookingBloc>(),
                builder: (ctx, state) {
                  print('state is $state');

                  if (state is SuccessGetVehicleType) {

                    dataParking = state.data;
                    placeHolderItem = state.data.toDropdownData().first;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GenericDropdown(
                        selectedItem:
                            selectedItem ?? state.data.toDropdownData().first,
                        items: state.data.toDropdownData(),
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
                    );
                  }

                  if (state is LoadingGetVehicleType) {
                    return const Center(child: LoadingWidget());
                  }

                  return const SizedBox();
                },
              ),
              PrimaryButton(
                  context: context,
                  isEnabled: true,
                  onPressed: () {
                    idJenisKendaraan = dataParking.extractIdJenisKendaraan(
                        selectedItem ?? placeHolderItem);

                    context.read<CheckInNoBookingBloc>().add(ParkingCheckInWithOutBooking(
                        fotoKendaraan: image!,
                        idJenisKendaraan: idJenisKendaraan,
                        delegate: this));
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

  Widget buildPlaceHolder() {
    return InkWell(
      onTap: () => takeImageFromCamera(),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: double.infinity,
            color: AppTheme.lightGrey,
            child: const Icon(
              Icons.add_a_photo,
              color: AppTheme.primaryColor,
              size: 108,
            )),
      ),
    );
  }

  Widget buildImageHolder() {
    return InkWell(
      onTap: () => takeImageFromCamera(),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.40,
          width: double.infinity,
          color: AppTheme.lightGrey,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.file(image!, fit: BoxFit.cover))),
    );
  }

  Future takeImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {}
      });
    });
  }

  @override
  void onFailed(String message) {
    Navigator.pop(context);
    showFailedDialog(
        context: context,
        title: "Gagal!",
        message: message,
        onTap: () {
          Navigator.pop(context);
        });
  }

  @override
  void onLoading() {
    showLoadingDialog(context: context);
  }

  @override
  void onSuccess(String message) {
    Navigator.pop(context);

    List<String> vals = message.split(',');

    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (c) => SuccessParkPage(
          successMessage: 'Transaksi masuk parkir berhasil..',
          vehicleType: selectedItem,
          location: vals[0],
          parkingCode: vals[1],
          requiredPrinter: vals[2],
        ),
      ),
    );
  }
}
