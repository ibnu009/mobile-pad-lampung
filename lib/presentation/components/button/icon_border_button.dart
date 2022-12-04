import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class BorderIconButton extends StatelessWidget {
  final BuildContext context;
  final bool isEnabled;
  final Function() onPressed;
  final Function()? onNotActivePressed;
  final IconData icon;

  final String text;
  final Color? color, iconFillColor;
  final double? width, height, leftPadding, rightPadding, radius, horizontalMargin, iconSize;

  const BorderIconButton(
      {Key? key,
      required this.context,
      required this.isEnabled,
      required this.onPressed,
      required this.text,
      this.color,
      this.width,
      this.height,
      this.leftPadding,
      this.rightPadding, this.radius, this.horizontalMargin, this.onNotActivePressed, required this.icon, this.iconFillColor, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : onNotActivePressed ?? (){},
      child: Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 16),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadiusDirectional.circular(radius ?? 8),
            border: Border.all(color: isEnabled ? color ?? AppTheme.primaryColor : Colors.black38)),
        padding:
            EdgeInsets.fromLTRB(leftPadding ?? 32, 0, rightPadding ?? 32, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: isEnabled ? color ?? AppTheme.primaryColor : Colors.black38,
              size: iconSize ?? 22,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 15, color: isEnabled ? color ?? AppTheme.primaryColor : Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}
