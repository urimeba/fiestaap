import 'package:fiestapp/models/user.dart';
import 'package:fiestapp/screens/authenticate/authenticate.dart';
import 'package:fiestapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); 
    // print(user);

    // Return either home or authenticate Widget
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}