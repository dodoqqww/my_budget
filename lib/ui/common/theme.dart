import 'package:flutter/material.dart';

//TODO theme egységesítése
//only in graph screen 14
//list items 18
//main screen month 28
//main screen sum 32

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  shadowColor: Colors.lightBlue,
  dividerColor: Colors.blue,
  textTheme: TextTheme(
    //main screen sum 32
    headline1: TextStyle(fontSize: 32),
    //main title 28
    headline2: TextStyle(fontSize: 26, color: Colors.black),
    //graph screen month text
    headline3: TextStyle(fontSize: 22),
    //list items 18
    bodyText1: TextStyle(fontSize: 18.0),
    //only in graph data text
    bodyText2: TextStyle(fontSize: 16.0),
  ),
);
