import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_no_border.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../components/appbar/custom_generic_appbar.dart';
import '../../components/button/primary_button.dart';
import '../../components/dropdown/dropdown_value.dart';
import '../../components/dropdown/generic_dropdown.dart';
import '../../components/image/image_full_screen.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  final alasanController = TextEditingController();
  String selectedItem = initialLaporanDataShown;

  List<File> images = [];
  final picker = ImagePicker();

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
                child: GenericAppBarNoThumbnail(url: '', title: 'Laporan'),
              ),
              GenericDropdown(
                selectedItem: selectedItem,
                items: laporanDataShown,
                height: 45,
                width: double.infinity,
                backgroundColor: Colors.white,
                borderColor: Colors.transparent,
                onChanged: (String? value) {
                  setState(() {
                    selectedItem = value ?? initialLaporanDataShown;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text('Foto', style: AppTheme.subTitle),
                    const Spacer(),
                    Text('${images.length}/5'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _buildImageGallery(),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Isi Laporan', style: AppTheme.subTitle),
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

  Widget _buildImageGallery() {
    List<Widget> resultWidget = [];
    resultWidget.add(const SizedBox(
      width: 16,
    ));
    resultWidget.add(_buildImagePlaceHolder());
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        File img = images[i];
        String heroTag = "heroTag $i";
        resultWidget.add(_buildImageResultHolder(img, heroTag, i));
      }
    }
    resultWidget.add(const SizedBox(
      width: 16,
    ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: resultWidget,
      ),
    );
  }

  Widget _buildImageResultHolder(File image, String heroTag, int position) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ImageFullScreen(
                    image: image,
                    heroTag: heroTag,
                  ),
                ),
              );
            },
            child: Hero(
              tag: heroTag,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(image, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                showYesNoDialog(
                    context: context,
                    title: 'Perhatian',
                    message: 'Yakin untuk menghapus foto ini?',
                    onYesTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        images.removeAt(position);
                      });
                    },
                    onNoTap: () {
                      Navigator.of(context).pop();
                    });
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImagePlaceHolder() {
    return InkWell(
      onTap: () => openCamera(),
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset('assets/icons/icon_photo.svg', fit: BoxFit.scaleDown),
          ),
        ),
      ),
    );
  }

  Future openCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (images.length >= 5) {
      if (!mounted) return;
      showOkDialog(
          context, 'Perhatian', 'Foto yang kamu ambil telah mencapai batas');
      return;
    }

    setState(() {
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      } else {}
    });
  }
}
