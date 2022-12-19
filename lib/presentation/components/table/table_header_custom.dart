import 'package:flutter/material.dart';

class TableHeaderCustom extends StatelessWidget {
  final String? title1, title2, title3, title4, title5;
  final int totalRow;

  const TableHeaderCustom({
    Key? key,
     this.title1,
     this.title2,
     this.title3,
     this.title4,
     this.title5, required this.totalRow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxWidthDivider = totalRow / 10;
    print('maxWidthDiv $maxWidthDivider');
    return LayoutBuilder(builder: (context, constraint) {
      double widthCell = constraint.maxWidth * maxWidthDivider;
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Visibility(
            visible: title1 != null,
            maintainSize: false,
            child: SizedBox(
              width: widthCell,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title1 ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          Visibility(
            visible: title2 != null,
            maintainSize: false,
            child: SizedBox(
              width: widthCell,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title2 ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          Visibility(
            visible: title3 != null,
            maintainSize: false,
            child: SizedBox(
              width: widthCell,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title3 ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          Visibility(
            visible: title4 != null,
            maintainSize: false,
            child: SizedBox(
              width: widthCell,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title4 ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          Visibility(
            visible: title5 != null,
            maintainSize: false,
            child: SizedBox(
              width: widthCell,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title5 ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
