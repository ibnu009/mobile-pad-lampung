import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_event.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_state.dart';
import 'package:pad_lampung/presentation/bloc/park/paging/parking_paging_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/paging/parking_paging_event.dart';
import 'package:pad_lampung/presentation/bloc/park/paging/parking_paging_state.dart';
import 'package:pad_lampung/presentation/bloc/ticket/paging/ticket_paging_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/paging/ticket_paging_event.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/components/modal/bottom_modal.dart';
import 'package:pad_lampung/presentation/pages/home/parking/widget/data_holder_widget.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/list_parking_ext.dart';

import '../../../../core/data/model/response/parking_response.dart';
import '../../../components/dialog/dialog_component.dart';
import '../../../components/generic/loading_widget.dart';
import '../../auth/login_page.dart';
import '../parking/widget/location_holder_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin  {

  String selectedItem = initialDataShown;

  late AnimationController controller;
  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
    controller.reverseDuration = const Duration(milliseconds: 500);
  }

  int currentPage = 0;
  int itemPerPage = 5;
  int offset = 0;

  @override
  void initState() {
    super.initState();
    initController();
    context.read<ParkingHomeBloc>().add(GetParkingData());
    context.read<ParkingPagingBloc>().add(GetParking(limit: itemPerPage, offset: offset));
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<ParkingHomeBloc>(),
      listener: (ctx, state) {
        if (state is ShowTokenExpired) {
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
      body: blocListener(
        child: SafeArea(
          child: BlocBuilder(
            bloc: this.context.read<ParkingHomeBloc>(),
            builder: (ctx, state) {

              if (state is SuccessShowParkingingData) {
                return buildContent(state.data);
              }

              if (state is LoadingParkingHome) {
                return const Center(child: LoadingWidget());
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<ParkingData> data){
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ParkingHomeBloc>().add(GetParkingData());
        context.read<ParkingPagingBloc>().add(GetParking(limit: itemPerPage, offset: offset));
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
            const LocationHolder(
              date: '01 Des 2022',
              location: 'Dermaga Ketapang',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: DataHolderWidget(),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text('Show'),
                        GenericDropdown(
                          selectedItem: selectedItem,
                          items: dataShownItem,
                          height: 45,
                          onChanged: (String? value) {
                            setState(() {
                              selectedItem = value ?? initialDataShown;
                              itemPerPage = int.parse(selectedItem);
                              currentPage = 0;
                            });
                            context.read<ParkingPagingBloc>().add(GetParking(offset: offset, limit: itemPerPage));
                          },
                        ),
                        const Spacer(),
                        const Text('Filter'),
                        InkWell(
                          onTap: () {
                            print("pressed");
                            showModalBottomSheet(
                                transitionAnimationController: controller,
                                isScrollControlled: true,
                                enableDrag: true,
                                context: context,
                                builder: (builder) => const HomeBottomModal());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.filter_list_rounded,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  BlocBuilder(
                    bloc: context.read<TicketPagingBloc>(),
                    builder: (ctx, state) {
                      if (state is SuccessShowParkingPagingData) {
                        return state.data.isEmpty
                            ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: Text('Data kosong')),
                        )
                            : Table(
                          defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                          children: state.data.toDataRowTable(context),
                        );
                      }

                      if (state is LoadingParkingPagingState) {
                        return const Center(child: LoadingWidget());
                      }

                      return const SizedBox();
                    },
                  ),


                ],
              ),
            ),


            //Page Controller
            BlocBuilder(
              bloc: context.read<ParkingPagingBloc>(),
              builder: (ctx, state) {
                print('called state online');
                if (state is SuccessShowParkingPagingData) {
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
                        context.read<ParkingPagingBloc>().add(GetParking(offset: offset, limit: itemPerPage));
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
