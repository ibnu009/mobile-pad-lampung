import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../components/appbar/custom_generic_appbar.dart';
import 'bluetooth_setting_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: Column(
        children:  [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: GenericAppBarNoThumbnail(url: '', title: 'Pengaturan'),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
                onTap: (){
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (c) =>
                          const BluetoothSettingPage()));
                },
                leading: const Icon(Icons.bluetooth),
                title: const Text('Pengaturan Perangkat Bluetooth'),
                trailing: const Icon(Icons.chevron_right)
            ),
          )

        ],
      ),
    );
  }
}
