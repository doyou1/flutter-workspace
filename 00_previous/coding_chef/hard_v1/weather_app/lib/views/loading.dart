import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/network_service.dart';
import 'package:weather_app/views/weather.dart';
import 'package:weather_app/vo/AirVO.dart';
import 'package:weather_app/vo/PositionVO.dart';

import '../vo/WeatherVO.dart';

const appKey = "f6ad9850478e267b8aca56dacceb2546";

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToWeatherScreen();
  }

  void goToWeatherScreen() async {
    LocationService locationService = LocationService();
    // 현재 위치 정보 획득
    PositionVO positionVO = await locationService.getCurrentPosition();

    String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=${positionVO.latitude}&lon=${positionVO.longitude}&appid=$appKey&units=metric";
    String airUrl =
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=${positionVO.latitude}&lon=${positionVO.longitude}&appid=$appKey&units=metric";

    NetworkService networkService = NetworkService(weatherUrl, airUrl);

    // 현재 날씨 정보 획득
    WeatherVO? weatherVO = await networkService.getWeatherData();
    AirVO? airVO = await networkService.getAirData();

    if (weatherVO != null && airVO != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Weather(weatherVO: weatherVO, airVO: airVO);
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Weather Service not working",
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
