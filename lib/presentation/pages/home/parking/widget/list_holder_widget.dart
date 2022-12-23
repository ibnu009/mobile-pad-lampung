import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/dropdown/dropdown_value.dart';
import 'package:pad_lampung/presentation/components/dropdown/generic_dropdown.dart';
import 'package:pad_lampung/presentation/utils/extension/list_parking_ext.dart';

import '../../../../../core/data/model/response/parking_response.dart';
import '../../../../components/modal/bottom_modal.dart';

const String prevPage = "prevPage";
const String firstPage = "firstPage";
const String nextPage = "nextPage";
const String lastPage = "lastPage";

class ListHolderWidget extends StatefulWidget {
  final List<ParkingData> data;

  const ListHolderWidget({Key? key, required this.data}) : super(key: key);

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
                            builder: (builder) => const HomeBottomModal());
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
              widget.data.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: Text('Data kosong')),
                    )
                  : Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: widget.data.toDataRowTable(context),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
