import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/bloc/starter/starter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/bloc/starter/starter_event.dart';
import 'package:pad_lampung/presentation/bloc/starter/starter_state.dart';
import 'package:pad_lampung/presentation/pages/auth/login_page.dart';
import 'package:pad_lampung/presentation/pages/home/parking/home_page.dart';

import '../home/ticket/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<StarterBloc>().add(StartSplashScreen());
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<StarterBloc>(),
      listener: (ctx, state) {
        if (state is NavigateToHomeTicket) {
          Navigator.push(context, CupertinoPageRoute(builder: (c) => const HomePageTicket()));
        }

        if (state is NavigateToHomeParking) {
          Navigator.push(context, CupertinoPageRoute(builder: (c) => const HomePage()));
        }

        if (state is NavigateToLogin) {
          Navigator.push(context, CupertinoPageRoute(builder: (c) => const LoginPage()));
        }
      },
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: blocListener(
        child: Column(
          children: [
            const Spacer(),
            const SizedBox(
              width: double.infinity,
            ),
            Image.asset('assets/images/logo_pesat.png'),
            const Spacer(),
            const Text(
              'Version 0.0.1',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
