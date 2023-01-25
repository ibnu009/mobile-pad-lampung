import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:pad_lampung/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/dialog/dialog_component.dart';
import 'package:pad_lampung/presentation/components/input/otp_text_input.dart';
import 'package:pad_lampung/presentation/pages/auth/change_password_page.dart';

import '../../bloc/forgot_password/forgot_password_state.dart';

class OtpActivationPage extends StatefulWidget {
  final String email;

  const OtpActivationPage({Key? key, required this.email}) : super(key: key);

  @override
  OtpActivationPageState createState() => OtpActivationPageState();
}

class OtpActivationPageState extends State<OtpActivationPage> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  int otpResendCounter = 60;
  late Timer _timer;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    startCountDown();
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<ForgotPasswordBloc>(),
      listener: (ctx, state) {
        if (state is LoadingForgotPassword) {
          showLoadingDialog(context: context);
          return;
        }

        if (state is SuccessOtp) {
          Navigator.pop(context);
          context
              .read<ForgotPasswordBloc>()
              .add(HandleOtpSuccess(email: widget.email));
          return;
        }

        if (state is SuccessActivateOtp) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => ChangePasswordPage(
                        tempToken: state.temporaryToken,
                        userType: state.userType,
                      )));
          return;
        }

        if (state is FailedForgotPassword) {
          Navigator.pop(context);
          showFailedDialog(
              context: context,
              title: "Gagal!",
              message: state.message,
              onTap: () {
                Navigator.pop(context);
              });
          return;
        }
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: blocListener(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Kode Konfirmasi',
                          textAlign: TextAlign.center,
                          style: AppTheme.subTitle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Masukkan Kode Konfirmasi yang kami kirimkan ke email ${widget.email}',
                          textAlign: TextAlign.center,
                          style: AppTheme.bodyText,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 4, 0),
                                  child:
                                      OtpTextInput(controller: textController1),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 0),
                                  child:
                                      OtpTextInput(controller: textController2),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 0),
                                  child:
                                      OtpTextInput(controller: textController3),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 0),
                                  child:
                                      OtpTextInput(controller: textController4),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: PrimaryButton(
                        context: context,
                        isEnabled: true,
                        width: MediaQuery.of(context).size.width * 0.65,
                        text: "Konfirmasi",
                        onPressed: () {
                          if (!isActivationNull()) {
                            String activationCode =
                                "${textController1.text}${textController2.text}${textController3.text}${textController4.text}";
                            context.read<ForgotPasswordBloc>().add(
                                SendOtpConfirmation(
                                    email: widget.email, otp: activationCode));
                          }
                        },
                      )),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                    child: Text(
                      otpResendCounter == 0
                          ? 'Belum mendapatkan kode konfirmasi?'
                          : 'Kirim ulang Kode Konfirmasi setelah:',
                      textAlign: TextAlign.center,
                      style: AppTheme.bodyText,
                    ),
                  ),
                  Visibility(
                    visible: otpResendCounter != 0,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          '00:$otpResendCounter',
                          textAlign: TextAlign.center,
                          style: AppTheme.bodyText,
                        )),
                  ),
                  Visibility(
                    visible: otpResendCounter == 0,
                    child: TextButton(
                      child: Text(
                        'Kirim Ulang',
                      ),
                      onPressed: () {
                        startCountDown();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isActivationNull() {
    var a = textController1.text;
    var b = textController2.text;
    var c = textController3.text;
    var d = textController4.text;

    if (a.isNotEmpty && b.isNotEmpty && c.isNotEmpty && d.isNotEmpty) {
      return false;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Masukkan kode aktivasi", style: AppTheme.bodyText),
        backgroundColor: Colors.red,
      ));
    });
    return true;
  }

  void startCountDown() {
    var sec = const Duration(seconds: 1);
    otpResendCounter = 60;
    _timer = Timer.periodic(sec, (timer) {
      if (otpResendCounter == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        if (mounted) {
          setState(() {
            otpResendCounter -= 1;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
