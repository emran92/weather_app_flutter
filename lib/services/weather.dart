import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima/services/Forecast.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

import 'Forecast.dart';

const apiKey = 'f6af080ab1a9df7e540abe969253c86b';
const openWeatherMapUrl= 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  WeatherModel({this.text});
  String text;

  Future<dynamic> getForecast(text) async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?q=$text&units=metric&appid=$apiKey');
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final forecast =
      (data['list'] as List).map((i) => new Forcast.fromJson(i));

      return forecast.toList();
    } else {
      return [];
    }
  }

  Future<List<Forcast>> getWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var data = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&cnt=9&units=metric');

    Map jsonData = json.decode(data.body);
    //print(jsonData);

    final forecast =
    (jsonData['list'] as List).map((i) => new Forcast.fromJson(i));

    return forecast.toList();
  }

  Future<dynamic> getForeCastWeather() async{

    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&cnt=9&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }



  Future<dynamic> getCityWeather(String cityName) async{

    var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;

  }

  Future<dynamic> getLocationWeather() async{

    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String setImage(int condition) {
    String _backgroundImage;

    if (condition < 300) {
      _backgroundImage = "images/night_rain.png";
    } else if (condition < 400) {
      _backgroundImage = "images/night_rain.png";
    } else if (condition < 600) {
      _backgroundImage = "images/night_rain.png";
    } else if (condition < 700) {
      _backgroundImage = "images/night_snow.png";
    } else if (condition < 800) {
      _backgroundImage = "images/night_clearsky.png";
    } else if (condition == 800) {
      _backgroundImage = "images/night_clearsky.png";
    } else if (condition <= 804) {
      _backgroundImage = "images/night_clearsky.png";
    } else {
      _backgroundImage = "images/location_background.jpg";
    }
    return _backgroundImage;

  }


  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '☁️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
