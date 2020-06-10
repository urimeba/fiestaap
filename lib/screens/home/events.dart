import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fiestapp/models/event.dart';
import 'event_list.dart';
import 'package:fiestapp/services/database.dart';
// import 'package:provider/provider.dart';
import 'package:fiestapp/models/user.dart';
import 'package:fiestapp/screens/home/event_new_alien.dart';
import 'package:fiestapp/screens/home/event_new.dart';

class Eventos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showAlienEvent(){
      showModalBottomSheet(
        context: context, 
        builder: (context) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: NewEventAlien(),
          );
        }
      );
    }

    void _showNewEvent(){
      showModalBottomSheet(
             context: context, 
             builder: (context) {
               return Container(
                 color: Colors.white,
                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                 child: NewEvent(),
               );
             }
             );
    }

    final user = Provider.of<User>(context); 
    return StreamProvider<List<Event>>.value(
        value: DatabaseService(uid: user.uid).events,
          child: Scaffold(
            backgroundColor: Colors.brown[50],
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Únete a un evento ajeno'),
                        onPressed: () => _showAlienEvent(),
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        child: Text('Crea un evento nuevo'),
                        onPressed: () => _showNewEvent(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 430,
                    child: EventList()
                  ),
                ],
              ),
              // child: EventList(),
              ),
            ),
    );


  }
}

