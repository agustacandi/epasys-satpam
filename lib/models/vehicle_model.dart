import 'package:epasys_app/models/user_model.dart';

class VehicleModel {
  VehicleModel({
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
    this.user,
  });

  int? id, isUser, idUser;
  String? nama, merek, noPolisi, fotoStnk, fotoKendaraan;
  DateTime? createdAt, updatedAt;
  UserModel? user;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
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
        user: UserModel.fromJson(json["user"]),
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
        "user": user!.toJson(),
      };
}
