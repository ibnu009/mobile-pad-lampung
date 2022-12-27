import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/pages/income/income_page.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../../../core/theme/app_primary_theme.dart';

class IncomeReportWidget extends StatelessWidget {
  final int onlineIncome, offlineIncome;

  const IncomeReportWidget({Key? key, required this.onlineIncome, required this.offlineIncome, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Text("Pendapatan Tunai"),
              const Spacer(),
              Text(offlineIncome.toRupiah(), style: AppTheme.smallTitle),
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              const Text("Pendapatan Non Tunai"),
              const Spacer(),
              Text(onlineIncome.toRupiah(), style: AppTheme.smallTitle,),
            ],
          ),
          const SizedBox(height: 8,),
          InkWell(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (ctx) => const IncomePage()));
            },
            child: Text("Detail", style: AppTheme.subTitle.copyWith(
              color: AppTheme.primaryColor,
            ),),
          ),
        ],
      )
    );
  }
}
