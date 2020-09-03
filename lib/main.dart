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
  void initState() {
    super.initState();
    // this.getWeather(cityname);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.04,
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
                    icon: Icon(Icons.search),
                    onPressed: () {
                      cityname = cityController.text;
                      getWeather(cityname);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Text(name != null ? name.toString() : "Enter a city"),
//           Text(humidity != null ? humidity.toString() : null),
//           Text(temp != null ? temp.toString() : null)
