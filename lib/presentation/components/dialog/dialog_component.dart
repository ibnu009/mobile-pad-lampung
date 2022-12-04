import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

void showSuccessDialog(
    {required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onTap}) {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: title,
      text: message,
      confirmBtnText: "OK",
      loopAnimation: false,
      barrierDismissible: false,
      confirmBtnColor: AppTheme.primaryColor,
      onConfirmBtnTap: onTap);
}

void showLoadingDialog({required BuildContext context, String? loadingText}) {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      lottieAsset: 'assets/lottie/loading_pembayaran.json',
      text: loadingText ?? 'Loading..',
      barrierDismissible: false);
}

void showFailedDialog(
    {required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onTap}) {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: title,
      text: message,
      loopAnimation: false,
      barrierDismissible: false,
      confirmBtnColor: AppTheme.primaryColor,
      onConfirmBtnTap: onTap);
}

void showWarningDialog(
    {required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onTap}) {
  CoolAlert.show(
      context: context,
      confirmBtnColor: AppTheme.primaryColor,
      type: CoolAlertType.warning,
      title: title,
      text: message,
      loopAnimation: false,
      barrierDismissible: false,
      onConfirmBtnTap: onTap);
}

void showOkDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void showYesNoDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required Function() onYesTap,
    required Function() onNoTap}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: onNoTap,
          child: const Text('Tidak'),
        ),
        TextButton(
          onPressed: onYesTap,
          child: const Text('Iya'),
        ),

      ],
    ),
  );
}
