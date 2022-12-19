import 'package:flutter/material.dart';

class TableRowCustom extends StatelessWidget {
  final String? val1, val2, val3, val4, val5;
  final int totalRow;

  const TableRowCustom(
      {Key? key, this.val1, this.val2, this.val3, this.val4, this.val5, required this.totalRow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double maxWidthDivider = totalRow / 10;
        print('maxWidthDiv $maxWidthDivider');
        double widthCell = constraint.maxWidth * maxWidthDivider;
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: val1 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val1 ?? '-', textAlign: TextAlign.center)),
            ),
            Visibility(
              visible: val2 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val2 ?? '-', textAlign: TextAlign.center)),
            ),
            Visibility(
              visible: val2 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val2 ?? '-', textAlign: TextAlign.center)),
            ),
            Visibility(
              visible: val1 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val1 ?? '-', textAlign: TextAlign.center)),
            ),
            Visibility(
              visible: val3 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val3 ?? '-', textAlign: TextAlign.center)),
            ),
            Visibility(
              visible: val4 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val4 ?? '-', textAlign: TextAlign.center)),
            ),
            Visibility(
              visible: val5 != null,
              maintainSize: false,
              child: SizedBox(
                  width: widthCell,
                  child: Text(val5 ?? '-', textAlign: TextAlign.center)),
            ),
          ],
        );
      },
    );
  }
}
