import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/xendit/transaction_xendit_payment_method_page.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/button/primary_button.dart';
import 'transaction_parkir_payment_confirmation_page.dart';

class TransactionParkirPaymentTypePage extends StatefulWidget {
  final int price, idTransaksi;
  final String noTransaksi;
  final String? noPol;

  const TransactionParkirPaymentTypePage(
      {Key? key,
      required this.price,
      required this.noTransaksi,
      this.noPol, required this.idTransaksi})
      : super(key: key);

  @override
  State<TransactionParkirPaymentTypePage> createState() =>
      _TransactionParkirPaymentTypePageState();
}

class _TransactionParkirPaymentTypePageState
    extends State<TransactionParkirPaymentTypePage> {
  final TextEditingController? codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthButton = MediaQuery.of(context).size.width * 0.7;
    double topPadding = MediaQuery.of(context).size.height * 0.20;

    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: GenericAppBar(url: '', title: 'Keluar Parkir'),
            ),
            SizedBox(
              height: topPadding,
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                width: widthButton,
                onPressed: () => handleCheckOutParkir('Debit'),
                horizontalPadding: 32,
                height: 45,
                text: 'Debit'),
            const SizedBox(
              height: 32,
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                width: widthButton,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => TransactionXenditPaymentMethodPage(
                        quantity: 1,
                        noPol: widget.noPol,
                        price: widget.price,
                        paymentType: 'Pembayaran Online',
                        noTransaksi: widget.noTransaksi, idTransaksi: widget.idTransaksi,
                      ),
                    ),
                  );
                },
                horizontalPadding: 32,
                height: 45,
                text: 'Pembayaran Online'),
            const SizedBox(
              height: 32,
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                width: widthButton,
                onPressed: () => handleCheckOutParkir('Tunai'),
                horizontalPadding: 32,
                height: 45,
                text: 'Tunai'),
          ],
        ),
      ),
    );
  }

  void handleCheckOutParkir(String paymentMethod) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => TransactionParkirPaymentConfirmationPage(
          noPol: widget.noPol,
          price: widget.price,
          paymentType: paymentMethod,
          noTransaksi: widget.noTransaksi,
        ),
      ),
    );
  }
}
