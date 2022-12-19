import 'dart:convert';

ResponseJenisKendaraan responseJenisKendaraanFromJson(String str) => ResponseJenisKendaraan.fromJson(json.decode(str));

String responseJenisKendaraanToJson(ResponseJenisKendaraan data) => json.encode(data.toJson());

class ResponseJenisKendaraan {
  ResponseJenisKendaraan({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  List<VehicleType> data;

  factory ResponseJenisKendaraan.fromJson(Map<String, dynamic> json) => ResponseJenisKendaraan(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: List<VehicleType>.from(json["data"].map((x) => VehicleType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VehicleType {
  VehicleType({
    required this.id,
    required this.namaJenisKendaraan,
  });

  int id;
  String namaJenisKendaraan;

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
    id: json["id"],
    namaJenisKendaraan: json["nama_jenis_kendaraan"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_jenis_kendaraan": namaJenisKendaraan,
  };
}
