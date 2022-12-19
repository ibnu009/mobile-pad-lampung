import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/bloc/ticket/online/ticket_online_state.dart';
import 'package:pad_lampung/presentation/pages/booking/ticket/widget/list_holder_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../bloc/ticket/online/ticket_online_bloc.dart';
import '../../../bloc/ticket/online/ticket_online_event.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/generic/loading_widget.dart';

class OnlineTicketBookingPage extends StatefulWidget {
  const OnlineTicketBookingPage({Key? key}) : super(key: key);

  @override
  State<OnlineTicketBookingPage> createState() =>
      _OnlineTicketBookingPageState();
}

class _OnlineTicketBookingPageState extends State<OnlineTicketBookingPage> {
  @override
  void initState() {
    super.initState();
    context.read<TicketOnlineBloc>().add(GetOnlineTicketBooking());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async{
            context.read<TicketOnlineBloc>().add(GetOnlineTicketBooking());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: GenericAppBar(url: '', title: 'Pesanan Online'),
                ),
                SizedBox(
                  height: 16,
                ),
                BlocBuilder(
                  bloc: this.context.read<TicketOnlineBloc>(),
                  builder: (ctx, state) {
                    if (state is SuccessShowOnlineTicket) {
                      return ListBookingOnlineHolderWidget(
                        tickets: state.data,
                      );
                    }

                    if (state is LoadingTicketOnline) {
                      return const Center(child: LoadingWidget());
                    }

                    return SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
