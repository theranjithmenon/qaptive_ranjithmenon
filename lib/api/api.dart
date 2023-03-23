import 'dart:convert';
import 'package:http/http.dart';


class ApiConnection {
  String url =
      'http://api.openweathermap.org/data/2.5/weather?lat=10.019670730071525&lon=76.3421626530782&APPID=21d6e175e99da7893408f2c0d5f60fdc';
  Future getData() async {
    var response = await get(Uri.parse(url));
    final weatherData = jsonDecode(response.body);
    return weatherData;
  }
}
