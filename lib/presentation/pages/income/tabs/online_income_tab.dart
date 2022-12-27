import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/ticket/income/online/ticket_income_online_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/income/online/ticket_income_online_event.dart';
import 'package:pad_lampung/presentation/bloc/ticket/online/ticket_online_bloc.dart';
import 'package:pad_lampung/presentation/components/button/icon_primary_button.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/date_time_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_ticket_income_ext.dart';

import '../../../bloc/ticket/income/online/ticket_income_online_state.dart';

class OnlineIncomeTab extends StatefulWidget {
  const OnlineIncomeTab({Key? key}) : super(key: key);

  @override
  State<OnlineIncomeTab> createState() => _OnlineIncomeTabState();
}

class _OnlineIncomeTabState extends State<OnlineIncomeTab> {
  String selectedItem = initialDataShown;

  int currentPage = 0;
  int itemPerPage = 5;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    context.read<TicketIncomeOnlineBloc>().add(
        GetOnlineTicketIncome(
            offset: offset, limit: itemPerPage));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder(
            bloc: context.read<TicketIncomeOnlineBloc>(),
            builder: (ctx, state) {
              if (state is SuccessShowOnlineTicketIncome) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 0, 4),
                            child: Text(
                              DateTime.now().toFormattedDate(),
                              style: AppTheme.bodyText,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 16, 4),
                            child: Text(
                              state.grandTotal.toRupiah(),
                              style: AppTheme.smallTitle,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Text('Show'),
                            GenericDropdown(
                              selectedItem: selectedItem,
                              height: 40,
                              items: dataShownItem,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedItem = value ?? initialDataShown;
                                  itemPerPage = int.parse(selectedItem);
                                  currentPage = 0;
                                });
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),

                      state.data.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: Text('Data kosong')),
                            )
                          : Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: state.data.toDataRow(),
                            ),
                    ],
                  ),
                );
              }
              if (state is LoadingTicketIncomeOnline) {
                return const Center(child: LoadingWidget());
              }
              return SizedBox();
            },
          ),
          BlocBuilder(
            bloc: context.read<TicketIncomeOnlineBloc>(),
            builder: (ctx, state) {
              print('called state online');
              if (state is SuccessShowOnlineTicketIncome) {
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
                      context.read<TicketIncomeOnlineBloc>().add(
                          GetOnlineTicketIncome(
                              offset: offset, limit: itemPerPage));
                    },
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
