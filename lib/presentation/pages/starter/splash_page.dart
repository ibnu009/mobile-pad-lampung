import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/holder/last_transaction_holder.dart';
import 'package:pad_lampung/presentation/bloc/starter/starter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/bloc/starter/starter_event.dart';
import 'package:pad_lampung/presentation/bloc/starter/starter_state.dart';
import 'package:pad_lampung/presentation/pages/auth/login_page.dart';
import 'package:pad_lampung/presentation/pages/home/parking/home_page.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/xendit/transaction_parkir_payment_confirmation_xendit_page.dart';
import 'package:pad_lampung/presentation/pages/transaction/ticket/xendit/transaction_ticket_payment_confirmation_xendit_page.dart';

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
        print('state is $state');
        if (state is NavigateToHomeTicket) {
          if (state.lastXenditTransactionUrl != null) {
            try {
              LastTransactionHolder holder = LastTransactionHolder.fromJson(
                  state.lastXenditTransactionUrl ?? '');

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (c) =>
                          TransactionTicketPaymentConfirmationXenditPage(
                              idTarif: holder.idTarif ?? 0,
                              quantity: holder.quantity,
                              price: holder.price,
                              paymentUrl: holder.urlPayment,
                              paymentType: 'Pembayaran Online',
                              paymentMethod: holder.paymentMethod,
                              idTransaction: holder.idTransaction,
                              totalPrice: holder.totalPrice,
                              servicePrice: holder.servicePrice)));
            } catch(e) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) => const HomePageTicket()));
            }
            return;
          }

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => const HomePageTicket()));
          return;
        }

        if (state is NavigateToHomeParking) {
          if (state.lastXenditTransactionUrl != null) {
            try {
              LastTransactionHolder holder = LastTransactionHolder.fromJson(
                  state.lastXenditTransactionUrl ?? '');

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (c) =>
                          TransactionParkirPaymentConfirmationXenditPage(
                            price: holder.price,
                            paymentType: 'Pembayaran Online',
                            paymentUrl: holder.urlPayment,
                            paymentMethod: holder.paymentMethod,
                            servicePrice: holder.servicePrice,
                            noTransaksi: holder.noTransaksi,
                            idTransaksi: holder.idTransaction ?? 0,
                          )));
            } catch (e){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => const HomePage()));
            }
            return;
          }

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => const HomePage()));
          return;
        }

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => const LoginPage()));
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
