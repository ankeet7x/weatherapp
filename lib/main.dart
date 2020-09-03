import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  var temp;
  var humidity;
  var country;
  var name;
  var weather;

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
    this.getWeather("Pokhara");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(weather != null ? weather.toString() : "Loading"),
    ));
  }
}
