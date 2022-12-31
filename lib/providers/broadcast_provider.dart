import 'dart:convert';
import 'dart:io';

import 'package:epasys_app/models/broadcast_model.dart';
import 'package:epasys_app/services/broadcast_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BroadcastProvider with ChangeNotifier {
  List<BroadcastModel> _broadcasts = [];
  List<BroadcastModel> _listBroadcasts = [];

  List<BroadcastModel> get broadcasts => _broadcasts;
  List<BroadcastModel> get listBroadcasts => _listBroadcasts;

  set broadcasts(List<BroadcastModel> broadcasts) {
    _broadcasts = broadcasts;
    notifyListeners();
  }

  set listBroadcasts(List<BroadcastModel> listBroadcasts) {
    _listBroadcasts = listBroadcasts;
    notifyListeners();
  }

  Future<void> getBroadcasts() async {
    try {
      List<BroadcastModel> broadcasts =
          await BroadcastService().getBroadcasts();

      _broadcasts = broadcasts;
      notifyListeners();
    } catch (e) {
      print('Error getBroadcasts in BroadcastProvider: $e');
    }
  }

  Future<void> getBroadcastsByToken(String token) async {
    try {
      List<BroadcastModel> listBroadcasts =
          await BroadcastService().getBroadcastsByToken(token);
      _listBroadcasts = listBroadcasts;
      notifyListeners();
    } catch (e) {
      print('Error getBroadcastsByToken in BroadcastProvider: $e');
    }
  }

  Future<bool> createBroadcast(
      String token, String judul, String body, File? foto) async {
    http.StreamedResponse result =
        await BroadcastService().createBroadcast(token, judul, body, foto);
    if (result.statusCode == 201) {
      List<BroadcastModel> listBroadcasts =
          await BroadcastService().getBroadcastsByToken(token);
      List<BroadcastModel> broadcasts =
          await BroadcastService().getBroadcasts();
      _broadcasts = broadcasts;
      _listBroadcasts = listBroadcasts;
      notifyListeners();
      return true;
    } else {
      print(
          'Error createBroadcast in BroadcastProvider: ${result.reasonPhrase}');
      return false;
    }
  }

  Future<bool> editBroadcast(String idBroadcast, String judul, String body,
      File? foto, String token) async {
    http.StreamedResponse editBroadcast = await BroadcastService()
        .editBroadcast(idBroadcast, judul, body, foto, token);
    if (editBroadcast.statusCode == 200) {
      List<BroadcastModel> listBroadcasts =
          await BroadcastService().getBroadcastsByToken(token);
      _listBroadcasts = listBroadcasts;
      notifyListeners();
      return true;
    } else {
      print(
          'Error editVehicle in VehicleProvider ${editBroadcast.statusCode} : ${editBroadcast.reasonPhrase}');
      return false;
    }
  }

  Future<bool> deleteBroadcast(int id, String token) async {
    try {
      await BroadcastService().deleteVehicle(id, token);
      List<BroadcastModel> listBroadcasts =
          await BroadcastService().getBroadcastsByToken(token);
      List<BroadcastModel> broadcasts =
          await BroadcastService().getBroadcasts();
      _listBroadcasts = listBroadcasts;
      _broadcasts = broadcasts;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleteBroadcast in BroadcastService: $e');
      return false;
    }
  }
}
