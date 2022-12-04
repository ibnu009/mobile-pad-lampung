import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/components/button/icon_primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_no_border.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../components/appbar/custom_generic_appbar.dart';
import '../../components/button/primary_button.dart';

class IzinPage extends StatefulWidget {
  const IzinPage({Key? key}) : super(key: key);

  @override
  State<IzinPage> createState() => _IzinPageState();
}

class _IzinPageState extends State<IzinPage> {
  final alasanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: GenericAppBarNoThumbnail(url: '', title: 'Izin'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Pilih Tanggal', style: AppTheme.subTitle),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconPrimaryButton(
                        context: context,
                        isEnabled: true,
                        onPressed: () {},
                        color: Colors.white,
                        iconFillColor: Colors.black54,
                        textColor: Colors.black54,
                        height: 45,
                        text: 'Tanggal Awal',
                        icon: Icons.date_range,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      flex: 1,
                      child: IconPrimaryButton(
                        context: context,
                        isEnabled: true,
                        onPressed: () {},
                        color: Colors.white,
                        iconFillColor: Colors.black54,
                        textColor: Colors.black54,
                        height: 45,
                        text: 'Tanggal Akhir',
                        icon: Icons.date_range,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Isi Alasan', style: AppTheme.subTitle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GenericTextInputNoBorder(
                  controller: alasanController,
                  inputType: TextInputType.text,
                  maxLines: 5,
                  maxLength: 50,
                ),
              ),
              Center(
                child: PrimaryButton(
                    width: MediaQuery.of(context).size.width * 0.4,
                    context: context,
                    isEnabled: true,
                    onPressed: () {
                      showYesNoDialog(
                        context: context,
                        title: 'Perhatian',
                        message: 'Apakah data yang dimasukkan sudah benar?',
                        onYesTap: () {
                          Navigator.pop(context);
                        },
                        onNoTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                    text: 'Kirim'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
