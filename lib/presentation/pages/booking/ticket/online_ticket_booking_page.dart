import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/pages/booking/ticket/widget/list_holder_widget.dart';

import '../../../../core/theme/app_primary_theme.dart';
import '../../../components/appbar/custom_generic_appbar.dart';

class OnlineTicketBookingPage extends StatefulWidget {
  const OnlineTicketBookingPage({Key? key}) : super(key: key);

  @override
  State<OnlineTicketBookingPage> createState() => _OnlineTicketBookingPageState();
}

class _OnlineTicketBookingPageState extends State<OnlineTicketBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: GenericAppBar(url: '', title: 'Pesanan Online'),
            ),
            SizedBox(height: 16,),
            ListBookingOnlineHolderWidget()
          ],
        ),
      ),
    );
  }
}
