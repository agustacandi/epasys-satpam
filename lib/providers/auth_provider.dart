import 'dart:io';

import 'package:epasys_app/models/employee_model.dart';
import 'package:epasys_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  EmployeeModel? _user;

  EmployeeModel get user => _user!;

  set user(EmployeeModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(
      String nama,
      String deskripsi,
      String email,
      String alamat,
      String noHp,
      String password,
      String passwordConfirm) async {
    try {
      EmployeeModel user = await AuthService().register(
          nama, email, deskripsi, alamat, noHp, password, passwordConfirm);

      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error in register provider: $e');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      EmployeeModel user = await AuthService().login(email, password);

      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateAvatar(File? image, String token) async {
    try {
      EmployeeModel user = await AuthService().updateAvatar(image!, token);
      _user!.avatar = user.avatar;
      notifyListeners();
      return true;
    } catch (e) {
      print('errornya di updateAvatar provider: $e');
      return false;
    }
  }

  Future<void> getCurrentUser(String token) async {
    try {
      EmployeeModel user = await AuthService().getCurrentUser(token);
      _user = user;
      _user!.token = token;
      notifyListeners();
    } catch (e) {
      print('Error getCurrentUser in AuthProvider : $e');
    }
  }

  Future<bool> activateEmployee(String token) async {
    bool success = await AuthService().activateUser(token);
    if (success) {
      EmployeeModel user = await AuthService().getCurrentUser(token);
      _user = user;
      _user!.token = token;
      notifyListeners();
      return true;
    } else {
      print('Error getCurrentUser in AuthProvider');
      return false;
    }
  }

  Future<bool> deactivateEmployee(String token) async {
    bool success = await AuthService().deactivateUser(token);
    if (success) {
      EmployeeModel user = await AuthService().getCurrentUser(token);
      _user = user;
      _user!.token = token;
      notifyListeners();
      return true;
    } else {
      print('Error getCurrentUser in AuthProvider');
      return false;
    }
  }

  Future<bool> updateProfile(
    String nama,
    String deskripsi,
    String alamat,
    String email,
    String noHp,
    String token,
  ) async {
    try {
      EmployeeModel user = await AuthService()
          .updateProfile(nama, deskripsi, alamat, email, noHp, token);

      _user = user;
      _user!.token = token;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updateProfile in AuthProvider : $e');
      return false;
    }
  }
}
