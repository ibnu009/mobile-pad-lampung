import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/bloc/park/park_bloc.dart';
import 'package:pad_lampung/presentation/pages/auth/login_page.dart';
import 'package:provider/provider.dart';
import 'package:pad_lampung/di/application_module.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/auth/login_bloc.dart';
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
          create: (_) => di.locator<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ParkBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage()
      ),
    );
  }
}