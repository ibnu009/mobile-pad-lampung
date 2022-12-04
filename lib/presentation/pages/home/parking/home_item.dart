import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/transaction_page.dart';

class HomeItem extends StatelessWidget {
  final String name;
  const HomeItem({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (c) => TransactionPage()));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Icon(Icons.directions_boat, color: Colors.white, size: 25,),
              const SizedBox(width: 8,),
              Text(name, style: const TextStyle(color: Colors.white, fontSize: 16.0),)
            ],
          ),
        ),
      ),
    );
  }
}
