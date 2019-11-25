import 'package:flutter/material.dart';
import 'package:clima/services/Forecast.dart';
import 'package:clima/utilities/constants.dart';


class DetailsPage extends StatelessWidget {
  final Forcast locationDetails;
  DetailsPage(this.locationDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationDetails.dtText.toString()),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black45,Colors.blueGrey
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      locationDetails.main.temp.toString() + '°C',
                      style: kTempTextStyle,
                    ),
                  ],
                ),
              ),
              Text(
                locationDetails.weather.description.toString().toUpperCase(),
                style: kDetailsTextStyle,
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: Divider(
                          color: Colors.white,
                          height: 45.0,
                        )),
                  ),
                  Text("More Details"),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.white,
                          height: 45.0,
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Max: " + locationDetails.main.temp_max.toString().toUpperCase()+"°C",
                      style: kDetailsTextStyle,
                    ),
                    Text(
                      "Min: " + locationDetails.main.temp_min.toString().toUpperCase()+"°C",
                      style: kDetailsTextStyle,
                    ),
                    Text(
                      "Pressure: " + locationDetails.main.pressure.toString().toUpperCase() +"hPa",
                      style: kDetailsTextStyle,
                    ),
                    Text(
                      "Humidity: " + locationDetails.main.humidity.toString().toUpperCase()+"%",
                      style: kDetailsTextStyle,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


