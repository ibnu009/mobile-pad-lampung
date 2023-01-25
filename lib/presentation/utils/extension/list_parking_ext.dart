import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/response/parking_response.dart';
import 'package:pad_lampung/presentation/pages/transaction/parking/vehicle_checkout_page.dart';

import '../../components/image/image_network.dart';

extension TicketExtention on List<ParkingData> {
  List<TableRow> toDataRowTable(BuildContext context) {
    List<TableRow> listTableRow = [];
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
            rowTextHeading('IMAGE'),
            rowTextHeading('ID PARKIR'),
            rowTextHeading('JENIS'),
            rowTextHeading('MASUK'),
            rowTextHeading('KELUAR'),
          ]),
    );

    for (int i = 0; i < length; i++) {
      print('kepanggil dengan urutan ${(i + 1)}');
      listTableRow.add(buildDataRow(
          this[i].pathFotoKendaraan,
          this[i].noTransaksiParkir,
          this[i].idJenisKendaraan.toString(),
          this[i].waktuMasuk ?? '-',
          this[i].waktuKeluar ?? '-', this[i].noTransaksiParkir, context));
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

TableRow buildDataRow(String value1, String value2, String value3,
    String value4, String value5, String uniqueKey, BuildContext context) {
  return TableRow(
    children: [
      InkWell(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (c) => VehicleCheckOutPage(parkingId: uniqueKey))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GenericImageNetwork(imageUrl: value1,),
        ),
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
          value4,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value5,
        ),
      ),
    ],
  );
}
