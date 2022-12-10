import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  String accessToken;
  String tokenType;
  int expiresIn;
  User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.email,
    required this.username,
    required this.tipeUser,
    required this.roleId,
    required this.idPegawai,
    required this.createdAt,
    required this.updatedAt,
    required this.petugas,
  });

  int id;
  String email;
  String username;
  int tipeUser;
  int roleId;
  int idPegawai;
  DateTime createdAt;
  DateTime updatedAt;
  Petugas petugas;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    username: json["username"],
    tipeUser: json["tipe_user"],
    roleId: json["role_id"],
    idPegawai: json["id_pegawai"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    petugas: Petugas.fromJson(json["petugas"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "username": username,
    "tipe_user": tipeUser,
    "role_id": roleId,
    "id_pegawai": idPegawai,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "petugas": petugas.toJson(),
  };
}

class Petugas {
  Petugas({
    required this.id,
    required this.nama,
    required this.nip,
    required this.noTelp,
    required this.jenisPegawai,
    required this.jenisKelamin,
    required this.alamat,
    required this.idTempatWisata,
    required this.createdAt,
    required this.updatedAt,
    required this.tempatWisata,
  });

  int id;
  String nama;
  String nip;
  String noTelp;
  int jenisPegawai;
  String jenisKelamin;
  String alamat;
  int idTempatWisata;
  DateTime createdAt;
  DateTime updatedAt;
  TempatWisata tempatWisata;

  factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
    id: json["id"],
    nama: json["nama"],
    nip: json["nip"],
    noTelp: json["no_telp"],
    jenisPegawai: json["jenis_pegawai"],
    jenisKelamin: json["jenis_kelamin"],
    alamat: json["alamat"],
    idTempatWisata: json["id_tempat_wisata"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    tempatWisata: TempatWisata.fromJson(json["tempat_wisata"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "nip": nip,
    "no_telp": noTelp,
    "jenis_pegawai": jenisPegawai,
    "jenis_kelamin": jenisKelamin,
    "alamat": alamat,
    "id_tempat_wisata": idTempatWisata,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "tempat_wisata": tempatWisata.toJson(),
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
    required this.lokasi,
  });

  int id;
  String namaTempatWisata;
  int idLokasi;
  DateTime createdAt;
  DateTime updatedAt;
  int active;
  Lokasi lokasi;

  factory TempatWisata.fromJson(Map<String, dynamic> json) => TempatWisata(
    id: json["id"],
    namaTempatWisata: json["nama_tempat_wisata"],
    idLokasi: json["id_lokasi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    active: json["active"],
    lokasi: Lokasi.fromJson(json["lokasi"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_tempat_wisata": namaTempatWisata,
    "id_lokasi": idLokasi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "active": active,
    "lokasi": lokasi.toJson(),
  };
}

class Lokasi {
  Lokasi({
    required this.id,
    required this.namaLokasi,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String namaLokasi;
  DateTime createdAt;
  DateTime updatedAt;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
    id: json["id"],
    namaLokasi: json["nama_lokasi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_lokasi": namaLokasi,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
