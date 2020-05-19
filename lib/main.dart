import 'package:flutter/material.dart';
import 'package:fiestapp/theme/style.dart';
import 'package:fiestapp/route_generator.dart';

void main() => runApp(FiestApp());

class FiestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'FiestApp',
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}