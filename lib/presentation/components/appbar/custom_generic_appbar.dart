import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/image/avatar.dart';
import 'package:pad_lampung/presentation/pages/auth/login_page.dart';
import 'package:pad_lampung/presentation/pages/laporan/laporan_page.dart';
import 'package:pad_lampung/presentation/pages/profile/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/presentation/pages/setting/setting_page.dart';

import '../../bloc/auth/login_bloc.dart';
import '../../bloc/auth/login_event.dart';

enum Options { profile, laporan, pengaturan, keluar }


AppBar customGenericAppbar(
    BuildContext context, String title, Function() onTap) {
  return AppBar(
    leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        )),
    backgroundColor: AppTheme.primaryColor,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

class HomeAppBar extends StatefulWidget {
  final String url;

  const HomeAppBar({Key? key, required this.url}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  var _popupMenuItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 72,
              height: 32,
              child: Image.asset("assets/images/logo_pesat.png")),
          const Spacer(),
           Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: SvgPicture.asset('assets/icons/bell_icon.svg'),
          ),

          PopupMenuButton(
            onSelected: (value) {
              _onMenuItemSelected(value as int);
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Avatar(url: widget.url)),
            itemBuilder: (ctx) => [
              _buildPopupMenuItem('Profile', Icons.person_outline_outlined,
                  Options.profile.index),
              _buildPopupMenuItem(
                  'Laporan', Icons.list_alt_outlined, Options.laporan.index),
              _buildPopupMenuItem(
                  'Pengaturan', CupertinoIcons.gear, Options.pengaturan.index),
              _buildPopupMenuItem(
                  'Keluar', Icons.exit_to_app, Options.keluar.index),
            ],
          ),

          // InkWell(
          //   onTap: (){
          //     Navigator.push(context, CupertinoPageRoute(builder: (c) => ProfilePage()));
          //   },
          //   child: ,
          // )
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (_popupMenuItemIndex == Options.profile.index) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (c) => const ProfilePage()));
      return;
    }

    if (_popupMenuItemIndex == Options.pengaturan.index) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (c) => const SettingPage()));
      return;
    }

    if (_popupMenuItemIndex == Options.laporan.index) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (c) => const LaporanPage()));
      return;
    }

    if (_popupMenuItemIndex == Options.keluar.index) {
      showYesNoDialog(
          context: context,
          title: 'Logout',
          message: 'Apakah anda yakin untuk logout?',
          onYesTap: () {
            context.read<LoginBloc>().add(LogoutUser());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false);
          },
          onNoTap: () {
            Navigator.pop(context);
          });
      return;
    }
  }
}

class GenericAppBar extends StatefulWidget {
  final String url, title;

  const GenericAppBar({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<GenericAppBar> createState() => _GenericAppBarState();
}

class _GenericAppBarState extends State<GenericAppBar> {
  var _popupMenuItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: AppTheme.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              widget.title,
              style: AppTheme.subTitle.copyWith(color: AppTheme.primaryColor),
            ),
          ),
          const Spacer(),
           Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: SvgPicture.asset('assets/icons/bell_icon.svg')
          ),

          PopupMenuButton(
            onSelected: (value) {
              _onMenuItemSelected(value as int);
            },
            child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Avatar(url: widget.url)),
            itemBuilder: (ctx) => [
              _buildPopupMenuItem('Profile', Icons.person_outline_outlined,
                  Options.profile.index),
              _buildPopupMenuItem(
                  'Laporan', Icons.list_alt_outlined, Options.laporan.index),
              _buildPopupMenuItem(
                  'Pengaturan', CupertinoIcons.gear, Options.pengaturan.index),
              _buildPopupMenuItem(
                  'Keluar', Icons.exit_to_app, Options.keluar.index),
            ],
          ),

          // InkWell(
          //   onTap: (){
          //     Navigator.push(context, CupertinoPageRoute(builder: (c) => ProfilePage()));
          //   },
          //   child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //       child: Avatar(url: widget.url)),
          // )
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (_popupMenuItemIndex == Options.profile.index) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (c) => const ProfilePage()));
      return;
    }

    if (_popupMenuItemIndex == Options.pengaturan.index) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (c) => const SettingPage()));
      return;
    }

    if (_popupMenuItemIndex == Options.laporan.index) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (c) => const LaporanPage()));
      return;
    }

    if (_popupMenuItemIndex == Options.keluar.index) {
      showYesNoDialog(
          context: context,
          title: 'Logout',
          message: 'Apakah anda yakin untuk logout?',
          onYesTap: () {
            context.read<LoginBloc>().add(LogoutUser());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false);
          },
          onNoTap: () {
            Navigator.pop(context);
          });
      return;
    }
  }
}

PopupMenuItem _buildPopupMenuItem(
    String title, IconData iconData, int position) {
  return PopupMenuItem(
    value: position,
    child: Row(
      children: [
        Icon(
          iconData,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: const TextStyle(color: AppTheme.primaryColor),
        ),
      ],
    ),
  );
}

class GenericAppBarNoThumbnail extends StatelessWidget {
  final String url, title;

  const GenericAppBarNoThumbnail(
      {Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: AppTheme.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              title,
              style: AppTheme.subTitle.copyWith(color: AppTheme.primaryColor),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: Icon(
              Icons.notifications_none_outlined,
              color: AppTheme.primaryColor,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
