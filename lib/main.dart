import 'package:fiestapp/screens/wrapper.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:fiestapp/theme/style.dart';
import 'package:flutter/services.dart';

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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        title: 'FiestApp',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
      ),
    );
  }
}