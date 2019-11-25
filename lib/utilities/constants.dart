import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 70.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 40.0,
);

const kDetailsTextStyle = TextStyle(
  fontSize: 25.0,
);

const kMinMaxTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 20.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  icon: Icon(Icons.location_city,color: Colors.white70,size: 45.0,),
  hintText: 'Enter City Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);