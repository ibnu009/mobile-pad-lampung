import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/bloc/park/detail/parking_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/home/park_home_bloc.dart';
import 'package:pad_lampung/presentation/bloc/park/park_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/detail/ticket_detail_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/online/ticket_online_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/payment_status/ticket_payment_status_bloc.dart';
import 'package:pad_lampung/presentation/bloc/ticket/scan/ticket_scan_bloc.dart';
import 'package:pad_lampung/presentation/pages/auth/login_page.dart';
import 'package:pad_lampung/presentation/pages/starter/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:pad_lampung/di/application_module.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/auth/login_bloc.dart';
import 'presentation/bloc/starter/starter_bloc.dart';
import 'presentation/bloc/ticket/price/ticket_price_bloc.dart';
import 'presentation/bloc/ticket/ticket_home_bloc.dart';
import 'presentation/utils/helper/http_override.dart';

Future<void> main() async {
  await di.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<StarterBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ParkBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TicketHomeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ParkingHomeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TicketPriceBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TicketPaymentStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TicketOnlineBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TicketScanBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TicketDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ParkingDetailBloc>(),
        ),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen()
      ),
    );
  }
}