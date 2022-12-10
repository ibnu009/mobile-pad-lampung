import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/holder/ticket_home_content_holder.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/ticket_home_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/ticket_home_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/ticket_home_state.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/data_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/list_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/location_holder_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageTicket extends StatefulWidget {
  const HomePageTicket({Key? key}) : super(key: key);

  @override
  State<HomePageTicket> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTicket> {
  @override
  void initState() {
    super.initState();
    context.read<TicketHomeBloc>().add(GetTicketQuota());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: BlocBuilder(
          bloc: this.context.read<TicketHomeBloc>(),
          builder: (ctx, state) {
            if (state is SuccessShowTicketQuota) {
              return buildContent(state.data);
            }

            if (state is LoadingTicketHome) {
              return const Center(child: LoadingWidget());
            }

            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildContent(TicketHomeContentHolder data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: HomeAppBar(
              url: '',
            ),
          ),
          LocationTicketHolder(
            date: DateTime.now().toFormattedDate(),
            location: data.wisataName,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: DataHolderWidget(
                currentTotal: data.jumlahTiketTerjual,
                quota: data.quota,
                wisataName: data.wisataName),
          ),
          ListHolderWidget(),
        ],
      ),
    );
  }
}
