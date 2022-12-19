import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';

extension TicketExtention on List<Ticket> {
  List<TableRow> toDataRowPegawai() {
    List<TableRow> listTableRow = [];
    listTableRow.add(TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
        ),
        children: [
          rowTextHeading('JENIS'),
          rowTextHeading('ID PESANAN'),
          rowTextHeading('MASUK'),
        ]),);

    for (int i = 0; i < length; i++){
      print('kepanggil dengan urutan ${(i + 1)}');
      listTableRow.add(buildDataRow('TP', this[i].noTransaksi, this[i].scanTime));
    }
    return listTableRow;
  }

  List<TableRow> toDataRowOnline() {
    List<TableRow> listTableRow = [];

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
      listTableRow.add(buildDataRowOnline(this[i].noTransaksi, this[i].noTelp , this[i].scanTime));
    }
    return listTableRow;
  }
}

Widget rowTextHeading(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}

TableRow buildDataRow(String value1, String value2, String value3) {
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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '-',
        ),
      )
    ],
  );
}
