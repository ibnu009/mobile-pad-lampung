import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pad_lampung/core/data/model/holder/ticket_home_content_holder.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/home/ticket_home_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/home/ticket_home_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/home/ticket_home_state.dart';
import 'package:pad_lampung/presentation/bloc/ticket/paging/ticket_paging_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/paging/ticket_paging_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/paging/ticket_paging_state.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/pages/auth/login_page.dart';
import 'package:pad_lampung/presentation/pages/booking/ticket/online_ticket_booking_page.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/data_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/location_holder_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_ticket_ext.dart';

class HomePageTicket extends StatefulWidget {
  const HomePageTicket({Key? key}) : super(key: key);

  @override
  State<HomePageTicket> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTicket> {

  String selectedItem = initialDataShown;

  int currentPage = 0;
  int itemPerPage = 5;
  int offset = 0;


  @override
  void initState() {
    super.initState();
    context.read<TicketHomeBloc>().add(GetTicketQuota());
    context.read<TicketPagingBloc>().add(GetTicket(0, itemPerPage));
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<TicketHomeBloc>(),
      listener: (ctx, state) {
        if (state is ShowTokenExpiredHome) {
          showWarningDialog(
              context: context,
              title: "Perhatian!",
              message: state.message,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (c) => const LoginPage()));
              });
          return;
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: blocListener(
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
      ),
    );
  }

  Widget buildContent(TicketHomeContentHolder data) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TicketHomeBloc>().add(GetTicketQuota());
        context.read<TicketPagingBloc>().add(GetTicket(offset, itemPerPage));
        setState(() {
          currentPage = 0;
          itemPerPage = 5;
          selectedItem = initialDataShown;
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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

            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                        child: Text(
                          'Data Ticketing',
                          style:
                          AppTheme.smallTitle.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Text('Show'),
                            GenericDropdown(
                              selectedItem: selectedItem,
                              items: dataShownItem,
                              height: 40,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedItem = value ?? initialDataShown;
                                  itemPerPage = int.parse(selectedItem);
                                  currentPage = 0;
                                });
                                print('onchanged dropdown');
                              },
                            ),
                            const Spacer(),
                            FittedBox(
                              child: PrimaryButton(
                                  context: context,
                                  isEnabled: true,
                                  horizontalPadding: 8,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (c) =>
                                            const OnlineTicketBookingPage()));
                                  },
                                  height: 40,
                                  text: 'Pesanan Online'),
                            )
                          ],
                        ),
                      ),
                      BlocBuilder(
                        bloc: context.read<TicketPagingBloc>(),
                        builder: (ctx, state) {
                          if (state is SuccessShowTicketData) {
                            return state.data.isEmpty
                                ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: Text('Data kosong')),
                            )
                                : Table(
                              defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                              children: state.data.toDataRowPegawai(),
                            );
                          }
                          if (state is LoadingTicketPagingState) {
                            return const Center(child: LoadingWidget());
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder(
                  bloc: context.read<TicketPagingBloc>(),
                  builder: (ctx, state) {
                    print('called state online');
                    if (state is SuccessShowTicketData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        child: NumberPaginator(
                          numberPages:
                          state.totalData.getTotalPageByTotalData(itemPerPage),
                          config: NumberPaginatorUIConfig(
                            // default height is 48
                            height: 46,
                            buttonShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            buttonSelectedForegroundColor: Colors.white,
                            buttonUnselectedForegroundColor: Colors.black,
                            buttonUnselectedBackgroundColor: AppTheme.neutralColor,
                            buttonSelectedBackgroundColor: AppTheme.primaryColor,
                          ),
                          initialPage: currentPage,
                          onPageChange: (int index) {
                            setState(() {
                              print('offset is ${index * itemPerPage}');
                              offset = (index * itemPerPage);
                              currentPage = index;
                            });
                            context.read<TicketPagingBloc>().add(GetTicket(offset, itemPerPage));
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
