// import 'package:epasys_app/models/employee_model.dart';
// import 'package:epasys_app/models/user_model.dart';
// import 'package:epasys_app/models/vehicle_model.dart';

// class ParkingModel {
//   int? id;
//   String? nomorParkir;
//   String? status;
//   int? helm;
//   bool? isExpired;
//   int? idKendaraan;
//   int? idKaryawan;
//   int? idUser;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   VehicleModel? vehicle;
//   UserModel? user;
//   EmployeeModel? employee;

//   ParkingModel({
//     this.id,
//     this.status,
//     this.nomorParkir,
//     this.helm,
//     this.isExpired,
//     this.idKaryawan,
//     this.idKendaraan,
//     this.idUser,
//     this.createdAt,
//     this.updatedAt,
//     this.vehicle,
//     this.employee,
//   });

//   ParkingModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nomorParkir = json['nomor_parkir'];
//     status = json['status'];
//     helm = json['helm'];
//     isExpired = json['is_expired'] == 1 ? true : false;
//     idKendaraan = json['id_kendaraan'];
//     idKaryawan = json['id_karyawan'];
//     idUser = json['id_user'];
//     createdAt = DateTime.parse(json['created_at']);
//     updatedAt = DateTime.parse(json['updated_at']);
//     vehicle = VehicleModel.fromJson(json['vehicle']);
//     user = UserModel.fromJson(json['user']);
//     employee = EmployeeModel.fromJson(json['employee']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'status': status,
//       'helm': helm,
//       'is_expired': isExpired,
//       'id_kendaraan': idKendaraan,
//       'id_karyawan': idKaryawan,
//       'id_user': idUser,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'vehicle': vehicle,
//       'user': user,
//       'employee': employee,
//     };
//   }
// }

class ParkingModel {
  ParkingModel({
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

  int? id, helm, idKendaraan, idKaryawan, idUser;
  String? nomorParkir, status;
  DateTime? createdAt, updatedAt;
  bool? isExpired;
  Vehicle? vehicle;
  Employee? employee;
  User? user;

  factory ParkingModel.fromJson(Map<String, dynamic> json) => ParkingModel(
        id: json["id"],
        nomorParkir: json["nomor_parkir"],
        status: json["status"],
        helm: json["helm"],
        isExpired: json["is_expired"] == '1' ? true : false,
        idKendaraan: json["id_kendaraan"],
        idKaryawan: json["id_karyawan"],
        idUser: json["id_user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt!.toString(),
        "updated_at": updatedAt!.toString(),
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
    this.role,
    this.alamat,
    this.noTelepon,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama, deskripsi, email, role, alamat, noTelepon, avatar;
  DateTime? createdAt, updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        email: json["email"],
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
        "role": role,
        "alamat": alamat,
        "no_telepon": noTelepon,
        "avatar": avatar,
        "created_at": createdAt!.toString(),
        "updated_at": updatedAt!.toString(),
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
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama, nim, email, alamat, noTelepon, avatar;
  DateTime? tanggalLahir, createdAt, updatedAt;
  dynamic emailVerifiedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["nama"],
        nim: json["nim"],
        email: json["email"],
        alamat: json["alamat"],
        noTelepon: json["no_telepon"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
        avatar: json["avatar"],
        emailVerifiedAt: json["email_verified_at"],
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
        "tanggal_lahir":
            "${tanggalLahir!.year.toString().padLeft(4, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.day.toString().padLeft(2, '0')}",
        "avatar": avatar,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toString(),
        "updated_at": updatedAt!.toString(),
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

  int? id, isUser, idUser;
  String? nama, merek, noPolisi, fotoStnk, fotoKendaraan;
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
        "created_at": createdAt!.toString(),
        "updated_at": updatedAt!.toString(),
      };
}
