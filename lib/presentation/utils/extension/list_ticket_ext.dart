import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';

import '../../components/dialog/dialog_show_qr.dart';

extension TicketExtention on List<Ticket> {
  List<TableRow> toDataRowPegawai(BuildContext context) {
    List<TableRow> listTableRow = [];
    List<TableRow> listTableRowData = [];

    listTableRow.add(TableRow(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        children: [
          rowTextHeading('JENIS'),
          rowTextHeading('ID PESANAN'),
          rowTextHeading('MASUK'),
        ]),);

    for (int i = 0; i < length; i++){
      print('kepanggil dengan urutan ${(i + 1)}');
      listTableRowData.add(buildDataRow('TP', this[i].noTransaksi, this[i].scanTime, context));
    }

    listTableRow.addAll(listTableRowData.reversed);
    return listTableRow;
  }

  List<TableRow> toDataRowOnline() {
    List<TableRow> listTableRow = [];
    List<TableRow> listTableRowData = [];

    listTableRow.add(TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
        ),
        children: [
          rowTextHeading('ID PESANAN'),
          rowTextHeading('NO HP'),
          rowTextHeading('MASUK'),
          rowTextHeading('STATUS'),
        ]),);

    for (int i = 0; i < length; i++){
      print('kepanggil dengan urutan ${(i + 1)}');
      listTableRowData.add(buildDataRowOnline(this[i].noTransaksi, this[i].noTelp , this[i].scanTime));
    }

    listTableRow.addAll(listTableRowData.reversed);
    return listTableRow;
  }
}

Widget rowTextHeading(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
    ),
  );
}

TableRow buildDataRow(String value1, String value2, String value3, BuildContext context) {
  return TableRow(
    children: [
      InkWell(
        onTap: () => showQrCode(context: context, transactionCode: value2, onSendEmail: (){}),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value1, style: AppTheme.text1,),
        ),
      ),
      InkWell(
        onTap: () => showQrCode(context: context, transactionCode: value2, onSendEmail: (){}),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value2, style: AppTheme.text1),
        ),
      ),
      InkWell(
        onTap: () => showQrCode(context: context, transactionCode: value2, onSendEmail: (){}),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value3, style: AppTheme.text1
          ),
        ),
      )
    ],
  );
}

TableRow buildDataRowOnline(String value1, String value2, String value3) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value1),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value2),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value3,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          '-',
        ),
      )
    ],
  );
}
