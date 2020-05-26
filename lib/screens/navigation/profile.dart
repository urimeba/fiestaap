import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Perfil"),
          SizedBox(height: 20),
          Text("Email"),
          SizedBox(height: 20),
          

          FlatButton.icon(
            onPressed: ()async {
              // await _auth.signOut();
              print(await _auth.getDataUser());
            // print(_auth.currentUser.displayname);
            }, 
            icon: Icon(Icons.person), 
            label: Text('Cerrar sesion')
          ),
        ],
      ),
      
    );
  }
}