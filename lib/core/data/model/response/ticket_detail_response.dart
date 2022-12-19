
import 'package:meta/meta.dart';
import 'dart:convert';

import '../request/proses_transaksi_tiket_request.dart';

ResponseDetailTicket responseDetailTicketFromJson(String str) => ResponseDetailTicket.fromJson(json.decode(str));

String responseDetailTicketToJson(ResponseDetailTicket data) => json.encode(data.toJson());

class ResponseDetailTicket {
  ResponseDetailTicket({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  Data data;

  factory ResponseDetailTicket.fromJson(Map<String, dynamic> json) => ResponseDetailTicket(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.noTransaksi,
    required this.noTelp,
    required this.email,
    required this.totalBayar,
    required this.statusBayar,
    required this.metodePembayaran,
    required this.idTempatWisata,
    required this.createdAt,
    required this.updatedAt,
    required this.tanggal,
    required this.transaksiBookingTiket,
  });

  int id;
  String noTransaksi;
  String noTelp;
  String email;
  int totalBayar;
  int statusBayar;
  String metodePembayaran;
  int idTempatWisata;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime tanggal;
  TransaksiBookingTiket transaksiBookingTiket;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    noTransaksi: json["no_transaksi"],
    noTelp: json["no_telp"],
    email: json["email"],
    totalBayar: json["total_bayar"],
    statusBayar: json["status_bayar"],
    metodePembayaran: json["metode_pembayaran"],
    idTempatWisata: json["id_tempat_wisata"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    tanggal: DateTime.parse(json["tanggal"]),
    transaksiBookingTiket: TransaksiBookingTiket.fromJson(json["transaksi_booking_tiket"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_transaksi": noTransaksi,
    "no_telp": noTelp,
    "email": email,
    "total_bayar": totalBayar,
    "status_bayar": statusBayar,
    "metode_pembayaran": metodePembayaran,
    "id_tempat_wisata": idTempatWisata,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "transaksi_booking_tiket": transaksiBookingTiket.toJson(),
  };
}

class TempatWisata {
  TempatWisata({
    required this.id,
    required this.namaTempatWisata,
    required this.idLokasi,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
  });

  int id;
  String namaTempatWisata;
  int idLokasi;
  DateTime createdAt;
  DateTime updatedAt;
  int active;

  factory TempatWisata.fromJson(Map<String, dynamic> json) => TempatWisata(
    id: json["id"],
    namaTempatWisata: json["nama_tempat_wisata"],
    idLokasi: json["id_lokasi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_tempat_wisata": namaTempatWisata,
    "id_lokasi": idLokasi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "active": active,
  };
}


