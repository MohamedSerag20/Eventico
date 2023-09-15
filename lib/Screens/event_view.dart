import 'package:eventico/Models/event.dart';
import 'package:flutter/material.dart';

class EventView extends StatelessWidget {
  EventView({super.key, required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(event.eventName))),
    );
  }
}
