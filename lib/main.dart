import 'package:flutter/material.dart';
import 'package:weather_app/firstScreen.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _weatherAppState();
}

class _weatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Firstscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}