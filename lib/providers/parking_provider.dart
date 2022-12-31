import 'package:epasys_app/models/parking_confirm_model.dart';
import 'package:epasys_app/models/parking_model.dart';
import 'package:epasys_app/services/parking_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ParkingProvider with ChangeNotifier {
  List<ParkingModel> _parkings = [];
  List<ParkingModel> _latestParkings = [];
  ParkingModel? _checkOut;
  ParkingConfirmModel? _confirm;
  double _countIn = 0;
  double _countOut = 0;

  List<ParkingModel> get parkings => _parkings;
  List<ParkingModel> get latestParkings => _latestParkings;
  ParkingModel get checkOut => _checkOut!;
  ParkingConfirmModel get confirm => _confirm!;
  double get countIn => _countIn;
  double get countOut => _countOut;

  set parkings(List<ParkingModel> value) {
    _parkings = value;
    notifyListeners();
  }

  set confirm(ParkingConfirmModel value) {
    _confirm = value;
    notifyListeners();
  }

  set countIn(double value) {
    _countIn = value;
    notifyListeners();
  }

  set countOut(double value) {
    _countOut = value;
    notifyListeners();
  }

  set latestParkings(List<ParkingModel> value) {
    _latestParkings = value;
    notifyListeners();
  }

  set checkOut(ParkingModel value) {
    _checkOut = value;
    notifyListeners();
  }

  Future<bool> getParking(String noParkir, String token) async {
    try {
      ParkingConfirmModel confirmmm =
          await ParkingService().getParking(noParkir, token);
      _confirm = confirmmm;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> count() async {
    try {
      double checkIn = await ParkingService().countCheckIn();
      double checkOut = await ParkingService().countCheckOut();
      _countIn = checkIn;
      _countOut = checkOut;
      notifyListeners();
    } catch (e) {
      print('count $e');
    }
  }

  Future<bool> getLatestParkings(String token) async {
    try {
      List<ParkingModel> latestParkings =
          await ParkingService().getLatestParkings(token);
      _latestParkings = latestParkings;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getParkingsToday() async {
    try {
      List<ParkingModel> parkings = await ParkingService().getParkingsToday();
      _parkings = parkings;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> checkInAndOut(String noParkir, String status, int helm,
  //     int idKendaraan, int idUser, String token) async {
  //   try {
  //     await ParkingService()
  //         .checkOut(noParkir, status, helm, idKendaraan, idUser, token);
  //     List<ParkingModel> parkings = await ParkingService().getParkings(token);
  //     List<ParkingModel> latestParkings =
  //         await ParkingService().getLatestParkings(token);
  //     var checkOut = await ParkingService().getCheckOut(token);
  //     _parkings = parkings;
  //     _latestParkings = latestParkings;
  //     _checkOut = checkOut;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print('Error checkInAndOut in ParkingProvider: $e');
  //     return false;
  //   }
  // }

  Future<bool> getCheckOut(String token) async {
    try {
      var checkOut = await ParkingService().getCheckOut(token);
      if (checkOut == null) return false;
      _checkOut = checkOut;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error getCheckOut in ParkingProvider: $e');
      return false;
    }
  }

  Future<bool> confirmParking(String noParkir, String token) async {
    try {
      http.StreamedResponse confirmP =
          await ParkingService().confirmParking(noParkir, token);
      if (confirmP.statusCode == 200) {
        ParkingConfirmModel confirmP =
            await ParkingService().getParking(noParkir, token);
        double checkIn = await ParkingService().countCheckIn();
        double checkOut = await ParkingService().countCheckOut();
        _countIn = checkIn;
        _countOut = checkOut;
        _confirm = confirmP;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error confirmParking in ParkingProvider: $e');
      return false;
    }
  }
}
