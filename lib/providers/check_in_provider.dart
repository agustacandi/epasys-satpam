import 'package:epasys_app/shared/theme.dart';
import 'package:flutter/foundation.dart';

class CheckInProvider with ChangeNotifier {
  int _helm = 1;
  int _idKendaraan = 1;
  int _index = 0;
  int _position = 0;

  int get helm => _helm;
  int get idKendaraan => _idKendaraan;
  int get position => _position;
  int get index => _index;

  get isActive => (_position - 1) == _index ? blueColor2 : greyColor2;
  get activeColor => isActive ? blueColor2 : greyColor2;

  set helm(int value) {
    _helm = value;
    notifyListeners();
  }

  set idKendaraan(int value) {
    _idKendaraan = value;
    notifyListeners();
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  set position(int value) {
    _position = value;
    notifyListeners();
  }
}
