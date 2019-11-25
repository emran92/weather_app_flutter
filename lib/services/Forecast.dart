import 'package:flutter/material.dart';
import 'package:clima/services/ForecastMain.dart';
import 'package:clima/services/ForecastWeather.dart';

class Forcast {
  int dt;
  String dtText;
  ForcastWeather weather;
  ForcastMain main;

  Forcast({
    @required this.dt,
    @required this.dtText,
    @required this.weather,
    @required this.main,
  });

  factory Forcast.fromJson(Map<String, dynamic> json) {
    return Forcast(
      dt: json['dt'] as int,
      dtText: json['dt_txt'] as String,
      weather: ForcastWeather.fromJson(json['weather'][0]),
      main: ForcastMain.fromJson(json['main']),
    );
  }
}