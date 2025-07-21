import 'package:flutter/material.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/weather_result.dart';

class Cityscreen extends StatefulWidget {
  @override
  _CityscreenState createState() => _CityscreenState();
}

class _CityscreenState extends State<Cityscreen> {
  String? cityName;
  WeatherModal weatherModal = WeatherModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                cityName = value;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter city name',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (cityName != null && cityName!.isNotEmpty) {
                  try {
                    var weatherData =
                        await weatherModal.getCityWeather(cityName!);

                    if (weatherData['cod'] == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherResultScreen(
                            LocationWeather: weatherData,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("City not found.")),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error fetching weather.")),
                    );
                    print("Error: $e");
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a city name")),
                  );
                }
              },
              child: Text('Get Weather'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
