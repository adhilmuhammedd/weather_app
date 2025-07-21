import 'location.dart';
import 'networking.dart';

const apiKey = 'ffb344d524f47e597e98b99877440579';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModal {
  // Get weather using latitude and longitude
  Future<dynamic> getLocationWeather({
    required double latitude,
    required double longitude,
  }) async {
    Networking networkBrain = Networking(
      '$openWeatherMapUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
    );
    var weatherData = await networkBrain.getData();
    return weatherData;
  }

  // ✅ NEW: Get weather by city name
  Future<dynamic> getCityWeather(String cityName) async {
    Networking networkBrain = Networking(
      '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric',
    );
    var weatherData = await networkBrain.getData();
    return weatherData;
  }

  String getWeatherIcon(int weatherConditionCode) {
  if (weatherConditionCode < 300) {
    return '🌩'; // Thunderstorm
  } else if (weatherConditionCode < 400) {
    return '🌧'; // Drizzle
  } else if (weatherConditionCode < 600) {
    return '☔️'; // Rain
  } else if (weatherConditionCode < 700) {
    return '☃️'; // Snow
  } else if (weatherConditionCode < 800) {
    return '🌫'; // Atmosphere (mist, smoke, etc.)
  } else if (weatherConditionCode == 800) {
    return '☀️'; // Clear
  } else if (weatherConditionCode <= 804) {
    return '☁️'; // Clouds
  } else {
    return '❓'; // Unknown
  }
}


  String getMassage(int temperature) {
    if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for short and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧤 and 🧣';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
