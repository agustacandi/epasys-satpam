import 'dart:convert';
import 'dart:io';

import 'package:epasys_app/models/broadcast_model.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:http/http.dart' as http;

class BroadcastService {
  String baseUrl = 'https://kelompok17stiebi.website/api';

  Future<List<BroadcastModel>> getBroadcasts() async {
    String url = '${SharedConfig().url}/broadcasts';
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<BroadcastModel> broadcasts = [];

      for (var broadcast in data) {
        broadcasts.add(BroadcastModel.fromJson(broadcast));
      }

      return broadcasts;
    } else {
      throw 'Gagal mendapatkan data broadcast';
    }
  }

  Future<List<BroadcastModel>> getBroadcastsByToken(String token) async {
    String url = '${SharedConfig().url}/broadcasts/token';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<BroadcastModel> broadcasts = [];

      for (var broadcast in data) {
        broadcasts.add(BroadcastModel.fromJson(broadcast));
      }
      return broadcasts;
    } else {
      throw 'Gagal mendapatkan data broadcast';
    }
  }

  Future<http.StreamedResponse> createBroadcast(
      String token, String judul, String body, File? foto) async {
    try {
      String url = '${SharedConfig().url}/broadcasts';
      var headers = {
        'Authorization': token,
      };
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields['judul'] = judul;
      request.fields['body'] = body;
      if (foto != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img_url', foto.path));
      }
      var response = await request.send();
      return response;
    } catch (e) {
      throw 'Gagal membuat broadcast: $e';
    }
  }

  Future<http.StreamedResponse> editBroadcast(String idBroadcast, String judul,
      String body, File? foto, String token) async {
    try {
      String url = '${SharedConfig().url}/broadcasts/update?id=$idBroadcast';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      if (foto != null) {
        request.files
            .add(await http.MultipartFile.fromPath('img_url', foto.path));
      }

      if (judul != '') {
        request.fields['judul'] = judul;
      }

      if (body != '') {
        request.fields['body'] = body;
      }

      var response = await request.send();
      return response;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<bool> deleteVehicle(int id, String token) async {
    String url = '${SharedConfig().url}/broadcasts?id=$id';

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
