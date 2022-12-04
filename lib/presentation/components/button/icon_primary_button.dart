import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class IconPrimaryButton extends StatelessWidget {
  final BuildContext context;
  final bool isEnabled;
  final Function() onPressed;
  final String text;
  final Color? color, textColor;
  final IconData icon;
  final Color? iconFillColor;
  final double? width, height, borderRadius, iconSize, paddingHorizontal;

  const IconPrimaryButton(
      {Key? key,
      required this.context,
      required this.isEnabled,
      required this.onPressed,
      this.color,
      required this.text,
      this.width,
      this.height,
      this.borderRadius,
      this.iconFillColor,
      this.iconSize,
      required this.icon,
      this.paddingHorizontal,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor:
          !isEnabled ? Colors.grey : color ?? AppTheme.primaryColor,
      minimumSize: Size(width ?? double.infinity, height ?? 50),
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
      ),
    );

    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: isEnabled ? onPressed : () {},
        child: Row(
          children: [
            Icon(
              icon,
              color: iconFillColor ?? Colors.white,
              size: iconSize ?? 22,
            ),
            const Spacer(),
            Visibility(
              visible: text.isNotEmpty,
              maintainSize: false,
              child: Text(text,
                  style: AppTheme.smallTitle.copyWith(
                      color: textColor ?? Colors.white)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
