import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showQrCode({
  required BuildContext context,
  required String transactionCode,
  Function()? onPrint,
  Function()? onSendEmail,
}) {

  print('ticket is $transactionCode');

  showDialog(
      context: context,
      builder: (ctx) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Material(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('Scan Tiket', style: AppTheme.subTitle,),
                    ),

                    QrImage(
                      data: transactionCode,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: PrimaryButton(
                              context: context,
                              height: 43,
                              isEnabled: true,
                              onPressed: onPrint ?? () {},
                              text: 'Print'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Visibility(
                            visible: onSendEmail != null,
                            child: PrimaryButton(
                                context: context,
                                height: 43,
                                isEnabled: true,
                                onPressed: onSendEmail ?? () {},
                                text: 'Send Email'),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
