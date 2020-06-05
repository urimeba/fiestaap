import 'package:fiestapp/models/event.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final Event event;

  EventTile({ this.event });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('http://fasa.co.za/fasablog/wp-content/uploads/2016/07/Walmart-Logo.jpg'),
            backgroundColor: Colors.transparent,
          ),
          title: Text(event.dueno),
          subtitle: Text(
            'Monto: ${event.monto}'
            ),
          isThreeLine:  true,
        ),
        ),
      );
  }
}


