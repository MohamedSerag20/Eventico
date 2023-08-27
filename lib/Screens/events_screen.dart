import 'package:eventico/Providers/importExportData_provider.dart';
import 'package:eventico/Screens/loading_screen.dart';
import 'package:eventico/Widgets/events_add.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    bool isUserDone = ref.watch(AuthProvider.notifier).isUserDone;
    Map<String, dynamic> userInfo = ref.watch(AuthProvider);

    if (isUserDone) {
      return Scaffold(
        appBar: AppBar(
          title: Text("  ${userInfo['Username']}"),
          leading: CircleAvatar(
            foregroundImage: NetworkImage(userInfo['ImageUrl']),
          ),
          titleSpacing: 5,
          actions: [
            IconButton(
                onPressed: () {
                  // ignore: invalid_use_of_protected_member
                  ref.refresh(AuthProvider.notifier).state;
                  ref.refresh(AuthProvider.notifier).isUserDone;
                  firebaseAuth.signOut();
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Column(
          children: [
            const Expanded(child: EventsAdd()),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                shape: const CircleBorder(
                  side: BorderSide.none,
                ),
                elevation: 30,
                onPressed: () {
                  ref.read(ImportExportDataProvider.notifier).importingEvents();
                },
                isExtended: true,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
    } else {
      return const LoadingScreen();
    }
  }
}
