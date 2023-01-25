import 'dart:convert';

class ParkingQuotaResponse {
  ParkingQuotaResponse({
    this.code,
    this.status,
    this.message,
    required this.data,
  });

  int? code;
  bool? status;
  String? message;
  List<ParkingQuota> data;

  factory ParkingQuotaResponse.fromJson(Map<String, dynamic> json) => ParkingQuotaResponse(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ParkingQuota>.from(json["data"].map((x) => ParkingQuota.fromJson(x))),
  );
}

class ParkingQuota {
  ParkingQuota({
    this.idJenisKendaraan,
    this.namaJenisKendaraan,
    this.jumlah,
    this.quota,
  });

  int? idJenisKendaraan;
  String? namaJenisKendaraan;
  int? jumlah;
  int? quota;

  factory ParkingQuota.fromJson(Map<String, dynamic> json) => ParkingQuota(
    idJenisKendaraan: json["id_jenis_kendaraan"],
    namaJenisKendaraan: json["nama_jenis_kendaraan"],
    jumlah: json["jumlah"],
    quota: json["quota"],
  );

  Map<String, dynamic> toJson() => {
    "id_jenis_kendaraan": idJenisKendaraan,
    "nama_jenis_kendaraan": namaJenisKendaraan,
    "jumlah": jumlah,
    "quota": quota,
  };
}
