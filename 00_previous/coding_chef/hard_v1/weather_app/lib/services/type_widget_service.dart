import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeWidgetService {
  Widget getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        "assets/svg/climacon-cloud_lightning.svg",
        color: Colors.black87,
      );
    } else if (condition < 600) {
      return SvgPicture.asset(
        "assets/svg/climacon-cloud_snow_alt.svg",
        color: Colors.black87,
      );
    } else if (condition == 800) {
      return SvgPicture.asset(
        "assets/svg/climacon-sun.svg",
        color: Colors.black87,
      );
      // } else if (condition <= 804) {
    } else {
      return SvgPicture.asset(
        "assets/svg/climacon-cloud_sun.svg",
        color: Colors.black87,
      );
    }
  }

  Widget getAirIcon(int index) {
    if (index == 1) {
      return Image.asset(
        "assets/image/good.png",
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        "assets/image/fair.png",
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        "assets/image/moderate.png",
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        "assets/image/poor.png",
        width: 37.0,
        height: 35.0,
      );
    } else {
      return Image.asset(
        "assets/image/bad.png",
        width: 37.0,
        height: 35.0,
      );
    }
  }

  Widget getAirCondition(int index) {
    if (index == 1) {
      return Text(
        "매우좋음",
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 2) {
      return Text(
        "좋음",
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 2) {
      return Text(
        "보통",
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 2) {
      return Text(
        "나쁨",
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "매우나쁨",
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );    }
  }


}
