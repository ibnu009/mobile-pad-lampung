import 'package:flutter/material.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';

import '../../../core/theme/app_primary_theme.dart';

class GenericPageController extends StatefulWidget {
  final int currentPage, totalData, itemPerPage;
  const GenericPageController({Key? key, required this.currentPage, required this.totalData, required this.itemPerPage}) : super(key: key);

  @override
  State<GenericPageController> createState() => _GenericPageControllerState();
}

class _GenericPageControllerState extends State<GenericPageController> {

  int totalPage = 1;

  @override
  void initState() {
    super.initState();
    totalPage = (widget.totalData.toNearestItemPerPage(widget.itemPerPage) / widget.itemPerPage).round();

    print('total page is $totalPage');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: InkWell(
                  onTap: (){
                    setState(() {
                      totalPage = (widget.totalData.toNearestItemPerPage(widget.itemPerPage) / widget.itemPerPage).round();
                    });

                    print('total page is $totalPage');
                  },
                  child: buildPageController("‹")),
            ),
            Flexible(
              flex: 1,
              child: buildPageController("«"),
            ),
            Flexible(
              flex: 1,
              child: buildPageController("1"),
            ),
            Flexible(
              flex: 1,
              child: buildPageController("2"),
            ),
            Flexible(
              flex: 1,
              child: buildPageController("3"),
            ),
            Flexible(
              flex: 1,
              child: buildPageController("›"),
            ),
            Flexible(
              flex: 1,
              child: buildPageController("»"),
            ),
          ],
        ));
  }

  Widget buildPageController(String? page) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.neutralColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        page ?? "1",
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
