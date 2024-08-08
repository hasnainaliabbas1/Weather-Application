//import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String city = "Lahore";
  late String temp;
  late String hum;
  late String air_speed;
  late String des;
  late String main;
  late String loc;
  late String icon;
  late String sunrise;
  late String sunset;
  late String currentTime;
  late String currentDay;
  late List<String> maxtemp;
  late List<String> mintemp;
  late List<String> forecastIcons;
  late List<String> forecastDates;
  late List<String> forecastTimes;
  late List<String> forecastDescriptions;
  late double  co;
  late double  no;
  late double  no2;
  late double  o3;
  late double  so2;
  late double  nh3;



  void startApp(String city) async
  {
    worker instance  = worker(location: city);
    await instance.getData();
    // Pass latitude and longitude to getAirPollutionData
    double latitude = double.parse(instance.latitude);
    double longitude = double.parse(instance.longitude);
    await instance.getAirPollutionData(latitude, longitude);

    co = instance.co;
    no = instance.no;
    no2 = instance.no2;
    o3 = instance.o3;
    so2 = instance.so2;
    nh3 =instance.nh3;

    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    loc = instance.location;
    icon= instance.icon;
    sunrise=instance.sunrise;
    sunset=instance.sunset;
    currentTime=instance.currentTime;
    currentDay=instance.currentDay;

    await instance.getForecast();

    maxtemp = instance.maxtemp;
    mintemp = instance.mintemp;
    forecastIcons = instance.forecastIcons;
    forecastTimes = instance.forecastTimes;
    forecastDates = instance.forecastDates;
    forecastDescriptions = instance.forecastDescriptions;



    Future.delayed(Duration(seconds: 1), () {
      if (mounted){
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "air_speed_value" : air_speed,
        "des_value" : des,
        "main_value" : main,
        "loc_value" :loc,
        "icon_value":icon,
        "city_value":city,
        "sunrise_value":sunrise,
        "sunset_value":sunset,
        "currentTime_value":currentTime,
        "currentDay_value":currentDay,
        "maxtemp_values": maxtemp,
        "mintemp_values": mintemp,
        "forecastIcons_values": forecastIcons,
        "forecastTimes_values": forecastTimes,
        "forecastDates_values": forecastDates,
        "forecastDescriptions_values": forecastDescriptions,

          "co": co,
          "no":no,
          "no2": no2,
          "o3": o3,
          "so2": so2,
          "nh3": nh3,



      } );
    }
    });

  }

  @override
  void initState() {
    // TODO: implement initState



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map? search =ModalRoute.of(context)?.settings.arguments as Map?;

    if (search?.isNotEmpty ?? false){
      city=search?['searchText'];
    }
    startApp(city);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/6.png",height: 240,width: 240,),

            Text("Weather App",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),),
            SizedBox(height: 10,),
            SizedBox(height: 30,),
            SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}