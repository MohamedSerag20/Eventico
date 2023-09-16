import 'package:eventico/Models/event.dart';
import 'package:eventico/Widgets/event_view_signs.dart';
import 'package:flutter/material.dart';

class EventView extends StatelessWidget {
  const EventView({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(event.eventName))),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(children: [
              EVSigns(
                  text: 'Place Picture',
                  color: Theme.of(context).colorScheme.onBackground),
              Container(
                  height: 180,
                  width: 210,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(event.imagesUrl[0]!),
                          fit: BoxFit.cover),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25)))),
              const SizedBox(
                height: 6,
              ),
              EVSigns(
                  text: 'Family/Friends Pictures',
                  color: Theme.of(context).colorScheme.onBackground),
              ListView(
                scrollDirection: Axis.horizontal,
                children: event.imagesUrl
                    .sublist(1)
                    .map((imageUrl) => Container(
                        height: 90,
                        width: 105,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(imageUrl), fit: BoxFit.cover),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)))))
                    .toList(),
              ),
              const SizedBox(
                height: 6,
              ),
              EVSigns(
                  text: 'Discription',
                  color: Theme.of(context).colorScheme.onBackground),
              Container(
                margin: const EdgeInsets.all(4),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow()],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Card(child: Text(event.discription)),
              ),
              EVSigns(
                  text: 'Story',
                  color: Theme.of(context).colorScheme.onBackground),
              Container(
                margin: const EdgeInsets.all(4),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(boxShadow: [BoxShadow()]),
                child: Card(child: Text(event.discription)),
              ),
              if (event.withWhom.isNotEmpty)
                Expanded(
                    child: Column(
                  children: [
                    ...event.withWhom.map((e) => Container(
                          color: Theme.of(context).colorScheme.onBackground,
                          child: Row(children: [
                            Text(e['Name']),
                            const Spacer(),
                            if (e["Email"] != null) Text(e["Email"])
                          ]),
                        ))
                  ],
                ))
            ]),
          )),
    );
  }
}
