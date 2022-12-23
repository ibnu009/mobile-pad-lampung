import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericDropdown extends StatelessWidget {
  final String selectedItem;
  final List<String> items;
  final Function(String?)? onChanged;
  final double? width, height;
  final Color? backgroundColor, borderColor;
  final String? hint;
  const GenericDropdown({Key? key, required this.selectedItem, required this.items, required this.onChanged, this.width, this.height, this.backgroundColor, this.borderColor, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? Colors.black38),
          color: backgroundColor
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedItem,
          icon: const Icon(CupertinoIcons.chevron_down, size: 15,),
          hint: Text(hint ?? ''),
          items: items
              .map((String e) =>
              DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged),
      ),
    );
  }
}
