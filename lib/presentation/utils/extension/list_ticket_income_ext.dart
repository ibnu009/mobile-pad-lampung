import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/response/ticket_income_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/utils/extension/int_ext.dart';
import 'package:pad_lampung/presentation/utils/extension/string_ext.dart';

import '../../components/dialog/dialog_show_qr.dart';

extension TicketIncomeExtention on List<IncomeTicket> {
  List<TableRow> toDataRow(int offset) {
    List<TableRow> listTableRow = [];
    List<TableRow> listTableRowData = [];

    listTableRow.add(
      TableRow(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black12),
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
          children: [
            rowTextHeading('NO'),
            rowTextHeading('ID PESANAN'),
            rowTextHeading('TANGGAL'),
            rowTextHeading('TIKET'),
            rowTextHeading('JUMLAH'),
          ]),
    );

    for (int i = 0; i < length; i++) {
      print('kepanggil dengan urutan ${(i + 1) + offset}');
      listTableRowData.add(buildDataRow(
          '${(i + 1) + offset}',
          this[i].noTransaksi,
          this[i].tanggal.formatToOtherDate(),
          '${this[i].jumlah}',
          this[i].subTotal.toRupiah()));
    }

    listTableRow.addAll(listTableRowData);
    return listTableRow;
  }
}

Widget rowTextHeading(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        textAlign: TextAlign.center

    ),
  );
}

TableRow buildDataRow(
    String value1, String value2, String value3, String value4, String value5) {
  print('data is $value1, $value2, $value3, $value4, $value5, ');
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value1, style: AppTheme.text1, textAlign: TextAlign.center),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value2, style: AppTheme.text1, textAlign: TextAlign.center),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value3 == null ? '-' : value3,
            style: AppTheme.text1, textAlign: TextAlign.center),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value4, style: AppTheme.text1, textAlign: TextAlign.center),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value5, style: AppTheme.text1, textAlign: TextAlign.center),
      ),
    ],
  );
}
