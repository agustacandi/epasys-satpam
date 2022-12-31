class UserModel {
  UserModel({
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
    this.token,
  });

  int? id;
  String? nama, nim, email, alamat, noTelepon, avatar, token;
  DateTime? tanggalLahir, createdAt, updatedAt;
  dynamic emailVerifiedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
        token: json['token'],
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
