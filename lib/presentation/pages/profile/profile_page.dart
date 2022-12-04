import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/pages/izin/izin_page.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/post_transaction_page.dart';

import '../../components/calendar/calendar_widget.dart';
import '../../components/dropdown/dropdown_value.dart';
import '../../components/dropdown/generic_dropdown.dart';
import '../../components/image/avatar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedItem = initialVehicleDataShown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: GenericAppBarNoThumbnail(url: '', title: 'Profile'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Avatar(url: '', size: 35,),
                    const SizedBox(width: 12,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jajang ST', style: AppTheme.subTitle),
                        const Text('Masuk'),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB( 16, 16, 16, 0),
                      child: Text('Jadwal Bertugas', style: AppTheme.subTitle),
                    ),
                    const CalendarWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Avatar(url: '', size: 5, color: AppTheme.primaryColorLighter,),
                        ),
                        Text('Masuk'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Avatar(url: '', size: 5, color: AppTheme.redColor,),
                        ),
                        Text('Libur'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Avatar(url: '', size: 5, color: AppTheme.yellowColor,),
                        ),
                        Text('Izin'),
                        SizedBox(width: 16,)
                      ],
                    ),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jadwal Bertugas', style: AppTheme.subTitle),
                          const SizedBox(height: 12,),
                          buildRowDetailData('Masuk', '20 Hari'),
                          buildRowDetailData('Keluar ', '20 Hari'),
                          buildRowDetailData('T.K', '20 Hari'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PrimaryButton(
                          context: context,
                          isEnabled: true,
                          width: double.infinity,
                          color: Colors.red,
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (c) => const IzinPage()));
                          },
                          horizontalPadding: 0,
                          height: 45,
                          text: 'Buat Izin'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32,),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRowDetailData(String tittle, String data) {
    return Row(
      children: [
        Text(
          tittle,
          style: AppTheme.subTitle.copyWith(
            fontSize: 14
          ),
        ),
        Spacer(),
        Text(data),
        SizedBox(width: 8,)
      ],
    );
  }

}
