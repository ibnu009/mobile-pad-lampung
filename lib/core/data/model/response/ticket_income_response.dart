import 'dart:convert';

ResponseIncomeTicket responseIncomeTicketFromJson(String str) => ResponseIncomeTicket.fromJson(json.decode(str));

String responseIncomeTicketToJson(ResponseIncomeTicket data) => json.encode(data.toJson());

class ResponseIncomeTicket {
  ResponseIncomeTicket({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
    required this.total,
    required this.grandTotal,
    required this.length,
    required this.namaPegawai
  });

  int code;
  bool status;
  String message;
  List<IncomeTicket> data;
  int total;
  int grandTotal;
  int length;
  String namaPegawai;

  factory ResponseIncomeTicket.fromJson(Map<String, dynamic> json) => ResponseIncomeTicket(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<IncomeTicket>.from(json["data"].map((x) => IncomeTicket.fromJson(x))),
    total: json["pendapatan_pegawai"],
    grandTotal: json["pendapatan_semua_pegawai"],
    length: json["length"],
    namaPegawai: json["nama_pegawai"]
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "grand_total": grandTotal,
    "length": length,
  };
}

class IncomeTicket {
  IncomeTicket({
    required this.id,
    required this.noTransaksi,
    required this.noTelp,
    required this.email,
    required this.subTotal,
    required this.jumlah,
    required this.statusBayar,
    required this.metodePembayaran,
    required this.idTempatWisata,
    required this.tanggal,
  });

  int id;
  String noTransaksi;
  dynamic noTelp;
  dynamic email;
  int subTotal;
  int jumlah;
  int statusBayar;
  String metodePembayaran;
  int idTempatWisata;
  String tanggal;

  factory IncomeTicket.fromJson(Map<String, dynamic> json) => IncomeTicket(
    id: json["id"],
    noTransaksi: json["no_transaksi"],
    noTelp: json["no_telp"],
    email: json["email"],
    subTotal: json["subtotal"],
    jumlah: json['jumlah'],
    statusBayar: json["status_bayar"],
    metodePembayaran: json["metode_pembayaran"],
    idTempatWisata: json["id_tempat_wisata"],
    tanggal: json["scan_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_transaksi": noTransaksi,
    "no_telp": noTelp,
    "email": email,
    "sub_total": subTotal,
    "status_bayar": statusBayar,
    "metode_pembayaran": metodePembayaran,
    "id_tempat_wisata": idTempatWisata,
    "tanggal": tanggal,
  };
}