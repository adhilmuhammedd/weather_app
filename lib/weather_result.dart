import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/cityScreen.dart';
import 'package:weather_app/location.dart';
import 'weather.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Poppins Bold',
  fontSize: 80.0,
  color: Colors.white,
);

const KMassageTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 22.0,
  color: Colors.white,
);

class WeatherResultScreen extends StatefulWidget {
  WeatherResultScreen({this.LocationWeather});
  final dynamic LocationWeather;

  @override
  State<WeatherResultScreen> createState() => _WeatherResultScreenState();
}

class _WeatherResultScreenState extends State<WeatherResultScreen> {
  WeatherModal weatherModal = WeatherModal();
  var temprature;
  var weatherConditaion;
  var cityName;
  var weatherConditaionCode;
  var weatherIcon;
  var weatherMassage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.LocationWeather);
  }

  void updateUI(dynamic Weatherdata) {
    setState(() {
      if (Weatherdata == null) {
        temprature = 0;
        weatherMassage = 'Unable to get data from server';
        cityName = 'An error occurred';
        weatherIcon = '';
        return;
      }
      cityName = Weatherdata['name'];
      weatherConditaion = Weatherdata['weather'][0]['main'];
      double temp = Weatherdata['main']['temp'];
      temprature = temp.toInt();
      weatherConditaionCode = Weatherdata['weather'][0]['id'];
      weatherIcon = weatherModal.getWeatherIcon(weatherConditaionCode);
      weatherMassage = weatherModal.getMassage(temprature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        Location location = Location();
                        await location.getCurrentLocation();

                        if (location.latitude != null &&
                            location.longitude != null) {
                          var WeatherData =
                              await weatherModal.getLocationWeather(
                            latitude: location.latitude!,
                            longitude: location.longitude!,
                          );
                          updateUI(WeatherData);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Location not available.")),
                          );
                        }
                      } catch (e) {
                        print("Error: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error getting location.")),
                        );
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFF0B0D1E),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        FontAwesomeIcons.locationArrow,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                child: Text(
                  'Today\'s Report',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontFamily: 'Poppins Bold',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        weatherIcon ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 225.0,
                        ),
                      ),
                    ),
                    Text(
                      'It\'s $weatherConditaion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Poppins Bold',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$temprature°',
                      textAlign: TextAlign.center,
                      style: kTempTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                height: 95.0,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF0B0D1E),
                ),
                child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Text(
                    "$weatherMassage in $cityName!",
                    textAlign: TextAlign.center,
                    style: KMassageTextStyle,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Cityscreen();
                    }));
                  },
                  child: Icon(FontAwesomeIcons.magnifyingGlass),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
