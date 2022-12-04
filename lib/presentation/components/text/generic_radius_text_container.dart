import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class GenericRadiusTextContainer extends StatelessWidget {
  final String text;
  final double? radius, height, width, fontSize;
  final FontWeight? fontWeight;

  const GenericRadiusTextContainer(
      {Key? key, required this.text, this.radius, this.height, this.width, this.fontSize, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      alignment: Alignment.centerLeft,
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(radius ?? 8),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTheme.bodyText.copyWith(
            color: Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.normal
          ),
        ),
      ),
    );
  }
}
