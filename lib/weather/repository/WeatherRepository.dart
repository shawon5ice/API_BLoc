import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/WeatherModel.dart';

class WeatherRepository {
  Future<WeatherModel> getWeather(String cityName) async {
    final result = await http.Client().get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=e1470f5fa965dc0f76f66470907bff02'),);

    if (result.statusCode != 200) {
      throw Exception();
    }

    return parseJson(result.body);
  }

  WeatherModel parseJson(final response) {
    final jsonDecode = json.decode(response);

    return WeatherModel.fromJson(jsonDecode["main"]);
  }
}
