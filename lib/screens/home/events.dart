import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fiestapp/models/event.dart';
import 'event_list.dart';
import 'package:fiestapp/services/database.dart';

class Eventos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
        value: DatabaseService().events,
          child: Scaffold(
            backgroundColor: Colors.brown[50],
            body: Container(
              child: EventList()
              ),
          ),
    );
  }
}

