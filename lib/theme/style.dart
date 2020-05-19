import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Color.fromRGBO(5, 20, 79, 1),
    primaryColorLight: Color.fromRGBO(5, 20, 79, .6),
    accentColor: Colors.orange,
    hintColor: Colors.grey[480],
    dividerColor: Colors.white,
    buttonColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
  );
}