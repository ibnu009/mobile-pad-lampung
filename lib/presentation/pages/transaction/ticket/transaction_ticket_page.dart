import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/transaction_ticket_payment_page.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import 'transaction_toilet_payment_page.dart';

class TransactionTicketPage extends StatelessWidget {
  const TransactionTicketPage({Key? key}) : super(key: key);

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
              child: GenericAppBar(url: '', title: 'Transaksi'),
            ),
            const SizedBox(height: 12,),
            buildTransactionItems('Tiket', 'Masuk Pantai Ketapang', () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => TransactionTicketPaymentPage(),));
            }),
            buildTransactionItems('Toilet', 'Fasilitas', () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => TransactionToiletPaymentPage(),));
            })
          ],
        ),
      ),
    );
  }

  Widget buildTransactionItems(String title,String description, Function() onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(title == 'Tiket' ? "assets/icons/ticket_icon.svg"  : "assets/icons/toilet_icon.svg",
            semanticsLabel: 'A red up arrow'),
        title: Text(title),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15, color: AppTheme.primaryColorDarker,)
      ),
    );
  }
}
