import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/details_screen.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather,this.text});

  final locationWeather;
  final String text;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  WeatherModel weather = WeatherModel();

  int temperature;
  String weatherIcon;
  String weatherMessage;
  String bgChange;
  String cityName;
  int tempMin;
  int tempMax;
  String weatherDescription;

  int forecastTemp;

  String _city;

  dynamic _forecastData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
    _city = widget.text;
    buildUI(_city);
  }

  updateUI(dynamic weatherData) {
    setState(() {
      if(weatherData == null){
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get Weather Data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'].toDouble();
      tempMin = weatherData['main']['temp_min'].toInt();
      tempMax = weatherData['main']['temp_max'].toInt();
      temperature = temp.toInt();
      cityName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherDescription = weatherData['weather'][0]['description'];
      weatherIcon = weather.getWeatherIcon(condition);
      bgChange = weather.setImage(condition);
      weatherMessage = weather.getMessage(temperature);
    });
  }

  buildUI(String text) async {
    _forecastData = await weather.getForecast(text);
    print('hoise?');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgChange),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      //print(weatherData);
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Center(
                      child: Text(
                        "$cityName",
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      print(typedName);
                      if(typedName != null){
                        var weatherData = await weather.getCityWeather(typedName);
                        //var forecastData = await weather.getForecast(typedName);
                        updateUI(weatherData);
                        buildUI(typedName);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherDescription'.toUpperCase(),
                      style: kMinMaxTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0),
                child: Text(
                  "Min Temp: $tempMin°C",
                  textAlign: TextAlign.left,
                  style: kMinMaxTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 1.0),
                child: Text(
                  "Max Temp: $tempMax°C",
                  textAlign: TextAlign.left,
                  style: kMinMaxTextStyle,
                ),
              ),

              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "24 hours Forecast",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                future:
                    weather.getForecast(cityName),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading...."),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                title: Text(
                                    snapshot.data[index].main.temp.toString() +
                                        '°C',
                                    style: kMessageTextStyle),
                                subtitle: Text(
                                  snapshot.data[index].weather.main.toString(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: Text('$weatherIcon',
                                    style: kConditionTextStyle),
                                isThreeLine: false,
                                onTap: () {
                                  print('tapped');
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => DetailsPage(
                                              snapshot.data[index])));
                                },
                                trailing: Text(
                                  snapshot.data[index].dtText.toString(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


