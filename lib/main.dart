import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/components/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: "Weather app",
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = TextEditingController();

  var temp;
  var humidity;
  var country;
  var name;
  var weather;
  String cityname;

  Future getWeather(String city) async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=052bce77b7c8fb236808449fce6a5be8");
    var result = jsonDecode(response.body);

    setState(() {
      this.name = result['name'];
      this.country = result['sys']['country'];
      this.temp = result['main']['temp'];
      this.humidity = result['main']['humidity'];
      this.weather = result['weather'][0]['main'];
    });
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondaryColor),
                width: size.width / 1.20,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: cityController,
                          decoration: InputDecoration(
                            hintText: "Enter a city",
                            hintStyle: TextStyle(color: primaryColor),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        cityname = cityController.text;
                        getWeather(cityname);
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text(
                cityname != null ? cityname : '-',
                style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                temp != null ? (temp - 273).toStringAsFixed(2) + "°C" : '-',
                style: TextStyle(color: secondaryColor, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                weather != null ? weather.toString() : '-',
                style: TextStyle(color: secondaryColor, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Text(name != null ? name.toString() : "Enter a city"),
//           Text(humidity != null ? humidity.toString() : null),
//           Text(temp != null ? temp.toString() : null)
