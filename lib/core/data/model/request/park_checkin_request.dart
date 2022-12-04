import 'dart:convert';

ParkCheckInRequest parkRequestFromJson(String str) => ParkCheckInRequest.fromJson(json.decode(str));

String parkRequestToJson(ParkCheckInRequest data) => json.encode(data.toJson());

class ParkCheckInRequest {
  ParkCheckInRequest({
    required this.noTransaksiPark,
    required this.locationId,
  });

  String noTransaksiPark;
  int locationId;

  factory ParkCheckInRequest.fromJson(Map<String, dynamic> json) => ParkCheckInRequest(
    noTransaksiPark: json["no_transaksi_parkir"],
    locationId: json["id_lokasi"],
  );

  Map<String, dynamic> toJson() => {
    "no_transaksi_parkir": noTransaksiPark,
    "id_lokasi": locationId,
  };
}
