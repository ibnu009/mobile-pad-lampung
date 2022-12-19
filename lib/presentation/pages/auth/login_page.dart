import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/button/primary_button.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input_with_obscure.dart';
import 'package:pad_lampung/presentation/pages/auth/forgot_password_page.dart';
import 'package:pad_lampung/presentation/pages/home/parking/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/login_bloc.dart';
import '../../bloc/auth/login_event.dart';
import '../../bloc/auth/login_state.dart';
import '../../components/dialog/dialog_component.dart';
import '../home/ticket/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController? _emailInputController;
  TextEditingController? _passwordInputController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailInputController = TextEditingController();
    _passwordInputController = TextEditingController();
  }

  Widget blocListener({required Widget child}) {
    return BlocListener(
      bloc: context.read<LoginBloc>(),
      listener: (ctx, state) {
        if (state is LoadingLogin) {
          showLoadingDialog(context: context);
          return;
        }

        if (state is SuccessLogin) {
          Navigator.pop(context);
          showSuccessDialog(
              context: context,
              title: "Berhasil!",
              message: "",
              onTap: () {
                Navigator.pop(context);
                if (state.userType == 2){
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (c) => const HomePage()));
                } else {
                  Navigator.push(context, CupertinoPageRoute(builder: (c) => const HomePageTicket()));
                }
              });
          return;
        }

        if (state is FailedLogin) {
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
      body: blocListener(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(),
                  Image.asset('assets/images/logo_pesat.png'),
                  const Spacer(),
                  GenericTextInput(
                    controller: _emailInputController!,
                    inputType: TextInputType.emailAddress,
                    hintText: 'Email',
                    maxLines: 1,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 18,
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: PrimaryButton(
                        context: context,
                        isEnabled: true,
                        width: double.infinity,
                        onPressed: () {
                          _handleSubmitLogin(context);
                        },
                        text: 'Masuk',
                        color: AppTheme.primaryColor),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (c) => const ForgotPasswordPage()));
                    },
                    child: const Text("Lupa Password"),
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
    );
  }

  Future<void> _handleSubmitLogin(BuildContext ctx) async {
    // context
    //     .read<LoginBloc>()
    //     .add(LoginUser(email: 'lorem@gmail.com', password: 'lorem123'));
    //
    // context
    //     .read<LoginBloc>()
    //         .add(LoginUser(email: 'mobile@gmail.com', password: 'mobile123'));

    if (_formKey.currentState!.validate()) {
      String? email = _emailInputController?.value.text ?? "";
      String password = _passwordInputController?.value.text ?? "";
      // String hashedPassword = password.convertToSha256();

      if (email == 'lorem1@gmail.com') {
        Navigator.push(context,
            CupertinoPageRoute(builder: (c) => const HomePageTicket()));
      } else {
        context
            .read<LoginBloc>()
            .add(LoginUser(email: email, password: password));
      }
    }
  }
}
