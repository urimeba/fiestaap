// import 'package:brew_crew/screens/authenticate/authenticate.dart';
// import 'package:brew_crew/screens/home/home.dart';
import 'package:fiestapp/screens/signin.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:brew_crew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // final user = Provider.of<User>(context); 
    // print(user);
    final String user = null;

    // Return either home or authenticate Widget
    if(user==null){
      return SignInPage();
    }
    // else{
    //   return Home();
    // }
  }
}