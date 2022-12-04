import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/pages/home/parking/widget/data_holder_widget.dart';
import 'package:pad_lampung/presentation/pages/home/parking/widget/list_holder_widget.dart';

import '../parking/widget/location_holder_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              const LocationHolder(
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
