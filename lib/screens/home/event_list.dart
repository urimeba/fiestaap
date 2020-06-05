import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_tile.dart';
import 'package:fiestapp/models/event.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<List<Event>>(context) ?? [];

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index){
        return EventTile(event: events[index]);
      });
  }
}
