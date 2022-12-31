import 'dart:convert';
import 'dart:io';
import 'package:epasys_app/models/vehicle_model.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  Future<List<VehicleModel>> getVechiles(String token) async {
    String url = '${SharedConfig().url}/vehicles';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<VehicleModel> vehicles = [];
      for (var vehicle in data) {
        vehicles.add(VehicleModel.fromJson(vehicle));
      }
      return vehicles;
    } else {
      throw 'Error getVechiles in VechileService';
    }
  }

  Future<http.StreamedResponse> addVehicle(
      int idUser,
      String nama,
      String merek,
      String noPolisi,
      File? motor,
      File? stnk,
      String token) async {
    try {
      String url = '${SharedConfig().url}/vehicles';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      request.files.add(
          await http.MultipartFile.fromPath('foto_kendaraan', motor!.path));
      request.files
          .add(await http.MultipartFile.fromPath('foto_stnk', stnk!.path));

      request.fields['nama'] = nama;
      request.fields['merek'] = merek;
      request.fields['no_polisi'] = noPolisi;
      request.fields['id_user'] = idUser.toString();

      var response = await request.send();
      return response;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<http.StreamedResponse> editVehicle(
      String idKendaraan,
      String nama,
      String merek,
      String noPolisi,
      File? motor,
      File? stnk,
      String token) async {
    try {
      String url = '${SharedConfig().url}/vehicles/update?id=$idKendaraan';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      if (motor != null) {
        request.files.add(
            await http.MultipartFile.fromPath('foto_kendaraan', motor.path));
      }

      if (stnk != null) {
        request.files
            .add(await http.MultipartFile.fromPath('foto_stnk', stnk.path));
      }

      if (nama != '') {
        request.fields['nama'] = nama;
      }

      if (merek != '') {
        request.fields['merek'] = merek;
      }

      if (noPolisi != '') {
        request.fields['no_polisi'] = noPolisi;
      }

      var response = await request.send();
      return response;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<bool> deleteVehicle(int id, String token) async {
    String url = '${SharedConfig().url}/vehicles?id=$id';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
