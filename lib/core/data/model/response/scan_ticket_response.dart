// To parse this JSON data, do
//
//     final responseScanTicket = responseScanTicketFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseScanTicket responseScanTicketFromJson(String str) => ResponseScanTicket.fromJson(json.decode(str));

String responseScanTicketToJson(ResponseScanTicket data) => json.encode(data.toJson());

class ResponseScanTicket {
  ResponseScanTicket({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  List<DataTicketMasuk> data;

  factory ResponseScanTicket.fromJson(Map<String, dynamic> json) => ResponseScanTicket(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<DataTicketMasuk>.from(json["data"].map((x) => DataTicketMasuk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataTicketMasuk {
  DataTicketMasuk({
    required this.id,
    required this.noTiket,
    required this.scanStatus,
    required this.idTransaksiBookingTiket,
  });

  int id;
  String noTiket;
  int scanStatus;
  int idTransaksiBookingTiket;

  factory DataTicketMasuk.fromJson(Map<String, dynamic> json) => DataTicketMasuk(
    id: json["id"],
    noTiket: json["no_tiket"],
    scanStatus: json["scan_status"],
    idTransaksiBookingTiket: json["id_transaksi_booking_tiket"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_tiket": noTiket,
    "scan_status": scanStatus,
    "id_transaksi_booking_tiket": idTransaksiBookingTiket,
  };
}
