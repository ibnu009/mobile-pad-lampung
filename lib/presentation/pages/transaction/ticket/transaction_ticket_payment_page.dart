import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/button/primary_button.dart';
import '../../../components/input/generic_text_input_no_border.dart';

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
  int ticketPrice = 20000;

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
            buildTransactionItems(
                'Tiket Masuk', 'Rp 20.000 / Orang', () => null),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all( 12),
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
                          onPressed: () {},
                          height: 43,
                          horizontalPadding: 32,
                          text: 'Bayar')
                    ],
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPromo(){
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

  Widget buildTransactionItems(
      String title, String description, Function() onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
          onTap: onTap,
          title: Text(title),
          subtitle: Text(
            description,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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

  void calculateTotal() {
    total = ticketPrice * ticketQuantity;
  }
}
