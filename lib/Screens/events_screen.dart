import 'package:eventico/Providers/importExportData_provider.dart';
import 'package:eventico/Screens/add_event_screen.dart';
import 'package:eventico/Screens/loading_screen.dart';
import 'package:eventico/Widgets/events_scroll.dart';
import 'package:flutter/material.dart';
import 'package:eventico/Providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userInfo = ref.watch(AuthProvider.notifier).content;
    if (userInfo.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text("  ${userInfo['Username']}"),
          leading: CircleAvatar(
            foregroundImage: NetworkImage(userInfo['ImageUrl']),
          ),
          titleSpacing: 5,
          actions: [
            IconButton(
                onPressed: () {
                  firebaseAuth.signOut();
                  ref.refresh(AuthProvider.notifier).userState;
                  // ignore: unused_result
                  ref.refresh(ImportExportDataProvider.notifier);
                  
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Column(
          children: [
            const Expanded(child: EventsWidget()),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                shape: const CircleBorder(
                  side: BorderSide.none,
                ),
                elevation: 30,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const AddEventScr())));
                  // ref.read(ImportExportDataProvider.notifier).exportingEvents();
                },
                isExtended: true,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
    } // the signUp checker
    else {
      print("Loading Screen of Event Screen");
      return const LoadingScreen();
    }
  }
}
