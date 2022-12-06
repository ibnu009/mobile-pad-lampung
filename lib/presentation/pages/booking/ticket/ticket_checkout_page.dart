import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/park/park_event.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/post_transaction_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

import '../../../bloc/park/park_bloc.dart';
import '../../../bloc/park/park_state.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/dropdown/dropdown_value.dart';
import '../../../components/dropdown/generic_dropdown.dart';

class TicketCheckOutPage extends StatefulWidget {
  final String ticketId;

  const TicketCheckOutPage({Key? key, required this.ticketId})
      : super(key: key);

  @override
  State<TicketCheckOutPage> createState() => _TicketCheckOutPageState();
}

class _TicketCheckOutPageState extends State<TicketCheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: GenericAppBar(url: '', title: 'Data Pesanan'),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRowDetailData('ID Pesanan', widget.ticketId),
                    buildRowDetailData('Jumlah', '6 Tiket'),
                    buildRowDetailData('Tanggal ', '15:00 / 01 Des 2022'),
                  ],
                ),
              ),
              const SizedBox(height: 32,),
              PrimaryButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.55,
                  isEnabled: true,
                  onPressed: () {},
                  text: 'Cetak Gelang')
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRowDetailData(String tittle, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              tittle,
              style: AppTheme.smallTitle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(data),
          ),
        ],
      ),
    );
  }
}
