import 'dart:io';
import 'dart:convert';

RequestMasukTanpaBooking requestMasukTanpaBookingFromJson(String str) => RequestMasukTanpaBooking.fromJson(json.decode(str));

String requestMasukTanpaBookingToJson(RequestMasukTanpaBooking data) => json.encode(data.toJson());

class RequestMasukTanpaBooking {
  RequestMasukTanpaBooking({
    required this.idTempatWisata,
    required this.idJenisKendaraan,
    required this.fotoKendaraan,
  });

  int idTempatWisata;
  int idJenisKendaraan;
  File fotoKendaraan;

  factory RequestMasukTanpaBooking.fromJson(Map<String, dynamic> json) => RequestMasukTanpaBooking(
    idTempatWisata: json["id_tempat_wisata"],
    idJenisKendaraan: json["id_jenis_kendaraan"],
    fotoKendaraan: json["foto_kendaraan"],
  );

  Map<String, dynamic> toJson() => {
    "id_tempat_wisata": idTempatWisata,
    "id_jenis_kendaraan": idJenisKendaraan,
    "foto_kendaraan": fotoKendaraan,
  };
}
