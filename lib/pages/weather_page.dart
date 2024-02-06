import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/service/weather_service.dart';

import '../model/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("5aeba5aa85da37a7e47f31dc5cb8784d");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json";
    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/clouddy.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rainny.json";
      case "thunderstorm":
        return "assets/thunter.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city...",
                style: TextStyle(fontSize: 40, color: Colors.blue[100])),
            Text("${_weather?.temperature.round()}ºC",
                style: TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(fontSize: 20, color: Colors.blue[100]),
            ),
          ],
        ),
      ),
    );
  }
}
