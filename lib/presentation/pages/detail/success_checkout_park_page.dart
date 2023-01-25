import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/pages/home/parking/home_page.dart';

import '../home/ticket/home_page.dart';

class SuccessCheckoutParkPage extends StatefulWidget {
  final String? successMessage;
  const SuccessCheckoutParkPage({Key? key, this.successMessage}) : super(key: key);

  @override
  State<SuccessCheckoutParkPage> createState() => _SuccessCheckoutParkPageState();
}

class _SuccessCheckoutParkPageState extends State<SuccessCheckoutParkPage> {

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(width: double.infinity,),
            buildSuccessWidget(buttonWidth),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: SizedBox(
                  width: 100,
                  child: Image.asset('assets/images/logo_pesat.png')),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildSuccessWidget(double buttonWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200.0,
          height: 200.0,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child:  SvgPicture.asset('assets/images/bx-badge-check.svg'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            widget.successMessage ?? 'Pembayaran Berhasil...',
            style: AppTheme.subTitle,
          ),
        ),

        const SizedBox(height: 16,),

        PrimaryButton(
            context: context,
            width: buttonWidth,
            isEnabled: true,
            onPressed: () async {
              showLoadingDialog(context: context, loadingText: 'Mencetak tiket..');
              await Future.delayed(const Duration(seconds: 2));
              if (mounted) {
                Navigator.pop(context);
              }
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Cetak Struk'),

        const SizedBox(height: 24,),

        PrimaryButton(
            context: context,
            width: buttonWidth,
            isEnabled: true,
            onPressed: () {
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (c) => const HomePage()));
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Selesai'),
      ],
    );
  }
}