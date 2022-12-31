import 'dart:convert';
import 'dart:io';
import 'package:epasys_app/models/employee_model.dart';
import 'package:epasys_app/shared/config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<EmployeeModel> register(
      String nama,
      String email,
      String deskripsi,
      String alamat,
      String noHp,
      String password,
      String passwordConfirm) async {
    try {
      var url = '${SharedConfig().url}/register-employee';
      var body = jsonEncode({
        'nama': nama,
        'deskripsi': deskripsi,
        'email': email,
        'no_telepon': noHp,
        'alamat': alamat,
        'password': password,
        'password_confirmation': passwordConfirm,
      });

      var response = await http.post(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json',
        'Redirect': 'follow',
      });
      print(response.body);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body)['data'];
        EmployeeModel user = EmployeeModel.fromJson(data['user']);
        user.token = 'Bearer ${data['token']}';
        return user;
      } else {
        throw Exception(
            '${response.statusCode} Failed to register account: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to register account: $e');
    }
  }

  Future<EmployeeModel> login(String email, String password) async {
    try {
      var url = '${SharedConfig().url}/login-employee';
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        'email': email,
        'password': password,
      });

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      var data = jsonDecode(response.body)['data'];
      EmployeeModel user = EmployeeModel.fromJson(data['employee']);
      user.token = 'Bearer ${data['token']}';
      return user;
    } catch (e) {
      throw Exception('Failed to login account: $e');
    }
  }

  Future<bool> logout(String token) async {
    var url = '${SharedConfig().url}/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<EmployeeModel> updateAvatar(File? image, String token) async {
    String url = '${SharedConfig().url}/employees/photo';
    var headers = {
      'Authorization': token,
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('avatar', image.path));
    }

    request.headers.addAll(headers);

    var response = await request.send().then(
          (result) => http.Response.fromStream(result).then(
            (response) {
              if (response.statusCode == 200) {
                // print({"asdads", user});
                return response;
              } else {
                // print("Error during connection to server");
                print(response.body);
              }
            },
          ),
        );

    var data = jsonDecode(response!.body)['data'];
    EmployeeModel user = EmployeeModel.fromJson(data);
    return user;
  }

  Future<EmployeeModel> getCurrentUser(String token) async {
    String url = '${SharedConfig().url}/employees/auth';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      EmployeeModel user = EmployeeModel.fromJson(data);
      return user;
    } else {
      throw 'Error getCurrent User in AuthService: Gagal mendapatkan data user';
    }
  }

  Future<bool> activateUser(String token) async {
    String url = '${SharedConfig().url}/employees/auth/active';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Error activateEmployee in EmployeeService';
    }
  }

  Future<bool> deactivateUser(String token) async {
    String url = '${SharedConfig().url}/employees/auth/deactive';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Error deactivateEmployee in EmployeeService';
    }
  }

  Future<EmployeeModel> updateProfile(
    String nama,
    String deskripsi,
    String alamat,
    String email,
    String noHp,
    String token,
  ) async {
    String url = '${SharedConfig().url}/employees/update';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);

    if (nama != '') {
      request.fields['nama'] = nama;
    }
    if (deskripsi != '') {
      request.fields['deskripsi'] = deskripsi;
    }
    if (alamat != '') {
      request.fields['alamat'] = alamat;
    }
    if (noHp != '') {
      request.fields['no_telepon'] = noHp;
    }
    if (email != '') {
      request.fields['email'] = email;
    }

    var response = await request.send().then(
          (result) => http.Response.fromStream(result).then(
            (response) {
              if (response.statusCode == 200) {
                // print({"asdads", user});
                return response;
              } else {
                // print("Error during connection to server");
                print(response.body);
              }
            },
          ),
        );

    var data = jsonDecode(response!.body)['data'];
    EmployeeModel user = EmployeeModel.fromJson(data);
    return user;
  }

  Future<bool> changePasswordUser(
      String password, String confirmPassword, String token) async {
    String url = '${SharedConfig().url}/employees/update/password';
    var headers = {
      'Authorization': token,
    };
    var body = {
      'password': password,
      'password_confirmation': confirmPassword,
    };

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
