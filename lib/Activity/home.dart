import 'dart:math';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>  with TickerProviderStateMixin {
  TextEditingController searchcontroller =new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }
  @override
  Widget build(BuildContext context) {

    var cityname=["Lahore","Islamabad","London","karachi","Multan"];
    final random=new Random();
   var city=cityname[random.nextInt(cityname.length-1)];
    Map? info= ModalRoute.of(context)?.settings.arguments as Map?;
    String tempValue = info?['temp_value']?.toString() ?? '';
    int count = tempValue.length;
    String temp = count >= 5 ? tempValue.substring(0, 5) : tempValue;

    //String temp= ((info?['temp_value']).toString()).substring(0,5);
    String icon = info?['icon_value'];
    String getcity1 = info?['city_value'];
    String hum = info?['hum_value'];
    String air = (info?['air_speed_value']?.toString() ?? '').substring(0, min(info?['air_speed_value']?.toString().length ?? 0, 4));
    // String air = ((info?['air_speed_value']).toString()).substring(0,4);
    String des = info?['des_value'];

    String sunriseTime = info?['sunrise_value'] ?? '';
    DateTime sunriseDateTime;

    if (sunriseTime.isNotEmpty) {
      List<String> parts = sunriseTime.split(' ');
      List<String> timeParts = parts[0].split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);

      // Convert the time to a 24-hour format
      if (parts[1] == 'PM') {
        hours += 12;
      }

      // Create a DateTime object for today with the parsed time
      sunriseDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes);
    } else {
      // Default value if sunrise data is not available
      sunriseDateTime = DateTime.now();
    }
    String formattedSunrise = DateFormat.jm().format(sunriseDateTime);



    String sunsetTime = info?['sunset_value']?.toString() ?? '';
    DateTime sunsetDateTime;
    if (sunsetTime.isNotEmpty) {
      List<String> parts = sunsetTime.split(' ');
      List<String> timeParts = parts[0].split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);

      // Convert the time to a 24-hour format
      if (parts[1] == 'PM') {
        hours += 12;
      }

      // Create a DateTime object for today with the parsed time
      sunsetDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes);
    } else {
      // Default value if sunrise data is not available
      sunsetDateTime = DateTime.now();
    }
    String formattedSunset = DateFormat.jm().format(sunsetDateTime);

    DateTime now = DateTime.now();
    String currentTime = DateFormat.jm().format(now);
    String currentDay = DateFormat('EEEE').format(now);


    //forecast
    // Extracting forecast data
    List<String>? maxtempValues = info?['maxtemp_values'] as List<String>?;
    List<String>? mintempValues = info?['mintemp_values'] as List<String>?;
    List<String>? forecastIcons = info?['forecastIcons_values'] as List<String>?;
    List<String>? forecastDates = info?['forecastDates_values'] as List<String>?;
    List<String>? forecastTimes = info?['forecastTimes_values'] as List<String>?;
    List<String>? forecastDescriptions = info?['forecastDescriptions_values'] as List<String>?;

    String co = info?['co']?.toString().substring(0,6) ?? '';
    String no = info?['no']?.toString() ?? '';
    String no2 = info?['no2']?.toString() ?? '';
    String so2 = info?['so2']?.toString() ?? '';
    String o3 = info?['o3']?.toString() ?? '';
    String nh3 = info?['nh3']?.toString() ?? '';


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),

    body:SingleChildScrollView(
     child:SafeArea(
      child:Container(

          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                colors: [
                  Colors.blue.shade700,
                  Colors.blue.shade300,
                ],)),
          child: Column(
            children: [
              Container(
                //Search Container

                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                       Navigator.pushReplacementNamed(context, "/loading",arguments: {"searchText":searchcontroller.text,});
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search $city"),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(26),
                        child: Row(children: [
                          Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                          SizedBox(width: 13,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$des",style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " In $getcity1",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ]
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.4)),
                      margin:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                            Text("$temp",style: TextStyle(fontSize: 85),),
                            Text("\u2103",style: TextStyle(fontSize: 30)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(28,0,0,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                Text("$currentTime", style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600),),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(19,0,0,0),
                                  child: Text("$currentDay", style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600)),
                                ),
                                 ]
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.4)),
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.day_cloudy_windy),
                            ],
                          ),
                          SizedBox(height: 30,)
                          ,
                          Text("$air",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("km/hr")
                        ],
                      ),
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.4)),
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child:  Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity)
                            ],
                          ),
                          SizedBox(height: 30,)
                          ,
                          Text("$hum",style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Percent")
                        ],
                      ),
                    ),
                  ),
                ],
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.4)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.sunrise),
                              ],
                            ),
                            SizedBox(height: 30,)
                            ,
                            Text("$formattedSunrise",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),),

                          ],
                        ),
                        height: 150,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.4)),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(26),
                        height: 150,
                        child:  Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.sunset)
                              ],
                            ),
                            SizedBox(height: 30,)
                            ,
                            Text("$formattedSunset",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display 5-day forecast header
                          Text(
                            "3 Hour Forecast Of Five Days",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          // Display forecast data
                          Container(
                            height: 150, // Adjust the height as needed

                            child: ListView(
                              scrollDirection: Axis.horizontal, // Scroll horizontally
                              children: [
                                // Display forecast data
                                if (forecastDates != null &&
                                    forecastTimes != null &&
                                    maxtempValues != null &&
                                    forecastIcons != null)
                                  for (int i = 0; i < min(40, forecastDates.length); i++) // Display data for 5 days
                                    Container(

                                      width: 190, // Adjust the width as needed
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black38),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 20), // Add margin between containers
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                "https://openweathermap.org/img/wn/${forecastIcons[i]}@2x.png",
                                                width: 50,
                                                height: 50,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(5,0,0,0),
                                                child: Text(
                                                  "${forecastDescriptions?[i]}",
                                                ),
                                              ),
                                            ],

                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "${forecastDates[i]} - ${forecastTimes[i]}",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Max Temp: ${maxtempValues[i]}\u2103",
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Min Temp: ${mintempValues?[i]}\u2103",
                                          ),
                                        ],
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                             // Adjust the space between the image and text
                              Text(
                                "Air Pollution Data",
                                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                      SizedBox(width: 10),
                              Image.asset(
                                "images/air-pollution.png", // Provide the path to your image asset
                                width: 30, // Adjust the width as needed
                                height: 30, // Adjust the height as needed
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54), // Change the color here
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DataTable(
                              border: TableBorder.symmetric(
                                inside: BorderSide(color: Colors.black54), // Horizontal and vertical borders
                                //outside: BorderSide(color: Colors.black), // Outer borders
                              ),
                              columns: [
                                DataColumn(label: Text('Pollutant',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Value',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('CO',)),
                                  DataCell(Text(co)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('NO')),
                                  DataCell(Text(no)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('NO2')),
                                  DataCell(Text(no2)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('O3')),
                                  DataCell(Text(o3)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('SO2')),
                                  DataCell(Text(so2)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('NH3',)),
                                  DataCell(Text(nh3)),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),



              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Made By Hasnain Ali Abbas"),
                    Text("Data Provided By Openweathermap.org")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )
    );
  }
}