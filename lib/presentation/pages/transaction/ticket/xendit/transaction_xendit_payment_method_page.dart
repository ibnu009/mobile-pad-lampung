import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/data/model/response/xendit_payment_method_response.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../bloc/xendit/method/method_xendit_bloc.dart';
import '../../../../bloc/xendit/method/method_xendit_event.dart';
import '../../../../bloc/xendit/method/method_xendit_state.dart';
import 'transaction_ticket_payment_confirmation_xendit_page.dart';

class TransactionXenditPaymentMethodPage extends StatefulWidget {
  final int idTarif, quantity, price;
  final String paymentType;

  const TransactionXenditPaymentMethodPage(
      {Key? key,
      required this.idTarif,
      required this.quantity,
      required this.price,
      required this.paymentType})
      : super(key: key);

  @override
  State<TransactionXenditPaymentMethodPage> createState() =>
      _TransactionXenditPaymentMethodPageState();
}

class _TransactionXenditPaymentMethodPageState
    extends State<TransactionXenditPaymentMethodPage> {
  int totalPay = 0;
  int transactionPay = 0;

  XenditPaymentMethod? selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    context.read<MethodXenditBloc>().add(GetXenditPaymentMethod());
  }

  @override
  Widget build(BuildContext context) {
    double widthButton = MediaQuery.of(context).size.width * 0.7;
    double containerHeight = MediaQuery.of(context).size.height * 0.20;

    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: GenericAppBar(url: '', title: 'Metode Pembayaran'),
            ),
            buildPaymentTotal(containerHeight),
            Expanded(
              child: BlocBuilder(
                bloc: context.read<MethodXenditBloc>(),
                builder: (context, state) {

                  if (state is LoadingMethodXendit) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }

                  if (state is ShowXenditMethodMethod) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.data.length,
                        itemBuilder: (ctx, index) {
                          XenditPaymentMethod paymentMethod = state.data[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 75,
                            child: RadioListTile(
                              title: Image.network(
                                paymentMethod.bankImage,
                              ),
                              value: paymentMethod,
                              groupValue: selectedPaymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentMethod = value;
                                  if (value != null) {
                                    calculateTotalPayment(value);
                                  }
                                });
                              },
                            ),
                          );
                        });
                  }

                  return const SizedBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: PrimaryButton(
                  context: context,
                  isEnabled: true,
                  width: widthButton,
                  onPressed: () {
                    if (selectedPaymentMethod == null) {
                      showWarningDialog(
                          context: context,
                          title: 'Perhatian',
                          message: 'Pilih Metode Pembayaran terlebih dahulu');
                      return;
                    }

                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (ctx) =>
                                TransactionTicketPaymentConfirmationXenditPage(
                                    idTarif: widget.idTarif,
                                    quantity: widget.quantity,
                                    price: widget.price,
                                    totalPrice: totalPay,
                                    paymentMethod:
                                        selectedPaymentMethod?.bankCode ?? "",
                                    paymentType: 'Pembayaran Online', servicePrice: transactionPay,)));
                  },
                  horizontalPadding: 32,
                  height: 55,
                  text: 'Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateTotalPayment(XenditPaymentMethod paymentMethod) {
    if (paymentMethod.costType == "PERSENTASE") {
      totalPay =
          widget.price + (widget.price * paymentMethod.costValue) ~/ 100;
      transactionPay = (widget.price * paymentMethod.costValue) ~/ 100;
      return;
    }

    totalPay = widget.price + paymentMethod.costValue.toInt();
    transactionPay = paymentMethod.costValue.toInt();
  }

  Widget buildPaymentTotal(double containerHeight) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
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
            'Total Transaksi',
            style: AppTheme.subTitle,
          ),
          Text(
            widget.price.toRupiah(),
            style: AppTheme.smallTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Biaya Transaksi',
            style: AppTheme.subTitle,
          ),
          Text(
            transactionPay.toRupiah(),
            style: AppTheme.smallTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Total Bayar',
            style: AppTheme.subTitle,
          ),
          Text(
            totalPay.toRupiah(),
            style: AppTheme.smallTitle,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
