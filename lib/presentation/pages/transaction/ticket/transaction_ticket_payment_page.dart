import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/bloc/ticket/price/ticket_price_event.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/post_ticket_transaction_page.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/transaction_ticket_payment_type_page.dart';
import 'package:pad_lampung/presentation/utils/delegate/generic_delegate.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../bloc/ticket/price/ticket_price_bloc.dart';
import '../../../bloc/ticket/price/ticket_price_state.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/button/primary_button.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/generic/loading_widget.dart';
import '../../../components/input/generic_text_input_no_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionTicketPaymentPage extends StatefulWidget {
  const TransactionTicketPaymentPage({Key? key}) : super(key: key);

  @override
  State<TransactionTicketPaymentPage> createState() =>
      _TransactionTicketPaymentPageState();
}

class _TransactionTicketPaymentPageState
    extends State<TransactionTicketPaymentPage> {
  final TextEditingController? codeController = TextEditingController();

  int total = 0;
  int ticketQuantity = 0;
  int ticketDiscount = 0;
  int ticketPrice = 0;
  int idTarif = 0;

  @override
  void initState() {
    super.initState();
    context.read<TicketPriceBloc>().add(GetTicketPrice());
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 12,
            ),
            buildTransactionItems('Tiket Masuk'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: AppTheme.subTitle,
                  ),
                  Row(
                    children: [
                      Text(
                        total.toRupiah(),
                        style: AppTheme.title1,
                      ),
                      const Spacer(),
                      PrimaryButton(
                          context: context,
                          isEnabled: ticketQuantity != 0,
                          onPressed: () => handleBookingTicket('QRIS'),
                          height: 43,
                          horizontalPadding: 32,
                          text: 'Bayar')
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPromo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
            'Kode Promo',
            style: AppTheme.subTitle,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: GenericTextInputNoBorder(
                  controller: codeController!,
                  inputType: TextInputType.text,
                  hintText: 'xxx-xxx-xxx',
                  radius: 16,
                  maxLines: 1,
                  fillColor: AppTheme.inputFieldColor,
                  horizontalMargin: 0,
                  verticalMargin: 4,
                  prefixIcon: const Icon(
                    Icons.airplane_ticket_rounded,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                flex: 1,
                child: PrimaryButton(
                  context: context,
                  margin: 4,
                  isEnabled: codeController?.text.isNotEmpty ?? false,
                  width: double.infinity,
                  onPressed: () {},
                  text: 'Terapkan',
                  height: 43,
                  horizontalPadding: 4,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Potongan Harga Promo',
              style: AppTheme.smallTitle,
            ),
          ),
          Text(
            ticketDiscount.toRupiah(),
            style: AppTheme.smallTitle,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget buildTransactionItems(String title) {
    return BlocBuilder(
      bloc: context.read<TicketPriceBloc>(),
      builder: (ctx, state) {
        if (state is SuccessShowTicketPrice) {
          ticketPrice = state.price;
          idTarif = state.idTarif;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
                title: Text(title),
                subtitle: Text(
                  '${state.price.toRupiah()} / Orang',
                  style: AppTheme.subTitle.copyWith(fontSize: 14),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        if (ticketQuantity <= 0) {
                          return;
                        }
                        setState(() {
                          ticketQuantity--;
                          calculateTotal();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "$ticketQuantity",
                        style: AppTheme.smallTitle,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          ticketQuantity++;
                          calculateTotal();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )),
          );
        }

        if (state is LoadingTicketPrice) {
          return const Center(child: LoadingWidget());
        }

        if (state is FailedShowTicketPrice) {}

        return SizedBox();
      },
    );
  }

  void handleBookingTicket(String paymentMethod) {
    if (ticketQuantity == 0) {
      return;
    }

    Navigator.push(context,
        CupertinoPageRoute(builder: (c) => TransactionTicketPaymentTypePage(idTarif: idTarif, quantity: ticketQuantity,)));
  }

  void calculateTotal() {
    total = ticketPrice * ticketQuantity;
  }
}
