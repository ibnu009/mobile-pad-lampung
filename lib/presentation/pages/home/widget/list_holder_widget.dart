import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';

import '../../../components/modal/bottom_modal.dart';

const String prevPage = "prevPage";
const String firstPage = "firstPage";
const String nextPage = "nextPage";
const String lastPage = "lastPage";

class ListHolderWidget extends StatefulWidget {
  const ListHolderWidget({Key? key}) : super(key: key);

  @override
  State<ListHolderWidget> createState() => _ListHolderWidgetState();
}

class _ListHolderWidgetState extends State<ListHolderWidget>
    with TickerProviderStateMixin {
  String selectedItem = initialDataShown;

  late AnimationController controller;

  void initController() {
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
    controller.reverseDuration = const Duration(milliseconds: 500);
  }

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text('Show'),
                    GenericDropdown(
                      selectedItem: selectedItem,
                      items: dataShownItem,
                      height: 45,
                      onChanged: (String? value) {
                        setState(() {
                          selectedItem = value ?? initialDataShown;
                        });
                      },
                    ),
                    const Spacer(),
                    const Text('Filter'),
                    InkWell(
                      onTap: () {
                        print("pressed");
                        showModalBottomSheet(
                            transitionAnimationController: controller,
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            builder: (builder) => HomeBottomModal());
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.filter_list_rounded,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black38),
                      ),
                      children: [
                        rowTextHeading('IMAGE'),
                        rowTextHeading('ID PARKIR'),
                        rowTextHeading('JENIS'),
                        rowTextHeading('MASUK'),
                        rowTextHeading('KELUAR'),
                      ]),
                  buildDataRow(),
                  buildDataRow(),
                  buildDataRow(),
                ],
              ),
            ],
          ),
        ),
        Container(
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
                  child: buildPageController("‹"),
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
            )),
      ],
    );
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

  TableRow buildDataRow() {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset('assets/images/default_profile.png'),
      ),
      const Text('7374279849', textAlign: TextAlign.center),
      const Text('SM', textAlign: TextAlign.center),
      const Text('10:00', textAlign: TextAlign.center),
      const Text('-', textAlign: TextAlign.center),
    ]);
  }

  Widget rowText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  Widget rowTextHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
