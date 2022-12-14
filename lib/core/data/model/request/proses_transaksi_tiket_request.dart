import 'dart:convert';

RequestProsesTransaksiTiket requestProsesTransaksiTiketFromJson(String str) => RequestProsesTransaksiTiket.fromJson(json.decode(str));

String requestProsesTransaksiTiketToJson(RequestProsesTransaksiTiket data) => json.encode(data.toJson());

class RequestProsesTransaksiTiket {
  RequestProsesTransaksiTiket({
    required this.noTelp,
    required this.email,
    required this.metodePembayaran,
    required this.tanggal,
    required this.idTempatWisata,
    required this.transaksiBookingTiket,
  });

  String? noTelp;
  String? email;
  String metodePembayaran;
  String tanggal;
  int idTempatWisata;
  TransaksiBookingTiketRequest transaksiBookingTiket;

  factory RequestProsesTransaksiTiket.fromJson(Map<String, dynamic> json) => RequestProsesTransaksiTiket(
    noTelp: json["no_telp"],
    email: json["email"],
    metodePembayaran: json["metode_pembayaran"],
    tanggal: json["tanggal"],
    idTempatWisata: json["id_tempat_wisata"],
    transaksiBookingTiket: TransaksiBookingTiketRequest.fromJson(json["transaksi_booking_tiket"]),
  );

  Map<String, dynamic> toJson() => {
    "no_telp": noTelp,
    "email": email,
    "metode_pembayaran": metodePembayaran,
    "tanggal": tanggal,
    "id_tempat_wisata": idTempatWisata,
    "transaksi_booking_tiket": transaksiBookingTiket.toJson(),
  };
}

class TransaksiBookingTiketRequest {
  TransaksiBookingTiketRequest({
    required this.jumlah,
    required this.idTarifTiket,
  });

  int jumlah;
  int idTarifTiket;

  factory TransaksiBookingTiketRequest.fromJson(Map<String, dynamic> json) => TransaksiBookingTiketRequest(
    jumlah: json["jumlah"],
    idTarifTiket: json["id_tarif_tiket"],
  );

  Map<String, dynamic> toJson() => {
    "jumlah": jumlah,
    "id_tarif_tiket": idTarifTiket,
  };
}


class TransaksiBookingTiket {
  TransaksiBookingTiket({
    required this.id,
    required this.jumlah,
    required this.subtotal,
    required this.idTransaksiBooking,
    required this.idTarifTiket,
    required this.createdAt,
    required this.updatedAt,
    required this.scanTime,
  });

  int id;
  int jumlah;
  int subtotal;
  int idTransaksiBooking;
  int idTarifTiket;
  String createdAt;
  String updatedAt;
  String scanTime;

  factory TransaksiBookingTiket.fromJson(Map<String, dynamic> json) => TransaksiBookingTiket(
    id: json["id"],
    jumlah: json["jumlah"],
    subtotal: json["subtotal"],
    idTransaksiBooking: json["id_transaksi_booking"],
    idTarifTiket: json["id_tarif_tiket"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    scanTime: json["scan_time"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jumlah": jumlah,
    "subtotal": subtotal,
    "id_transaksi_booking": idTransaksiBooking,
    "id_tarif_tiket": idTarifTiket,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "scan_time": scanTime,
  };
}

class TarifTiket {
  TarifTiket({
    required this.id,
    required this.idTempatWisata,
    required this.tarifWeekend,
    required this.tarifWeekday,
    required this.createdAt,
    required this.updatedAt,
    required this.quota,
  });

  int id;
  int idTempatWisata;
  int tarifWeekend;
  int tarifWeekday;
  DateTime createdAt;
  DateTime updatedAt;
  int quota;

  factory TarifTiket.fromJson(Map<String, dynamic> json) => TarifTiket(
    id: json["id"],
    idTempatWisata: json["id_tempat_wisata"],
    tarifWeekend: json["tarif_weekend"],
    tarifWeekday: json["tarif_weekday"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    quota: json["quota"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_tempat_wisata": idTempatWisata,
    "tarif_weekend": tarifWeekend,
    "tarif_weekday": tarifWeekday,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "quota": quota,
  };
}

