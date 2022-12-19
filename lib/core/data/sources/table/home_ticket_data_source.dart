import 'package:flutter/material.dart';

import '../../model/response/ticket_list_response.dart';

class HomeTicketDataSource extends DataTableSource {
  final List<Ticket> tickets;

  HomeTicketDataSource(this.tickets);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text('TP')),
      DataCell(Text(tickets[index].noTransaksi)),
      DataCell(Text(tickets[index].scanTime)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tickets.length;

  @override
  int get selectedRowCount => 0;
}
