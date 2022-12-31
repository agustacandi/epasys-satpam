import 'package:epasys_app/models/employee_model.dart';

class BroadcastModel {
  int? id;
  String? judul;
  String? body;
  String? imgUrl;
  EmployeeModel? employee;
  DateTime? createdAt;
  DateTime? updatedAt;

  BroadcastModel({
    this.id,
    this.judul,
    this.body,
    this.imgUrl,
    this.employee,
    this.createdAt,
    this.updatedAt,
  });

  BroadcastModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    body = json['body'];
    imgUrl = json['img_url'];
    employee = EmployeeModel.fromJson(json['employee']);
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'body': body,
      'img_url': imgUrl,
      'employee': employee!,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
