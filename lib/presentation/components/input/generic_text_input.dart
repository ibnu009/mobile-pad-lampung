import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

class GenericTextInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final int? maxLines, maxLength;
  final String? hintText;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Iterable<String>? autoFill;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isOptional;

  const GenericTextInput(
      {Key? key,
      required this.controller,
      this.maxLines,
      this.hintText,
      required this.inputType,
      this.onSubmitted,
      this.maxLength,
      this.prefixIcon,
      this.isOptional,
      this.suffixIcon,
      this.onChanged,
      this.autoFill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: TextFormField(
        showCursor: true,
        controller: controller,
        keyboardType: inputType,
        onChanged: onChanged,
        maxLines: maxLines,
        maxLength: maxLength,
        onFieldSubmitted: onSubmitted,
        cursorColor: Colors.black45,
        autofillHints: autoFill,
        validator: (value) {
          if (isOptional ?? false) {
            return null;
          }

          if (value == null || value.isEmpty) {
            if (inputType == TextInputType.emailAddress) {
              return "Email wajib diisi";
            }
            return "Field ini wajib diisi";
          }

          if (inputType == TextInputType.emailAddress) {
            if (!value.isEmailValid()) {
              return "Masukkan e-Mail sesuai dengan format yang benar";
            }
            return null;
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
