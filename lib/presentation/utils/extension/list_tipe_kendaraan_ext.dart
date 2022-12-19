import 'package:flutter/material.dart';
import 'package:pad_lampung/core/data/model/response/jenis_kendaraan_response.dart';
import 'package:pad_lampung/core/data/model/response/ticket_list_response.dart';

extension TicketExtention on List<VehicleType> {
  List<String> toDropdownData() {
    List<String> data = [];
    for (int i = 0; i < length; i++){
      data.add(this[i].namaJenisKendaraan);
    }
    return data;
  }

  int extractIdJenisKendaraan(String jenisType) {
    int jenis = 0;
    print('masuk dengan jenis $jenisType');
    for (int i = 0; i < length; i++){
      print('bandingkan ${this[i].namaJenisKendaraan} dengan jenis $jenisType');
      if (this[i].namaJenisKendaraan == jenisType) {
        jenis = this[i].id;
        break;
      }
    }
    return jenis;
  }
}
