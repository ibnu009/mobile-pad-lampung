import 'dart:convert';

ParkCheckOutRequest parkRequestFromJson(String str) => ParkCheckOutRequest.fromJson(json.decode(str));

String parkRequestToJson(ParkCheckOutRequest data) => json.encode(data.toJson());

class ParkCheckOutRequest {
  ParkCheckOutRequest({
    required this.noTransaksiPark,
    required this.jenisKendaraan,
    required this.tarif,
  });

  String noTransaksiPark;
  int jenisKendaraan;
  int tarif;

  factory ParkCheckOutRequest.fromJson(Map<String, dynamic> json) => ParkCheckOutRequest(
    noTransaksiPark: json["no_transaksi_parkir"],
    jenisKendaraan: json["jenis_kendaraan"],
    tarif: json["tarif"],
  );

  Map<String, dynamic> toJson() => {
    "no_transaksi_parkir": noTransaksiPark,
    "jenis_kendaraan": jenisKendaraan,
    "tarif": tarif,
  };
}
