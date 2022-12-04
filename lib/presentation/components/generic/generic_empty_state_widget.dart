import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/empty_background.dart';

class GenericEmptyState extends StatelessWidget {
  final String? assets, text;
  final double? vPadding, hPadding;
  const GenericEmptyState(
      {Key? key, this.assets, required this.text, this.vPadding, this.hPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 242,
          height: 230,
          child: CustomPaint(
            painter: EmptyBackground(),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: hPadding ?? 0, vertical: vPadding ?? 0),
          child: Text(
            text ?? '',
            textAlign: TextAlign.center,
            style: AppTheme.bodyText.copyWith(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
