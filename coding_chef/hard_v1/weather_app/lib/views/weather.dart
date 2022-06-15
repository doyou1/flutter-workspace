import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weather_app/services/type_widget_service.dart';
import 'package:weather_app/vo/AirVO.dart';
import 'package:weather_app/vo/WeatherVO.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Weather extends StatefulWidget {
  final WeatherVO weatherVO;
  final AirVO airVO;

  const Weather({Key? key, required this.weatherVO, required this.airVO})
      : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String stateName = "State Name";
  int temp = 0;
  String description = "";
  Widget weatherTypeIcon = SvgPicture.asset(
    "assets/svg/cloud_lightning-sun.svg",
    color: Colors.black87,
  );
  Widget airIcon = Image.asset(
    "assets/image/good.png",
    width: 37.0,
    height: 35.0,
  );
  Widget airCondition = Text("매우좋음",
      style: GoogleFonts.lato(
        fontSize: 14.0,
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
      ));
  double fineDust = 0.0;
  double ultraFineDust = 0.0;

  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.airVO.index);
    updateWeatherData(widget.weatherVO);
    updateAirData(widget.airVO);
  }

  void updateWeatherData(WeatherVO weatherVO) {
    var condition = weatherVO.condition;

    this.stateName = weatherVO.stateName;
    this.temp = weatherVO.temp.toInt();
    this.description = weatherVO.description;
    TypeWidgetService typeWidgetService = TypeWidgetService();
    this.weatherTypeIcon = typeWidgetService.getWeatherIcon(condition);
  }

  void updateAirData(AirVO airVO) {
    TypeWidgetService typeWidgetService = TypeWidgetService();
    this.airCondition = typeWidgetService.getAirCondition(airVO.index);
    this.airIcon = typeWidgetService.getAirIcon(airVO.index);
    this.fineDust = airVO.fineDust;
    this.ultraFineDust = airVO.ultraFineDust;
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: Text(" "),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.location_searching,
            ),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              "assets/image/background.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            Text(
                              stateName,
                              style: GoogleFonts.lato(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                    const Duration(minutes: 1),
                                    builder: (context) {
                                  print("${getSystemTime()}");
                                  return Text(
                                    getSystemTime(),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white),
                                  );
                                }),
                                Text(
                                  DateFormat(" / EEEE").format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                Text(
                                  DateFormat(" / yyy MMM d").format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$temp\u2103",
                              style: GoogleFonts.lato(
                                fontSize: 85.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                weatherTypeIcon,
                                Text(
                                  description,
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 12.0,
                    thickness: 2.0,
                    color: Colors.white30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "AQI(대기질지수)",
                            style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          airIcon,
                          SizedBox(
                            height: 10.0,
                          ),
                          airCondition,
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "미세먼지",
                            style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            fineDust.toString(),
                            style: GoogleFonts.lato(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "㎍/m3",
                            style: GoogleFonts.lato(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "초미세먼지",
                            style: GoogleFonts.lato(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            ultraFineDust.toString(),
                            style: GoogleFonts.lato(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '㎍/m3',
                            style: GoogleFonts.lato(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
