// To parse this JSON data, do
//
//     final responseParking = responseParkingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseParking responseParkingFromJson(String str) => ResponseParking.fromJson(json.decode(str));

String responseParkingToJson(ResponseParking data) => json.encode(data.toJson());

class ResponseParking {
  ResponseParking({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
    required this.length,
  });

  int code;
  bool status;
  String message;
  List<ParkingData> data;
  int length;

  factory ResponseParking.fromJson(Map<String, dynamic> json) => ResponseParking(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data:json["data"] == null ? [] : List<ParkingData>.from(json["data"].map((x) => ParkingData.fromJson(x))),
    length: json["length"]
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "length": length,
  };
}

class ParkingData {
  ParkingData({
    required this.id,
    required this.noTransaksiParkir,
    required this.nopol,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.tarif,
    required this.status,
    required this.pathFotoKendaraan,
    required this.statusBayar,
    required this.idTempatWisata,
    required this.idTransaksiBookingParkir,
    required this.idJenisKendaraan,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String noTransaksiParkir;
  dynamic nopol;
  String? waktuMasuk;
  String? waktuKeluar;
  int tarif;
  int status;
  String pathFotoKendaraan;
  int statusBayar;
  int idTempatWisata;
  dynamic idTransaksiBookingParkir;
  int idJenisKendaraan;
  DateTime createdAt;
  DateTime updatedAt;

  factory ParkingData.fromJson(Map<String, dynamic> json) => ParkingData(
    id: json["id"],
    noTransaksiParkir: json["no_transaksi_parkir"],
    nopol: json["nopol"],
    waktuMasuk: json["waktu_masuk"],
    waktuKeluar: json["waktu_keluar"],
    tarif: json["tarif"],
    status: json["status"],
    pathFotoKendaraan: json["path_foto_kendaraan"],
    statusBayar: json["status_bayar"],
    idTempatWisata: json["id_tempat_wisata"],
    idTransaksiBookingParkir: json["id_transaksi_booking_parkir"],
    idJenisKendaraan: json["id_jenis_kendaraan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_transaksi_parkir": noTransaksiParkir,
    "nopol": nopol,
    "waktu_masuk": waktuMasuk,
    "waktu_keluar": waktuKeluar,
    "tarif": tarif,
    "status": status,
    "path_foto_kendaraan": pathFotoKendaraan,
    "status_bayar": statusBayar,
    "id_tempat_wisata": idTempatWisata,
    "id_transaksi_booking_parkir": idTransaksiBookingParkir,
    "id_jenis_kendaraan": idJenisKendaraan,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
