import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:pad_lampung/presentation/bloc/forgot_password/forgot_password_state.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_with_obscure.dart';

import '../../bloc/forgot_password/forgot_password_event.dart';
import '../../components/dialog/dialog_component.dart';
import 'login_page.dart';

class ChangePasswordPage extends StatefulWidget {
  final String tempToken;
  final int userType;

  const ChangePasswordPage(
      {Key? key, required this.tempToken, required this.userType})
      : super(key: key);

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController? _passwordConfirmationInputController;
  TextEditingController? _passwordInputController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordConfirmationInputController = TextEditingController();
    _passwordInputController = TextEditingController();
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<ForgotPasswordBloc>(),
      listener: (ctx, state) {
        if (state is LoadingForgotPassword) {
          showLoadingDialog(context: context);
          return;
        }

        if (state is SuccessForgotPassword) {
          Navigator.pop(context);
          showSuccessDialog(
              context: context,
              title: 'Berhasil',
              message:
                  'Password kamu sudah diganti dengan password baru, Silahkan login kembali',
              onTap: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (c) => const LoginPage()));
              });
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
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Password Baru'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: blocListener(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Kode Konfirmasi',
                        textAlign: TextAlign.center,
                        style: AppTheme.subTitle,
                      ),
                    ),
                    GenericTextInputWithObscure(
                      controller: _passwordInputController!,
                      inputType: TextInputType.text,
                      hintText: 'Password',
                      maxLines: 1,
                      prefixIcon: const Icon(
                        Icons.key,
                        size: 18,
                      ),
                    ),
                    GenericTextInputWithObscure(
                      controller: _passwordConfirmationInputController!,
                      inputType: TextInputType.text,
                      hintText: 'Konfirmasi Password',
                      maxLines: 1,
                      prefixIcon: const Icon(
                        Icons.key,
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                      child: PrimaryButton(
                          context: context,
                          isEnabled: true,
                          width: double.infinity,
                          onPressed: () {
                            _handleSubmitLogin(context);
                          },
                          text: 'Simpan',
                          color: AppTheme.primaryColor),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Spacer(),
                    const Text('Copyright \u00a9 Pesat 2022'),
                    const Spacer()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmitLogin(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      String password = _passwordInputController?.value.text ?? "";

      context.read<ForgotPasswordBloc>().add(SendChangePasswordRequest(
            newPassword: password,
            tempToken: widget.tempToken,
          ));
    }
  }
}
