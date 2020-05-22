import 'package:flutter/material.dart';
//Screens
import 'package:fiestapp/screens/signin2.dart';
import 'package:fiestapp/screens/signup2.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/registro':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      default:
        return MaterialPageRoute(builder: (_) => SignInPage());
    }
  }
}