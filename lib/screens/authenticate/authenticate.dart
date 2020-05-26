import 'package:fiestapp/screens/authenticate/signin2.dart';
import 'package:fiestapp/screens/authenticate/signup2.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn );
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignInPage(toggleView: toggleView);
    }else{
      return SignUpPage(toggleView: toggleView);
    }
  }
}