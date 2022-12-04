import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

AppBar genericAppbar(BuildContext context, String title){
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