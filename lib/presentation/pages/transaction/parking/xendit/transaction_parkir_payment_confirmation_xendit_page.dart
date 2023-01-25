import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/bloc/xendit/payment_xendit_bloc.dart';
import 'package:pad_lampung/presentation/bloc/xendit/payment_xendit_event.dart';
import 'package:pad_lampung/presentation/components/web/web_screen.dart';
import 'package:pad_lampung/presentation/pages/detail/success_checkout_park_page.dart';
import 'package:pad_lampung/presentation/pages/home/parking/home_page.dart';
import 'package:pad_lampung/presentation/utils/delegate/xendit_payment_delegate.dart';

import '../../../../../core/theme/app_primary_theme.dart';
import '../../../../bloc/xendit/payment_xendit_state.dart';
import '../../../../components/appbar/custom_generic_appbar.dart';
import '../../../../components/button/primary_button.dart';
import '../../../../components/dialog/dialog_component.dart';

const String qrisTypeText =
    'Pastikan pembeli menunjukkan bukti pembayaran dengan E-Wallet telah berhasil di Gadgetnya.';
const String debitTypeText =
    'Pastikan proses pembayaran di mesin EDC telah berhasil dan struk telah dicetak.';

class TransactionParkirPaymentConfirmationXenditPage extends StatefulWidget {
  final int price, idTransaksi, servicePrice;
  final String paymentType, paymentMethod, noTransaksi;
  final String? paymentUrl;

  const TransactionParkirPaymentConfirmationXenditPage({
    Key? key,
    required this.price,
    required this.paymentType,
    required this.paymentMethod,
    required this.noTransaksi,
    required this.idTransaksi,
    required this.servicePrice,
    this.paymentUrl,
  }) : super(key: key);

  @override
  State<TransactionParkirPaymentConfirmationXenditPage> createState() =>
      _TransactionParkirPaymentConfirmationXenditPageState();
}

class _TransactionParkirPaymentConfirmationXenditPageState
    extends State<TransactionParkirPaymentConfirmationXenditPage>
    with XenditPaymentDelegate, TickerProviderStateMixin {
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

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<PaymentXenditBloc>(),
      listener: (ctx, state) {
        if (state is LoadingPaymentXendit) {
          showLoadingDialog(context: context);
          return;
        }

        if (state is SuccessCreateXenditPayment) {
          Navigator.pop(context);
          showBottomModal(state.paymentUrl);
          context.read<PaymentXenditBloc>().add(CheckXenditPayment(this));
          return;
        }

        if (state is FailedPaymentXenditState) {
          Navigator.pop(context);
          showFailedDialog(
              context: context,
              title: "Gagal!",
              message: state.message,
              onTap: () {
                Navigator.pop(context);
              });
          return;
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthButton = MediaQuery.of(context).size.width * 0.7;
    double containerHeight = MediaQuery.of(context).size.height * 0.30;
    if (widget.paymentUrl != null) {
      showBottomModal(widget.paymentUrl ?? "");
    }

    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: blocListener(
        child: SafeArea(
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
              buildNonCashPayment(containerHeight),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(
                  context: context,
                  isEnabled: true,
                  width: widthButton,
                  onPressed: () {
                    handleBookingTicket();
                  },
                  horizontalPadding: 32,
                  height: 45,
                  text: 'Lanjutkan'),
            ],
          ),
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
            'Pembayaran Online',
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

  void handleBookingTicket() {
    context.read<PaymentXenditBloc>().add(CreateParkirXenditPayment(
        price: widget.price,
        paymentMethod: widget.paymentMethod,
        noTransaksi: widget.noTransaksi,
        idTransaksi: widget.idTransaksi,
        servicePrice: widget.servicePrice));
  }

  void showBottomModal(String url) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isDismissible: false,
        backgroundColor: Colors.white,
        transitionAnimationController: controller,
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        builder: (builder) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon:
                          const Icon(Icons.close, color: Colors.red, size: 24),
                      color: Colors.red,
                      onPressed: () {
                        showYesNoDialog(
                            context: context,
                            title: 'Cancel Payment',
                            message:
                                'Apakah Anda yakin untuk membatalkan pembayaran?',
                            onYesTap: () {
                              Navigator.pop(context);
                              context
                                  .read<PaymentXenditBloc>()
                                  .add(CancelParkirXenditPayment());
                            },
                            onNoTap: () {
                              Navigator.pop(context);
                            });
                      },
                    ),
                  ],
                ),
                WebviewWidget(
                  url: url,
                ),
              ],
            ));
  }

  @override
  void onNeedRepeatRequest() {
    context.read<PaymentXenditBloc>().add(CheckXenditPayment(this));
  }

  @override
  void onPaymentCanceled() {
    print('Payment Canceled');
    Navigator.pop(context);

    if (widget.paymentUrl != null) {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (c) => const HomePage()));
    }
  }

  @override
  void onPaymentFailed(String message) {
    showFailedDialog(context: context, title: 'Oops!', message: message);
  }

  @override
  void onPaymentSuccess(String transactionNumber) {
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (c) => const SuccessCheckoutParkPage()));
  }
}
