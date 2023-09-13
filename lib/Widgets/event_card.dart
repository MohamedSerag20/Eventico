import 'package:flutter/material.dart';

import '../Models/event.dart';

class EventCard extends StatelessWidget {
  EventCard({super.key, required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    final eventDate = event.date.split(' ')[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 6, 2, 6),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.onPrimary.withOpacity(
                  0.8,
                ),
            Theme.of(context).colorScheme.onPrimary.withOpacity(
                  0.78,
                ),
            Theme.of(context).colorScheme.onPrimary.withOpacity(
                  0.76,
                ),
            Theme.of(context).colorScheme.onPrimary.withOpacity(
                  0.74,
                )
          ])),
          width: double.infinity,
          height: 60,
          child: ListTile(
            shape: const Border(
                top: BorderSide(width: 10, style: BorderStyle.solid)),
            title: Text(
              event.eventName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            style: ListTileStyle.list,
            hoverColor: Colors.amber,
            autofocus: true,
            onTap: () {
              print(event.story);
            },
            leading: Text(
              "#The place Photo",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Text(
              eventDate,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )),
    );
  }
}