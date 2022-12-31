import 'dart:convert';

import 'package:epasys_app/models/employee_model.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  String baseUrl = 'https://kelompok17stiebi.website/api';

  Future<List<EmployeeModel>> getTeknisi() async {
    String url = '${SharedConfig().url}/employees?role=TEKNISI';
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<EmployeeModel> teknisi = [];

      for (var teknis in data) {
        teknisi.add(EmployeeModel.fromJson(teknis));
      }

      return teknisi;
    } else {
      throw 'Error getEmployees in EmployeeService';
    }
  }

  Future<List<EmployeeModel>> getSatpam() async {
    String url = '${SharedConfig().url}/employees?role=SATPAM';
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<EmployeeModel> satpam = [];

      for (var stpm in data) {
        satpam.add(EmployeeModel.fromJson(stpm));
      }

      return satpam;
    } else {
      throw 'Error getEmployees in EmployeeService';
    }
  }

  Future<EmployeeModel> activateEmployee(String token) async {
    String url = '${SharedConfig().url}/employees/auth/active';
    var headers = {
      'Authorization': token,
    };

    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return EmployeeModel.fromJson(data);
    } else {
      throw 'Error activateEmployee in EmployeeService';
    }
  }
}
