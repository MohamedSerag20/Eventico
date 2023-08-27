import 'package:eventico/Widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/event.dart';
import '../Providers/importExportData_provider.dart';

class EventsAdd extends ConsumerStatefulWidget {
  const EventsAdd({super.key});

  @override
  ConsumerState<EventsAdd> createState() => _EventsAddState();
}

class _EventsAddState extends ConsumerState<EventsAdd> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> userEventsArray = ref.watch(ImportExportDataProvider);
    print(userEventsArray);
    final userEventsTransArray = userEventsArray
        .map((e) => Event(
            userKey: e['UserKey'],
            eventName: e['EventName'],
            discription: e['Discription'],
            story: e['Story'],
            imagesUrl: e['ImagesUrl'],
            withWhom: e['WithWhom'],
            date: e['Date']))
        .toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your Events",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          ...userEventsTransArray
                              .map((e) => EventCard(event: e))
                              .toList()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
