import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class worker
{

  String location;

  //Constructor

  worker({required this.location})
  {
    location = this.location;
  }


  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;
  late String sunrise;
  late String sunset;
   late String currentTime;
   late String currentDay;



  late List<String> maxtemp;
  late List<String> mintemp;
  late List<String> forecastIcons;
  late List<String> forecastTimes;
  late List<String> forecastDates;
  late List<String> forecastDescriptions;


  late double co;
  late double no;
  late double no2;
  late double o3;
  late double so2;
  late double nh3;
  late String latitude;
  late String longitude;

  //method
  Future<void> getData() async {
    try {
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=8be7aec30c0629b145fa14549f6c56e9'));
      Map data = jsonDecode(response.body);
      //print(data);

      // Store latitude and longitude
      latitude = data['coord']['lat'].toString();
      longitude = data['coord']['lon'].toString();

      //await getAirPollutionData(data['coord']['lat'].toDouble(), data['coord']['lon'].toDouble());

      // Getting Temp, Humidity
      Map tempData = data['main'];
      String getHumidity = tempData['humidity'].toString();
      double getTemp = tempData['temp'] - 273.15;

      // Getting air_speed
      Map wind = data['wind'];
      double getAirSpeed = wind["speed"] / 0.27777777777778;

      // Getting Description
      List weatherData = data['weather'];
      Map weatherMainData = weatherData[0];
      String getMainDes = weatherMainData['main'];
      String getDesc = weatherMainData["description"];
      icon = weatherMainData["icon"].toString();

      // Getting Sunrise
      Map sys = data['sys'];
      int sunriseTimestamp = sys['sunrise'];
      DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
      String formattedSunrise = DateFormat.jm().format(sunriseTime);

      int sunsetTimestamp = sys['sunset'];
      DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);
      String formattedSunset = DateFormat.jm().format(sunsetTime);

      // Assigning Values
      temp = getTemp.toString(); // C
      humidity = getHumidity; // %
      air_speed = getAirSpeed.toString(); // km/hr
      description = getDesc;
      main = getMainDes;
      sunrise = formattedSunrise;
      sunset=formattedSunset;

       DateTime now = DateTime.now();
       currentTime = DateFormat.jm().format(now); // Format: 5:28 PM
      currentDay = DateFormat('EEEE').format(now); // Format: Monday

    }
    catch (e) {
      print(e);
      temp = "Can't Find Data";
      humidity = "Can't Find Data";
      air_speed = "Can't Find Data";
      description = "Can't Find Data";
      main = "Can't Find Data";
      icon = "03n";
      sunrise = "Can't Find Data";
      sunset="Can't Find Data";
      currentTime = "Can't Find Data";
      currentDay = "Can't Find Data";

    }
  }

  Future<void> getForecast() async {
    try {
      Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$location&cnt=40&appid=8be7aec30c0629b145fa14549f6c56e9'));
      Map data = jsonDecode(response.body);
     // print(data);

      // Extract forecast data
      List<dynamic> forecastData = data['list'];

      maxtemp = [];
      mintemp = [];
      forecastIcons = [];
      forecastDescriptions = [];
      forecastTimes = [];
      forecastDates = [];

      for (int i = 0; i < forecastData.length; i++) {
        Map<String, dynamic> forecast = forecastData[i];
        int timestamp = forecast['dt'] != null ? forecast['dt'] * 1000 : 0; // Convert seconds to milliseconds
        DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

        // Extracting 3-hourly forecast data
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        String formattedTime = DateFormat('HH:mm').format(date);
        forecastDates.add(formattedDate);
        forecastTimes.add(formattedTime);

        Map<String, dynamic> main = forecast['main'];
        double maxTemp = main['temp_max'] != null ? (main['temp_max'] - 273.15) : 0;
        double minTemp = main['temp_min'] != null ? (main['temp_min'] - 273.15) : 0;
        maxtemp.add(maxTemp.toStringAsFixed(1));
        mintemp.add(minTemp.toStringAsFixed(1));

        List<dynamic> weather = forecast['weather'];
        forecastIcons.add(weather[0]['icon']);
        forecastDescriptions.add(weather[0]['description']);
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
      // Handle error
    }
  }

  Future<void> getAirPollutionData(double latitude, double longitude) async {
    try {
      Response response = await get(Uri.parse('http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=8be7aec30c0629b145fa14549f6c56e9'));
      Map data1 = jsonDecode(response.body);
      print(data1);

      // Extract air pollution data
      Map<String, dynamic> list = data1['list'][0];
      Map<String, dynamic> components = list['components'];

      // Assigning Values

       co = (components['co'] != null) ? (components['co'] as num).toDouble() : 0;
       no = (components['no'] != null) ? (components['no'] as num).toDouble() : 0;
       no2 = (components['no2'] != null) ? (components['no2'] as num).toDouble() : 0;
       o3 = (components['o3'] != null) ? (components['o3'] as num).toDouble() : 0;
       so2 = (components['so2'] != null) ? (components['so2'] as num).toDouble() : 0;
       nh3 = (components['nh3'] != null) ? (components['nh3'] as num).toDouble() : 0;

    } catch (e) {
      print('Error fetching air pollution data: $e');
      // Handle error
    }
  }



}


