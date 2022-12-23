import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_state.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/ticket/home_page.dart';

class PostTicketTransactionPage extends StatefulWidget {
  final String transactionNumber;
  const PostTicketTransactionPage({Key? key, required this.transactionNumber}) : super(key: key);

  @override
  State<PostTicketTransactionPage> createState() => _PostTicketTransactionPageState();
}

class _PostTicketTransactionPageState extends State<PostTicketTransactionPage> {

  List<String> ticketCodes = [];
  int currentPrintedTicket = 0;
  int currentPrintedTicketIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<TicketPaymentStatusBloc>().add(GetPaymentStatus(widget.transactionNumber));

  }

  @override
  Widget build(BuildContext context) {

    double widthButton = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(width: double.infinity,),
            BlocBuilder(
              bloc: context.read<TicketPaymentStatusBloc>(),
              builder: (ctx, state) {
                if (state is SuccessShowTicketPayment) {
                  ticketCodes.clear();
                  ticketCodes.addAll(state.ticketCodes);
                  return buildSuccessWidget(widthButton, state.ticketCodes.length, context);
                }

                if (state is LoadingTicketPaymentStatus) {
                  return buildLoadingWidget();
                }

                if (state is FailedShowTicketPayment) {
                  return buildLoadingWidget();
                }
                return buildLoadingWidget();
              },
            ),
            const Spacer(),
            SizedBox(
                width: 100,
                child: Image.asset('assets/images/logo_pesat.png')),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildSuccessWidget(double widthButton, int totalTicket, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child:  SvgPicture.asset('assets/images/bx-badge-check.svg'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Text(
            'Pembayaran Berhasil...',
            style: AppTheme.subTitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Text(
            '$currentPrintedTicket / $totalTicket tiket telah dicetak',
            style: AppTheme.bodyText,
          ),
        ),
        PrimaryButton(
            context: context,
            isEnabled: true,
            width: widthButton,
            onPressed: () async {
              showLoadingDialog(context: context, loadingText: 'Struk sedang dicetak..');
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) return;
              Navigator.pop(context);
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Cetak Struk'),

        const SizedBox(height: 16,),

        PrimaryButton(
            context: context,
            isEnabled: true,
            width: widthButton,
            onPressed: () async {
              showLoadingDialog(context: context, loadingText: 'Gelang sedang dicetak..');
              await Future.delayed(const Duration(seconds: 2));
              if (!mounted) return;
              Navigator.pop(context);
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Cetak Tiket Masuk'),

        const SizedBox(height: 16,),

        PrimaryButton(
            context: context,
            isEnabled: true,
            width: widthButton,
            onPressed: () {
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (c) => const HomePageTicket()));
            },
            horizontalPadding: 32,
            height: 45,
            text: 'Kembali Ke Home'),
      ],
    );
  }


  Widget buildLoadingWidget() {
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
          child: const LoadingWidget(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            'Menunggu Pembayaran...',
            style: AppTheme.subTitle,
          ),
        ),
        PrimaryButton(
            context: context,
            isEnabled: true,
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.red,
            horizontalPadding: 32,
            height: 45,
            text: 'Batal'),
      ],
    );
  }
}