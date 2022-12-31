// To parse this JSON data, do
//
//     final parkingConfirmModel = parkingConfirmModelFromJson(jsonString);

import 'dart:convert';

ParkingConfirmModel parkingConfirmModelFromJson(String str) =>
    ParkingConfirmModel.fromJson(json.decode(str));

String parkingConfirmModelToJson(ParkingConfirmModel data) =>
    json.encode(data.toJson());

class ParkingConfirmModel {
  ParkingConfirmModel({
    this.id,
    this.nomorParkir,
    this.status,
    this.helm,
    this.isExpired,
    this.idKendaraan,
    this.idKaryawan,
    this.idUser,
    this.createdAt,
    this.updatedAt,
    this.vehicle,
    this.employee,
    this.user,
  });

  int? id;
  String? nomorParkir,
      status,
      helm,
      isExpired,
      idKendaraan,
      idKaryawan,
      idUser,
      createdAt,
      updatedAt;
  Vehicle? vehicle;
  Employee? employee;
  User? user;

  factory ParkingConfirmModel.fromJson(Map<String, dynamic> json) =>
      ParkingConfirmModel(
        id: json["id"],
        nomorParkir: json["nomor_parkir"],
        status: json["status"],
        helm: json["helm"],
        isExpired: json["is_expired"],
        idKendaraan: json["id_kendaraan"],
        idKaryawan: json["id_karyawan"],
        idUser: json["id_user"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        vehicle: Vehicle.fromJson(json["vehicle"]),
        employee: Employee.fromJson(json["employee"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor_parkir": nomorParkir,
        "status": status,
        "helm": helm,
        "is_expired": isExpired,
        "id_kendaraan": idKendaraan,
        "id_karyawan": idKaryawan,
        "id_user": idUser,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "vehicle": vehicle!.toJson(),
        "employee": employee!.toJson(),
        "user": user!.toJson(),
      };
}

class Employee {
  Employee({
    this.id,
    this.nama,
    this.deskripsi,
    this.email,
    this.isActive,
    this.role,
    this.alamat,
    this.noTelepon,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama, deskripsi, email, isActive, role, alamat, noTelepon, avatar;
  DateTime? createdAt, updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        email: json["email"],
        isActive: json["is_active"],
        role: json["role"],
        alamat: json["alamat"],
        noTelepon: json["no_telepon"],
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "email": email,
        "is_active": isActive,
        "role": role,
        "alamat": alamat,
        "no_telepon": noTelepon,
        "avatar": avatar,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class User {
  User({
    this.id,
    this.nama,
    this.nim,
    this.email,
    this.alamat,
    this.noTelepon,
    this.tanggalLahir,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama, nim, email, alamat, noTelepon, avatar;
  DateTime? tanggalLahir, createdAt, updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["nama"],
        nim: json["nim"],
        email: json["email"],
        alamat: json["alamat"],
        noTelepon: json["no_telepon"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        avatar: json["avatar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nim": nim,
        "email": email,
        "alamat": alamat,
        "no_telepon": noTelepon,
        "tanggal_lahir": tanggalLahir!.toIso8601String(),
        "avatar": avatar,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Vehicle {
  Vehicle({
    this.id,
    this.nama,
    this.merek,
    this.noPolisi,
    this.fotoStnk,
    this.fotoKendaraan,
    this.isUser,
    this.idUser,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama, merek, noPolisi, fotoStnk, fotoKendaraan, isUser, idUser;
  DateTime? createdAt, updatedAt;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        nama: json["nama"],
        merek: json["merek"],
        noPolisi: json["no_polisi"],
        fotoStnk: json["foto_stnk"],
        fotoKendaraan: json["foto_kendaraan"],
        isUser: json["is_user"],
        idUser: json["id_user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "merek": merek,
        "no_polisi": noPolisi,
        "foto_stnk": fotoStnk,
        "foto_kendaraan": fotoKendaraan,
        "is_user": isUser,
        "id_user": idUser,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
