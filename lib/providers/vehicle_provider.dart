import 'dart:io';

import 'package:epasys_app/models/vehicle_model.dart';
import 'package:epasys_app/services/vehicle_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VehicleProvider with ChangeNotifier {
  List<VehicleModel> _vehicles = [];

  List<VehicleModel> get vehicles => _vehicles;

  set vehicles(List<VehicleModel> vehicles) {
    _vehicles = vehicles;
  }

  Future<bool> getVehicles(String token) async {
    try {
      List<VehicleModel> vehicles = await VehicleService().getVechiles(token);
      _vehicles = vehicles;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error getVechiles in VechileProvider: $e');
      return false;
    }
  }

  Future<bool> addVehicle(int idUser, String nama, String merek,
      String noPolisi, File? motor, File? stnk, String token) async {
    http.StreamedResponse addVehicle = await VehicleService()
        .addVehicle(idUser, nama, merek, noPolisi, motor, stnk, token);
    if (addVehicle.statusCode == 201) {
      List<VehicleModel> vehicles = await VehicleService().getVechiles(token);
      _vehicles = vehicles;
      notifyListeners();
      return true;
    } else {
      print('Error addVehicle in VehicleProvider: ${addVehicle.reasonPhrase}');
      return false;
    }
  }

  Future<bool> editVehicle(String idKendaraan, String nama, String merek,
      String noPolisi, File? motor, File? stnk, String token) async {
    http.StreamedResponse editVehicle = await VehicleService()
        .editVehicle(idKendaraan, nama, merek, noPolisi, motor, stnk, token);
    if (editVehicle.statusCode == 200) {
      List<VehicleModel> vehicles = await VehicleService().getVechiles(token);
      _vehicles = vehicles;
      notifyListeners();
      return true;
    } else {
      print(
          'Error editVehicle in VehicleProvider: ${editVehicle.reasonPhrase}');
      return false;
    }
  }

  Future<bool> deleteVehicle(int id, String token) async {
    try {
      await VehicleService().deleteVehicle(id, token);
      List<VehicleModel> vehicles = await VehicleService().getVechiles(token);
      _vehicles = vehicles;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleteVehicle in VehicleService: $e');
      return false;
    }
  }
}
