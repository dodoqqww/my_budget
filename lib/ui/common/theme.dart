import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  shadowColor: Colors.lightBlue,
  dividerColor: Colors.blue,
  iconTheme: IconThemeData(size: 24),
  textTheme: TextTheme(
    //main screen sum 32
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
    //main title 28
    headline2: TextStyle(fontSize: 26, color: Colors.black),
    //graph screen month text
    headline3: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
    //list items 18
    bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
    //only in graph data text
    bodyText2: TextStyle(fontSize: 16.0),
  ),
);
