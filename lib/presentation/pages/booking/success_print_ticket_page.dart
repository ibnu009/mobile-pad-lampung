import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';

import '../home/ticket/home_page.dart';

class PrintTicketSuccessPage extends StatefulWidget {
  const PrintTicketSuccessPage({Key? key}) : super(key: key);

  @override
  State<PrintTicketSuccessPage> createState() => _PrintTicketSuccessPageState();
}

class _PrintTicketSuccessPageState extends State<PrintTicketSuccessPage> {

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
            buildSuccessWidget(),
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

  Widget buildSuccessWidget() {
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
            'Berhasil Mencetak Tiket...',
            style: AppTheme.subTitle,
          ),
        ),

        const SizedBox(height: 16,),

        PrimaryButton(
            context: context,
            isEnabled: true,
            onPressed: () {
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (c) => const HomePageTicket()));
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Kembali Ke Home'),
      ],
    );
  }
}