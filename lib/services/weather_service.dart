import 'package:http/http.dart' as http;

class WeatherService {
  // cef19bd30d904023a4d163735222512
  // c8d88d5c29dbe757488825bfbf80832a
  Future<void> getCurrentWeather() async {
    var url =
        'https://api.weatherapi.com/v1/current.json?key=cef19bd30d904023a4d163735222512&q=Bondowoso&lang=jv';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('Failed to get current weather');
    }
  }
}
