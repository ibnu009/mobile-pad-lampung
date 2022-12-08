import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/data_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/list_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/ticket/widget/location_holder_widget.dart';

import '../parking/widget/location_holder_widget.dart';

class HomePageTicket extends StatefulWidget {
  const HomePageTicket({Key? key}) : super(key: key);

  @override
  State<HomePageTicket> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
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
              LocationTicketHolder(
                date: '01 Des 2022',
                location: 'Dermaga Ketapang',
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: DataHolderWidget(),
              ),
              ListHolderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
