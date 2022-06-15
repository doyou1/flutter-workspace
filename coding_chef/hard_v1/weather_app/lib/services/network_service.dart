import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/vo/AirVO.dart';
import 'package:weather_app/vo/WeatherVO.dart';

class NetworkService {
  final String weatherUrl;
  final String airUrl;
  NetworkService(this.weatherUrl, this.airUrl);

  Future<WeatherVO?> getWeatherData() async {
    Response response = await get(Uri.parse(weatherUrl));

    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsedData = jsonDecode(jsonData);
      var id = parsedData["id"];
      var description = parsedData["weather"][0]["description"];
      var windSpeed = parsedData["wind"]["speed"];
      var country = parsedData["sys"]["country"];
      var stateName = parsedData["name"];
      var temp = parsedData["main"]["temp"];
      var condition = parsedData["weather"][0]["id"];

      WeatherVO weatherVO = WeatherVO(id, description, windSpeed, country, stateName, temp, condition);

      return weatherVO;
    } else {
      print("response error: ${response.statusCode}");
    }
  }

  Future<AirVO?> getAirData() async {
    Response response = await get(Uri.parse(airUrl));

    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsedData = jsonDecode(jsonData);
      // api 지수
      int index = parsedData["list"][0]["main"]["aqi"];
      // 미세먼지 지수
      double fineDust = parsedData["list"][0]["components"]["pm10"];
      double ultraFineDust = parsedData["list"][0]["components"]["pm2_5"];

      return AirVO(index, fineDust, ultraFineDust);
    }
  }
}


