import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/price/ticket_price_event.dart';
import 'package:pad_lampung/presentation/components/web/test_web.dart';
import 'package:pad_lampung/presentation/components/web/web_screen.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/post_ticket_transaction_page.dart';
import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../bloc/ticket/price/ticket_price_bloc.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/button/primary_button.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/input/generic_text_input.dart';
import '../../../components/input/generic_text_input_no_border.dart';
import '../../detail/success_checkout_park_page.dart';

const String qrisTypeText =
    'Pastikan pembeli menunjukkan bukti pembayaran dengan Qris telah berhasil di Gadgetnya.';
const String debitTypeText =
    'Pastikan proses pembayaran di mesin EDC telah berhasil dan struk telah dicetak.';

class TransactionParkirPaymentConfirmationPage extends StatefulWidget {
  final int price;
  final String paymentType, noTransaksi;
  final String? noPol;

  const TransactionParkirPaymentConfirmationPage(
      {Key? key,
      required this.price,
      required this.paymentType,
      required this.noTransaksi, required this.noPol})
      : super(key: key);

  @override
  State<TransactionParkirPaymentConfirmationPage> createState() =>
      _TransactionParkirPaymentConfirmationPageState();
}

class _TransactionParkirPaymentConfirmationPageState
    extends State<TransactionParkirPaymentConfirmationPage>
    with GenericDelegate, TickerProviderStateMixin {
  final TextEditingController paymentTotalController = TextEditingController();

  late AnimationController controller;

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
    controller.reverseDuration = const Duration(milliseconds: 500);
  }

  int totalChange = 0;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  Widget build(BuildContext context) {
    double widthButton = MediaQuery
        .of(context)
        .size
        .width * 0.7;
    double containerHeight = MediaQuery
        .of(context)
        .size
        .height * 0.30;

    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GenericAppBar(url: '', title: widget.paymentType),
            ),
            const SizedBox(
              height: 16,
            ),
            widget.paymentType == 'Tunai'
                ? buildCashPayment(containerHeight)
                : buildNonCashPayment(containerHeight),
            PrimaryButton(
                context: context,
                isEnabled: true,
                width: widthButton,
                onPressed: () {
                  handleParkirCheckOut();
                },
                horizontalPadding: 32,
                height: 45,
                text: 'Lanjutkan'),
          ],
        ),
      ),
    );
  }

  Widget buildNonCashPayment(double containerHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.paymentType == 'Debit' ? 'Debit' : 'Pembayaran QRIS',
            style: AppTheme.subTitle,
          ),
          Text(
            widget.paymentType == 'Debit' ? debitTypeText : qrisTypeText,
            style: AppTheme.primaryTextStyle,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget buildCashPayment(double containerHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                'Total Harga',
                style: AppTheme.smallTitle,
              ),
              const Spacer(),
              Text(
                widget.price.toRupiah(),
                style: AppTheme.title.copyWith(color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Pembayaran Tunai',
                style: AppTheme.smallTitle,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GenericTextInputNoBorder(
                  controller: paymentTotalController,
                  inputType: TextInputType.number,
                  hintText: 'Masukkan Jumlah',
                  textAlign: TextAlign.end,
                  horizontalMargin: 0,
                  maxLines: 1,
                  fillColor: AppTheme.inputFieldColor,
                  onChanged: (value) => calculateChange(value),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Kembali',
                style: AppTheme.smallTitle,
              ),
              const Spacer(),
              Text(
                totalChange.toRupiah(),
                style: AppTheme.subTitle,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void calculateChange(String value) {
    if (value.isEmpty) {
      setState(() {
        totalChange = 0;
      });
      return;
    }
    ;

    setState(() {
      totalChange = int.parse(value) - widget.price;
    });
  }

  void handleParkirCheckOut() {
    context.read<ParkingDetailBloc>().add(CheckOutParkingNew(
        widget.noTransaksi, widget.noPol ?? '', this));
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
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (c) => SuccessCheckoutParkPage()));
  }
}
