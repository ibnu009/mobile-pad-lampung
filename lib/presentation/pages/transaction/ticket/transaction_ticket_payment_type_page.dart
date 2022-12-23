import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/price/ticket_price_event.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/post_ticket_transaction_page.dart';
import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../bloc/ticket/price/ticket_price_bloc.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/button/primary_button.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/input/generic_text_input_no_border.dart';

class TransactionTicketPaymentTypePage extends StatefulWidget {
  final int idTarif, quantity;
  const TransactionTicketPaymentTypePage({Key? key, required this.idTarif, required this.quantity}) : super(key: key);

  @override
  State<TransactionTicketPaymentTypePage> createState() =>
      _TransactionTicketPaymentTypePageState();
}

class _TransactionTicketPaymentTypePageState
    extends State<TransactionTicketPaymentTypePage> with GenericDelegate {
  final TextEditingController? codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TicketPriceBloc>().add(GetTicketPrice());
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
                isEnabled: false,
                width: widthButton,
                onPressed: () {
                },
                horizontalPadding: 32,
                height: 45,
                text: 'QRIS'),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
                context: context,
                isEnabled: false,
                width: widthButton,
                onPressed: () {
                },
                horizontalPadding: 32,
                height: 45,
                text: 'E-Money'),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
                context: context,
                isEnabled: true,
                width: widthButton,
                onPressed: () {
                  handleBookingTicket('Cash');
                },
                horizontalPadding: 32,
                height: 45,
                text: 'Cash'),
          ],
        ),
      ),
    );
  }

  void handleBookingTicket(String paymentMethod) {
    context.read<TicketPriceBloc>().add(ProcessTicketBooking(
        paymentMethod: paymentMethod,
        quantity: widget.quantity,
        idTarif: widget.idTarif,
        delegate: this));
  }

  @override
  void onFailed(String message) {
    Navigator.pop(context);
    showFailedDialog(
        context: context,
        title: "Gagal",
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
    Navigator.push(context,
        CupertinoPageRoute(builder: (c) => PostTicketTransactionPage(transactionNumber: message,)));
  }
}
