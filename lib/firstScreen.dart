import 'package:flutter/material.dart';
import 'package:weather_app/location.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/weather_result.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/images/sun.png", height: 350.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 55.0),
            child: Text(
              'Discover the weather in your city',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'poppins bold',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            child: Text(
              'Get to know your weather maps and redar precipitation forccast',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'poppins Regular',
                color: Colors.blueGrey,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          GestureDetector(
            onTap: () async {
              try {
                Location location = Location();
                await location.getCurrentLocation();

                print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');

                if (location.latitude != null && location.longitude != null) {
                  var weatherData = await WeatherModal().getLocationWeather(
                    latitude: location.latitude!,
                    longitude: location.longitude!,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherResultScreen(LocationWeather: weatherData),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to get location.")),
                  );
                }
              } catch (e) {
                print("Error: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: $e")),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              padding: EdgeInsets.only(top: 18),
              height: 58.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Get weather',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'poppins Reguler',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
