import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hb_check_code/hb_check_code.dart';
import 'package:logger/logger.dart';
import 'package:pad_lampung/presentation/components/input/generic_text_input.dart';
import 'package:pad_lampung/presentation/utils/extension/context_ext.dart';

import '../../../core/theme/app_primary_theme.dart';
import '../../components/button/primary_button.dart';
import '../../utils/helper/string_randomizer.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var logger = Logger(printer: PrettyPrinter());

  late TextEditingController _emailInputController;
  late TextEditingController _codeInputController;

  String code = getRandomString(5);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String changedPassword;

  @override
  void initState() {
    super.initState();
    _emailInputController = TextEditingController();
    _codeInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                'Masukkan Alamat Email',
                style: AppTheme.title1.copyWith(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Gunakan alamat email yang terdaftar di aplikasi ini untuk mendapatkan kode konfirmasi',
                style: AppTheme.bodyText.copyWith(
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 26,
              ),
              GenericTextInput(
                controller: _emailInputController,
                inputType: TextInputType.emailAddress,
                hintText: 'Email',
                maxLines: 1,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 18,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        GenericTextInput(
                          controller: _codeInputController,
                          inputType: TextInputType.text,
                          hintText: 'xxxxx',
                          maxLines: 1,
                        ),
                        Text(
                          'Masukkan teks yang tertera pada gambar',
                          style: AppTheme.bodyText.copyWith(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: HBCheckCode(
                                code: code,
                              )),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  code = getRandomString(5);
                                });
                              },
                              child: const Icon(Icons.refresh)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                child: PrimaryButton(
                    context: context,
                    isEnabled: true,
                    width: double.infinity,
                    onPressed: () {
                      if (_codeInputController.text != code) {
                        context.showSnackBar('Captcha tidak sesuai');
                        return;
                      }
                    },
                    text: 'Kirim',
                    color: AppTheme.primaryColor),
              ),
              const Spacer(),
              const Text('Copyright \u00a9 Pesat 2022'),
              const SizedBox(height: 32,),
            ],
          ),
        ),
      ),
    );
  }
}
