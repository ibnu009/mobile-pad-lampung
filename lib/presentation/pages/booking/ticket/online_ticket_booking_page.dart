import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pad_lampung/presentation/bloc/ticket/online/ticket_online_state.dart';
import 'package:pad_lampung/presentation/components/button/icon_svg_primary_button.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_no_border.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_ticket_ext.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../bloc/ticket/online/ticket_online_bloc.dart';
import '../../../bloc/ticket/online/ticket_online_event.dart';
import '../../../components/appbar/custom_generic_appbar.dart';
import '../../../components/generic/loading_widget.dart';
import 'scan_online_booking_ticket_page.dart';

class OnlineTicketBookingPage extends StatefulWidget {
  const OnlineTicketBookingPage({Key? key}) : super(key: key);

  @override
  State<OnlineTicketBookingPage> createState() =>
      _OnlineTicketBookingPageState();
}

class _OnlineTicketBookingPageState extends State<OnlineTicketBookingPage> {
  String selectedItem = initialDataShown;

  TextEditingController searchController = TextEditingController();

  int itemPerPage = 5;
  int currentPage = 0;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    context
        .read<TicketOnlineBloc>()
        .add(GetOnlineTicketBooking(offset: offset, limit: itemPerPage, query: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              offset = 0;
              itemPerPage = 5;
              selectedItem = initialDataShown;
              currentPage = 0;
            });
            context
                .read<TicketOnlineBloc>()
                .add(GetOnlineTicketBooking(offset: offset, limit: itemPerPage, query: ''));
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
                const SizedBox(
                  height: 22,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text(
                                  'Data Ticketing',
                                  style: AppTheme.smallTitle
                                      .copyWith(fontWeight: FontWeight.w700),
                                )),
                            Expanded(
                                flex: 1,
                                child: IconSvgPrimaryButton(
                                  context: context,
                                  isEnabled: true,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const ScanOnlineBookingTicketPage()));
                                  },
                                  height: 43,
                                  text: 'Pindai Tiket',
                                  iconAsset: 'assets/icons/barcode_icon.svg',
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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

                                context.read<TicketOnlineBloc>().add(
                                    GetOnlineTicketBooking(
                                        offset: offset,
                                        limit: itemPerPage,
                                        query: ''));
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: GenericTextInputNoBorder(
                                  fillColor: AppTheme.inputFieldColor,
                                  suffixIcon: const Icon(Icons.search),
                                  horizontalMargin: 0,
                                  hintText: 'Cari',
                                  onSubmitted: (value) {
                                    print('value is $value');
                                    context.read<TicketOnlineBloc>().add(
                                        GetOnlineTicketBooking(
                                            offset: offset,
                                            limit: itemPerPage,
                                            query: ''));
                                  },
                                  controller: searchController,
                                  inputType: TextInputType.text),
                            )
                          ],
                        ),
                      ),
                      BlocBuilder(
                        bloc: this.context.read<TicketOnlineBloc>(),
                        builder: (ctx, state) {
                          if (state is SuccessShowOnlineTicket) {
                            return Column(
                              children: [
                                Table(
                                  defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                                  children: state.data.toDataRowOnline(),
                                ),

                                 Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Visibility(
                                    visible: state.data.isEmpty,
                                      child: const Center(child: Text('Data kosong'))),
                                )
                              ],
                            );
                          }

                          if (state is LoadingTicketOnline) {
                            return const Center(child: LoadingWidget());
                          }

                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder(
                  bloc: this.context.read<TicketOnlineBloc>(),
                  builder: (ctx, state) {
                    if (state is SuccessShowOnlineTicket) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        child: NumberPaginator(
                          numberPages: state.totalData
                              .getTotalPageByTotalData(itemPerPage),
                          config: NumberPaginatorUIConfig(
                            // default height is 48
                            height: 46,
                            buttonShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            buttonSelectedForegroundColor: Colors.white,
                            buttonUnselectedForegroundColor: Colors.black,
                            buttonUnselectedBackgroundColor:
                                AppTheme.neutralColor,
                            buttonSelectedBackgroundColor:
                                AppTheme.primaryColor,
                          ),
                          initialPage: currentPage,
                          onPageChange: (int index) {
                            setState(() {
                              print('offset is ${index * itemPerPage}');
                              offset = (index * itemPerPage);
                              currentPage = index;
                            });

                            context.read<TicketOnlineBloc>().add(
                                GetOnlineTicketBooking(
                                    offset: offset,
                                    limit: itemPerPage,
                                    query: ''));
                          },
                        ),
                      );
                    }

                    return const SizedBox();
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
