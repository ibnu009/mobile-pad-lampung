import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_event.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_state.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/pages/home/parking/widget/data_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/parking/widget/list_holder_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<ParkingHomeBloc>().add(GetParkingData());
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

              return SizedBox();
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
      },
      child: SingleChildScrollView(
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
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: DataHolderWidget(),
            ),
            ListHolderWidget(data: data),
          ],
        ),
      ),
    );
  }
}
