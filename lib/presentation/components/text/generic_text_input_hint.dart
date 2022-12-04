import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';


class GenericTextInputHint extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const GenericTextInputHint({Key? key, required this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
      child: Text(
        text,
        style: style ?? AppTheme.subTitle
      ),
    );
  }
}
