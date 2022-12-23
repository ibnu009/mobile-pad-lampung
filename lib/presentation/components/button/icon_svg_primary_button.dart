import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

class IconSvgPrimaryButton extends StatelessWidget {
  final BuildContext context;
  final bool isEnabled;
  final Function() onPressed;
  final String text;
  final Color? color, textColor;
  final String iconAsset;
  final Color? iconFillColor;
  final double? width, height, borderRadius, iconSize, paddingHorizontal;

  const IconSvgPrimaryButton(
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
      required this.iconAsset,
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
            SvgPicture.asset(iconAsset),
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
