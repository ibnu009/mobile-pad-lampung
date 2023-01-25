import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/transaction_ticket_payment_confirmation_page.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/xendit/transaction_xendit_payment_method_page.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/button/primary_button.dart';

class TransactionTicketPaymentTypePage extends StatefulWidget {
  final int idTarif, quantity, price;

  const TransactionTicketPaymentTypePage(
      {Key? key,
      required this.idTarif,
      required this.quantity,
      required this.price})
      : super(key: key);

  @override
  State<TransactionTicketPaymentTypePage> createState() =>
      _TransactionTicketPaymentTypePageState();
}

class _TransactionTicketPaymentTypePageState
    extends State<TransactionTicketPaymentTypePage> {
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
              child: GenericAppBar(url: '', title: 'Tiket'),
            ),
            SizedBox(
              height: topPadding,
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                width: widthButton,
                onPressed: () => handleBookingTicket('Debit'),
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
                      builder: (context) =>
                          TransactionXenditPaymentMethodPage(
                              idTarif: widget.idTarif,
                              quantity: widget.quantity,
                              price: widget.price * widget.quantity,
                              paymentType: 'Pembayaran Online'),
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
                onPressed: () => handleBookingTicket('Tunai'),
                horizontalPadding: 32,
                height: 45,
                text: 'Tunai'),
          ],
        ),
      ),
    );
  }

  void handleBookingTicket(String paymentMethod) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => TransactionTicketPaymentConfirmationPage(
                idTarif: widget.idTarif,
                quantity: widget.quantity,
                price: widget.price * widget.quantity,
                paymentType: paymentMethod)));
  }
}
