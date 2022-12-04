import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/components/button/icon_primary_button.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/transaction_page.dart';

class LocationHolder extends StatelessWidget {
  final String location, date;

  const LocationHolder({Key? key, required this.location, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(location),
        subtitle: Text(date),
        trailing: IconPrimaryButton(
          context: context,
          isEnabled: true,
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (c) => const TransactionPage()));
          },
          text: 'Transaksi',
          width: 115,
          paddingHorizontal: 4,
          icon: Icons.compare_arrows_rounded,
        ),
      ),
    );
  }
}
