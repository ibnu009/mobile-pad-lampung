import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class OtpTextInput extends StatelessWidget {
  final TextEditingController controller;

  const OtpTextInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        obscureText: false,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (v) {
          if (v.isEmpty) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),

        style: AppTheme.bodyText,
      ),
    );
  }
}
