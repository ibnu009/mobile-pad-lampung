// To parse this JSON data, do
//
//     final responseDetailParking = responseDetailParkingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseDetailParking responseDetailParkingFromJson(String str) =>
    ResponseDetailParking.fromJson(json.decode(str));

String responseDetailParkingToJson(ResponseDetailParking data) =>
    json.encode(data.toJson());

class ResponseDetailParking {
  ResponseDetailParking({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  ParkingDataDetail data;

  factory ResponseDetailParking.fromJson(Map<String, dynamic> json) =>
      ResponseDetailParking(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: ParkingDataDetail.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ParkingDataDetail {
  ParkingDataDetail(
      {required this.id,
      required this.noTransaksiParkir,
      required this.nopol,
      required this.waktuMasuk,
      required this.waktuKeluar,
      required this.tarif,
      required this.status,
      required this.pathFotoKendaraan,
      required this.statusBayar,
      required this.idTempatWisata,
      required this.online,
      required this.idTransaksiBookingParkir,
      required this.idJenisKendaraan,
      required this.createdAt,
      required this.updatedAt,
      required this.tempatWisata,
      required this.jenisKendaraan,
      required this.transaksiBookingParkir});

  int id;
  String noTransaksiParkir;
  String? nopol;
  String? waktuMasuk;
  String? waktuKeluar;
  int tarif;
  int status;
  String pathFotoKendaraan;
  int statusBayar;
  int idTempatWisata;
  int online;
  dynamic idTransaksiBookingParkir;
  dynamic idJenisKendaraan;
  DateTime createdAt;
  DateTime updatedAt;
  TempatWisata tempatWisata;
  JenisKendaraan jenisKendaraan;
  List<TransaksiBookingParkir> transaksiBookingParkir;

  factory ParkingDataDetail.fromJson(Map<String, dynamic> json) =>
      ParkingDataDetail(
        id: json["id"],
        noTransaksiParkir: json["no_transaksi"],
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
        tempatWisata: TempatWisata.fromJson(json["tempat_wisata"]),
        jenisKendaraan: JenisKendaraan.fromJson(json["jenis_kendaraan"]),
        transaksiBookingParkir: json["transaksi_booking_parkir"] == null
            ? []
            : List<TransaksiBookingParkir>.from(json["transaksi_booking_parkir"]
                .map((x) => TransaksiBookingParkir.fromJson(x))),
        online: json['online'],
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
        "tempat_wisata": tempatWisata.toJson(),
        "jenis_kendaraan": jenisKendaraan.toJson(),
      };
}

class JenisKendaraan {
  JenisKendaraan({
    required this.id,
    required this.namaJenisKendaraan,
    required this.createdAt,
    required this.updatedAt,
    required this.namaLokasi,
  });

  int id;
  String namaJenisKendaraan;
  DateTime createdAt;
  DateTime updatedAt;
  String namaLokasi;

  factory JenisKendaraan.fromJson(Map<String, dynamic> json) => JenisKendaraan(
        id: json["id"],
        namaJenisKendaraan: json["nama_jenis_kendaraan"] == null
            ? null
            : json["nama_jenis_kendaraan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        namaLokasi: json["nama_lokasi"] == null ? null : json["nama_lokasi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_jenis_kendaraan":
            namaJenisKendaraan == null ? null : namaJenisKendaraan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nama_lokasi": namaLokasi == null ? null : namaLokasi,
      };
}

class TempatWisata {
  TempatWisata({
    required this.id,
    required this.namaTempatWisata,
    required this.idLokasi,
    required this.active,
    required this.lokasi,
  });

  int id;
  String namaTempatWisata;
  int idLokasi;
  int active;
  JenisKendaraan lokasi;

  factory TempatWisata.fromJson(Map<String, dynamic> json) => TempatWisata(
        id: json["id"],
        namaTempatWisata: json["nama_tempat_wisata"],
        idLokasi: json["id_lokasi"],
        active: json["active"],
        lokasi: JenisKendaraan.fromJson(json["lokasi"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_tempat_wisata": namaTempatWisata,
        "id_lokasi": idLokasi,
        "active": active,
        "lokasi": lokasi.toJson(),
      };
}

class TransaksiBookingParkir {
  TransaksiBookingParkir({
    required this.id,
    required this.jumlah,
    required this.subtotal,
    required this.idTarifParkir,
    required this.idTransaksiBooking,
    required this.nopol,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.status,
    required this.pathFotoKendaraan,
    required this.idJenisKendaraan,
  });

  int id;
  int jumlah;
  int subtotal;
  int idTarifParkir;
  int idTransaksiBooking;
  dynamic nopol;
  String? waktuMasuk;
  String? waktuKeluar;
  int status;
  String pathFotoKendaraan;
  String idJenisKendaraan;

  factory TransaksiBookingParkir.fromJson(Map<String, dynamic> json) =>
      TransaksiBookingParkir(
        id: json["id"],
        jumlah: json["jumlah"],
        subtotal: json["subtotal"],
        idTarifParkir: json["id_tarif_parkir"],
        idTransaksiBooking: json["id_transaksi_booking"],
        nopol: json["nopol"],
        waktuMasuk: json["waktu_masuk"],
        waktuKeluar: json["waktu_keluar"],
        status: json["status"],
        pathFotoKendaraan: json["path_foto_kendaraan"],
        idJenisKendaraan: json["id_jenis_kendaraan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jumlah": jumlah,
        "subtotal": subtotal,
        "id_tarif_parkir": idTarifParkir,
        "id_transaksi_booking": idTransaksiBooking,
        "nopol": nopol,
        "waktu_masuk": waktuMasuk,
        "waktu_keluar": waktuKeluar,
        "status": status,
        "path_foto_kendaraan": pathFotoKendaraan,
        "id_jenis_kendaraan": idJenisKendaraan,
      };
}
