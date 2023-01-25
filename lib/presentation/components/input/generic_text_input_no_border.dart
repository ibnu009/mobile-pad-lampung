import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

class GenericTextInputNoBorder extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final int? maxLines, maxLength;
  final String? hintText;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final TextAlign? textAlign;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isOptional;
  final double? radius, verticalMargin, horizontalMargin;
  final Color? fillColor;

  const GenericTextInputNoBorder(
      {Key? key,
      required this.controller,
      this.maxLines,
      this.hintText,
      required this.inputType,
      this.onSubmitted,
      this.maxLength,
      this.prefixIcon, this.isOptional, this.suffixIcon, this.radius, this.verticalMargin, this.horizontalMargin, this.fillColor, this.onChanged, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 16, horizontal: horizontalMargin ?? 16),
      padding: EdgeInsets.symmetric(vertical: verticalMargin ?? 8),
      child: TextFormField(
        onChanged: onChanged,
        showCursor: true,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        maxLength: maxLength,
        onFieldSubmitted: onSubmitted,
        cursorColor: Colors.black45,
        textAlign: textAlign ?? TextAlign.start,
        validator: (value) {
          if (isOptional ?? false){
            return null;
          }

          if (value == null || value.isEmpty){
            if (inputType == TextInputType.emailAddress){
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
          fillColor: fillColor ?? Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
