import 'package:flutter/material.dart';
//Screens
import 'package:fiestapp/screens/signin.dart';
import 'package:fiestapp/screens/signup.dart';

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