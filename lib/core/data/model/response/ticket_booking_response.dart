
import 'dart:convert';

ResponseProsesTransaksiTiket responseProsesTransaksiTiketFromJson(String str) => ResponseProsesTransaksiTiket.fromJson(json.decode(str));

String responseProsesTransaksiTiketToJson(ResponseProsesTransaksiTiket data) => json.encode(data.toJson());

class ResponseProsesTransaksiTiket {
  ResponseProsesTransaksiTiket({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  Data data;

  factory ResponseProsesTransaksiTiket.fromJson(Map<String, dynamic> json) => ResponseProsesTransaksiTiket(
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
    required this.tanggal,
    required this.noTransaksi,
    required this.noTelp,
    required this.email,
    required this.totalBayar,
    required this.statusBayar,
    required this.metodePembayaran,
    required this.idTempatWisata,
    required this.tempatWisata,
    required this.transaksiBookingTiket,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  DateTime tanggal;
  String noTransaksi;
  String noTelp;
  String email;
  int totalBayar;
  int statusBayar;
  String metodePembayaran;
  int idTempatWisata;
  TempatWisata tempatWisata;
  TransaksiBookingTiketNew transaksiBookingTiket;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    tanggal: DateTime.parse(json["tanggal"]),
    noTransaksi: json["no_transaksi"],
    noTelp: json["no_telp"],
    email: json["email"],
    totalBayar: json["total_bayar"],
    statusBayar: json["status_bayar"],
    metodePembayaran: json["metode_pembayaran"],
    idTempatWisata: json["id_tempat_wisata"],
    tempatWisata: TempatWisata.fromJson(json["tempat_wisata"]),
    transaksiBookingTiket: TransaksiBookingTiketNew.fromJson(json["transaksi_booking_tiket"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "no_transaksi": noTransaksi,
    "no_telp": noTelp,
    "email": email,
    "total_bayar": totalBayar,
    "status_bayar": statusBayar,
    "metode_pembayaran": metodePembayaran,
    "id_tempat_wisata": idTempatWisata,
    "tempat_wisata": tempatWisata.toJson(),
    "transaksi_booking_tiket": transaksiBookingTiket.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class TempatWisata {
  TempatWisata({
    required this.id,
    required this.namaTempatWisata,
    required this.idLokasi,
    required this.lokasi,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String namaTempatWisata;
  int idLokasi;
  Lokasi lokasi;
  int active;
  DateTime createdAt;
  DateTime updatedAt;

  factory TempatWisata.fromJson(Map<String, dynamic> json) => TempatWisata(
    id: json["id"],
    namaTempatWisata: json["nama_tempat_wisata"],
    idLokasi: json["id_lokasi"],
    lokasi: Lokasi.fromJson(json["lokasi"]),
    active: json["active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_tempat_wisata": namaTempatWisata,
    "id_lokasi": idLokasi,
    "lokasi": lokasi.toJson(),
    "active": active,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Lokasi {
  Lokasi({
    required this.id,
    required this.namaLokasi,
    required this.createdAt,
    required this.updatedAt,
    required this.namaJenisKendaraan,
  });

  int id;
  String namaLokasi;
  DateTime createdAt;
  DateTime updatedAt;
  String namaJenisKendaraan;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
    id: json["id"],
    namaLokasi: json["nama_lokasi"] == null ? null : json["nama_lokasi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    namaJenisKendaraan: json["nama_jenis_kendaraan"] == null ? null : json["nama_jenis_kendaraan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_lokasi": namaLokasi == null ? null : namaLokasi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nama_jenis_kendaraan": namaJenisKendaraan == null ? null : namaJenisKendaraan,
  };
}

class TransaksiBookingTiketNew {
  TransaksiBookingTiketNew({
    required this.id,
    required this.subtotal,
    required this.jumlah,
    required this.idTarifTiket,
    required this.idTransaksiBooking,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int subtotal;
  int jumlah;
  int idTarifTiket;
  int idTransaksiBooking;
  DateTime createdAt;
  DateTime updatedAt;

  factory TransaksiBookingTiketNew.fromJson(Map<String, dynamic> json) => TransaksiBookingTiketNew(
    id: json["id"],
    subtotal: json["subtotal"],
    jumlah: json["jumlah"],
    idTarifTiket: json["id_tarif_tiket"],
    idTransaksiBooking: json["id_transaksi_booking"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subtotal": subtotal,
    "jumlah": jumlah,
    "id_tarif_tiket": idTarifTiket,
    "id_transaksi_booking": idTransaksiBooking,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
