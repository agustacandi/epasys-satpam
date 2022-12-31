import 'dart:convert';

import 'package:epasys_app/models/parking_confirm_model.dart';
import 'package:epasys_app/models/parking_model.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingService extends ChangeNotifier {
  Future<ParkingConfirmModel> getParking(String id, String token) async {
    String url = '${SharedConfig().url}/parkings?id=$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      ParkingConfirmModel parking = ParkingConfirmModel.fromJson(data);
      return parking;
    } else {
      throw 'Error getParking in ParkingService';
    }
  }

  Future<List<ParkingModel>> getLatestParkings(String token) async {
    String url = '${SharedConfig().url}/parkings/latest';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ParkingModel> parkings = [];
      for (var parking in data) {
        parkings.add(ParkingModel.fromJson(parking));
      }
      return parkings;
    } else {
      throw 'Error getParkings in ParkingService';
    }
  }

  Future<List<ParkingModel>> getParkingsToday() async {
    String url = '${SharedConfig().url}/parkings/today';
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<ParkingModel> parkings = [];
      for (var parking in data) {
        parkings.add(ParkingModel.fromJson(parking));
      }
      return parkings;
    } else {
      throw 'Error getParkings in ParkingService';
    }
  }

  Future<dynamic> getCheckOut(String token) async {
    String url = '${SharedConfig().url}/parkings/out';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data == null) {
        return null;
      }
      ParkingModel checkOut = ParkingModel.fromJson(data);
      return checkOut;
    } else {
      throw 'Error getParkings in ParkingService';
    }
  }

  Future<double> countCheckIn() async {
    String url = '${SharedConfig().url}/parkings/in/count';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = double.parse(jsonDecode(response.body)['data'].toString());
      return data;
    } else {
      throw 'Error countCheckIn in ParkingService';
    }
  }

  Future<double> countCheckOut() async {
    String url = '${SharedConfig().url}/parkings/out/count';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = double.parse(jsonDecode(response.body)['data'].toString());
      return data;
    } else {
      throw 'Error countCheckOut in ParkingService';
    }
  }

  Future<http.StreamedResponse> confirmParking(
    String noParkir,
    String token,
  ) async {
    try {
      String url = '${SharedConfig().url}/parkings/confirm?id=$noParkir';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var requset = http.MultipartRequest('POST', Uri.parse(url));
      requset.headers.addAll(headers);

      var response = await requset.send();

      return response;
    } catch (e) {
      throw 'Error confirmParking in ParkingService: $e';
    }
  }
}
