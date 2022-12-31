import 'package:epasys_app/models/employee_model.dart';
import 'package:epasys_app/services/employee_service.dart';
import 'package:flutter/material.dart';

class EmployeeProvider with ChangeNotifier {
  List<EmployeeModel> _employees = [];
  List<EmployeeModel> _teknisi = [];
  List<EmployeeModel> _satpam = [];

  List<EmployeeModel> get employees => _employees;
  List<EmployeeModel> get teknisi => _teknisi;
  List<EmployeeModel> get satpam => _satpam;

  set employees(List<EmployeeModel> employees) {
    _employees = employees;
    notifyListeners();
  }

  set teknisi(List<EmployeeModel> teknisi) {
    _teknisi = teknisi;
    notifyListeners();
  }

  set satpam(List<EmployeeModel> satpam) {
    _satpam = _satpam;
    notifyListeners();
  }

  Future<void> getTeknisi() async {
    try {
      List<EmployeeModel> teknisi = await EmployeeService().getTeknisi();
      _teknisi = teknisi;
      notifyListeners();
    } catch (e) {
      print('Error getEmployees in EmployeeProvider: $e');
    }
  }

  Future<void> getSatpam() async {
    try {
      List<EmployeeModel> satpam = await EmployeeService().getSatpam();
      _satpam = satpam;
      notifyListeners();
    } catch (e) {
      print('Error getEmployees in EmployeeProvider: $e');
    }
  }
}
