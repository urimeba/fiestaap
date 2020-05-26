import 'package:fiestapp/screens/wrapper.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() => runApp(FiestApp());

class FiestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
  //   return MaterialApp(
  //     title: 'FiestApp',
  //     theme: appTheme(),
  //     debugShowCheckedModeBanner: false,
  //     initialRoute: '/',
  //     onGenerateRoute: RouteGenerator.generateRoute,
  //   );
  // }
  return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(home: Wrapper(),),
    );
  }
}