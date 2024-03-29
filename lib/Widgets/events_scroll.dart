import 'package:eventico/Widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/event.dart';
import '../Providers/importExportData_provider.dart';

class EventsWidget extends ConsumerStatefulWidget {
  const EventsWidget({super.key});

  @override
  ConsumerState<EventsWidget> createState() => _EventsAddState();
}

class _EventsAddState extends ConsumerState<EventsWidget> {
  @override
  Widget build(BuildContext context) {
    List<dynamic>? userEventsArray = ref.watch(ImportExportDataProvider);
    if (userEventsArray == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (userEventsArray.isEmpty) {
      return Center(
          child: Text(
        "No Events Exist",
        style: Theme.of(context).textTheme.titleMedium,
      ));
    }
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
            child: SizedBox(
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
