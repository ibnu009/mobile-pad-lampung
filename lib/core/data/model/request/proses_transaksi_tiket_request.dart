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

  String noTelp;
  String email;
  String metodePembayaran;
  String tanggal;
  int idTempatWisata;
  TransaksiBookingTiket transaksiBookingTiket;

  factory RequestProsesTransaksiTiket.fromJson(Map<String, dynamic> json) => RequestProsesTransaksiTiket(
    noTelp: json["no_telp"],
    email: json["email"],
    metodePembayaran: json["metode_pembayaran"],
    tanggal: json["tanggal"],
    idTempatWisata: json["id_tempat_wisata"],
    transaksiBookingTiket: TransaksiBookingTiket.fromJson(json["transaksi_booking_tiket"]),
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

class TransaksiBookingTiket {
  TransaksiBookingTiket({
    required this.jumlah,
    required this.idTarifTiket,
  });

  int jumlah;
  int idTarifTiket;

  factory TransaksiBookingTiket.fromJson(Map<String, dynamic> json) => TransaksiBookingTiket(
    jumlah: json["jumlah"],
    idTarifTiket: json["id_tarif_tiket"],
  );

  Map<String, dynamic> toJson() => {
    "jumlah": jumlah,
    "id_tarif_tiket": idTarifTiket,
  };
}
