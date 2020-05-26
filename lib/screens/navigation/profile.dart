import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();
  String name = "";
  String email = "";

  getData() async{
    List<String> data = await _auth.getDataUser();
    print(data[0]);
    print(data[1]);
    setState(() {
      name = data[0];
      email = data[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Perfil"),
          SizedBox(height: 20),
          Text(name),
          SizedBox(height: 20),
          Text("Nombre"),
          SizedBox(height: 20),
          Text(email),
          SizedBox(height: 20),
          

          FlatButton.icon(
            onPressed: (){
              getData();
              // await _auth.signOut();
            }, 
            icon: Icon(Icons.person), 
            label: Text('Cerrar sesion')
          ),
        ],
      ),
    );
  }
}