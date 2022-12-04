import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class TextButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double? width, height, fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  const TextButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.width,
      this.height,
      this.textColor,
      this.fontSize,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: Text(
          text,
          style: AppTheme.subTitle.copyWith(
            fontWeight: fontWeight ?? FontWeight.normal,
            color: textColor ?? AppTheme.primaryColor,
            fontSize: fontSize ?? 14,
          ),
        ),
      ),
    );
  }
}
