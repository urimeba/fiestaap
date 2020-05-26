import 'package:fiestapp/screens/authenticate/authenticate.dart';
import 'package:fiestapp/screens/authenticate/signin2.dart';
import 'package:fiestapp/screens/authenticate/signup2.dart';
import 'package:flutter/material.dart';
//Screens

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Authenticate());
      case '/registro':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      default:
        return MaterialPageRoute(builder: (_) => SignInPage());
    }
  }
}