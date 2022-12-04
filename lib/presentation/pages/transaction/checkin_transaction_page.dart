import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';

class CheckInPostTransactionPage extends StatefulWidget {
  const CheckInPostTransactionPage({Key? key}) : super(key: key);

  @override
  State<CheckInPostTransactionPage> createState() => _CheckInPostTransactionPageState();
}

class _CheckInPostTransactionPageState extends State<CheckInPostTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(width: double.infinity,),
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
                'Terimakasih',
                style: AppTheme.subTitle,
              ),
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                onPressed: () => Navigator.pop(context),
                horizontalPadding: 32,
                height: 45,
                text: 'Kembali'),
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
}
