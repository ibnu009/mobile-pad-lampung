import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class IconPrimaryButton extends StatelessWidget {
  final BuildContext context;
  final bool isEnabled;
  final Function() onPressed;
  final Color? color;
  final IconData icon;
  final Color? iconFillColor;
  final double? width, height, borderRadius, iconSize, paddingHorizontal;

  const IconPrimaryButton(
      {Key? key,
      required this.context,
      required this.isEnabled,
      required this.onPressed,
      this.color, this.width,
      this.height,
      this.borderRadius,
      this.iconFillColor,
      this.iconSize,
        required this.icon, this.paddingHorizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 44,
        width: width ?? 44,
        decoration: BoxDecoration(
            color: color ?? AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Icon(
            icon,
            color: iconFillColor ?? Colors.white,
            size: iconSize ?? 22,
          ),
        ),
      ),
    );
  }
}
