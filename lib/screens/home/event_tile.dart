import 'package:fiestapp/models/event.dart';
import 'package:fiestapp/services/auth.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Event event;
  final AuthService _auth = AuthService();
  String _dueno = '';

  EventTile({ this.event });

  @override
  Widget build(BuildContext context) {

    Future<String> _getDueno() async{
      var actualUser = await _auth.getUidUser();
      if(actualUser.uid==event.dueno){
        _dueno='Tú';
      }else{
        _dueno=actualUser.displayName.toString();
      }
      return _dueno;
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: FutureBuilder(
        future: _getDueno(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            return getEvent(snapshot, event);
          }else{
            return CircularProgressIndicator();
          }
          })
      );
  }
}


Widget getEvent(snapshot, event){

  print(event.codigo);

      return Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('http://fasa.co.za/fasablog/wp-content/uploads/2016/07/Walmart-Logo.jpg'),
            backgroundColor: Colors.transparent,
          ),
          title: Text(snapshot.data),
          subtitle: Text(
            'Codigo: ${event.codigo}\nMonto: ${event.monto}'
            ),
          isThreeLine:  true,
        ),
        );
    }