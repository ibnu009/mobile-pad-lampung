import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class GenericTextInputWithObscure extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final int? maxLines, maxLength;
  final String? hintText, previousPassword;
  final Function(String)? onSubmitted;
  final Iterable<String>? autoFill;
  final Icon? prefixIcon;

  const GenericTextInputWithObscure(
      {Key? key,
      required this.controller,
      this.maxLines,
      this.hintText,
      required this.inputType,
      this.onSubmitted,
      this.maxLength,
      this.prefixIcon,
      this.previousPassword,
      this.autoFill})
      : super(key: key);

  @override
  State<GenericTextInputWithObscure> createState() =>
      _GenericTextInputWithObscureState();
}

class _GenericTextInputWithObscureState
    extends State<GenericTextInputWithObscure> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
      child: TextFormField(
        showCursor: true,
        obscureText: !isPasswordVisible,
        controller: widget.controller,
        autofillHints: widget.autoFill,
        keyboardType: widget.inputType,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        onFieldSubmitted: widget.onSubmitted,
        cursorColor: Colors.black45,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password wajib diisi";
          }

          if (value.length < 6) {
            return "Password harus 6 karakter atau lebih";
          }

          if (widget.previousPassword != null) {
            if (widget.previousPassword != value) {
              return "Kata sandi tidak sama dengan Kata sandi sebelumnya";
            }
          }

          return null;
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          suffixIcon: InkWell(
            onTap: () => setState(
              () => isPasswordVisible = !isPasswordVisible,
            ),
            child: Icon(
              isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF757575),
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
