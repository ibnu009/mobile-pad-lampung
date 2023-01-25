import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';

import '../../home/parking/home_page.dart';

class PostTransactionPage extends StatefulWidget {
  const PostTransactionPage({Key? key}) : super(key: key);

  @override
  State<PostTransactionPage> createState() => _PostTransactionPageState();
}

class _PostTransactionPageState extends State<PostTransactionPage> {
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
              child: const LoadingWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                'Terimakasih..',
                style: AppTheme.subTitle,
              ),
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                onPressed: () {
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (c) => const HomePage()));
                },
                width: MediaQuery.of(context).size.width * 0.7,
                horizontalPadding: 32,
                height: 45,
                text: 'Kembali Ke Beranda'),
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
