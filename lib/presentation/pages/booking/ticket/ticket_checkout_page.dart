import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_state.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/post_ticket_transaction_page.dart';

import '../../../components/dialog/dialog_component.dart';
import '../success_print_ticket_page.dart';

class TicketCheckOutPage extends StatefulWidget {
  final String ticketId;

  const TicketCheckOutPage({Key? key, required this.ticketId})
      : super(key: key);

  @override
  State<TicketCheckOutPage> createState() => _TicketCheckOutPageState();
}

class _TicketCheckOutPageState extends State<TicketCheckOutPage> {

  @override
  void initState() {
    super.initState();
    context.read<TicketDetailBloc>().add(GetTicketDetail(widget.ticketId));
  }

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
              BlocBuilder(
                  bloc: context.read<TicketDetailBloc>(),
                  builder: (context, state) {
                    if (state is SuccessShowTicketDetail) {
                      return buildContent(state.quantity, state.tanggal);
                    }

                    if (state is FailedShowTicketDetail) {
                      showFailedDialog(
                          context: context,
                          title: 'Terjadi Kesalahan',
                          onTap: () => Navigator.pop(context),
                          message: state.message);
                      return const LoadingWidget();
                    }

                    return const LoadingWidget();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(int ticketSold, String scanDate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowDetailData('ID Pesanan', widget.ticketId),
              buildRowDetailData('Jumlah', '$ticketSold Tiket'),
              buildRowDetailData('Tanggal ', scanDate),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        PrimaryButton(
            context: context,
            width: MediaQuery.of(context).size.width * 0.55,
            isEnabled: true,
            onPressed: () async {
              showLoadingDialog(context: context, loadingText: 'Mencetak Gelang..');
              await Future.delayed(const Duration(seconds: 2));
              Navigator.push(context, CupertinoPageRoute(builder: (c) => const PrintTicketSuccessPage()));
            },
            text: 'Cetak Gelang')
      ],
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
