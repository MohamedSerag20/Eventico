import 'dart:async';
import 'dart:convert';
import 'package:eventico/Providers/auth_provider.dart';
import 'package:eventico/Providers/importExportData_provider.dart';
import 'package:eventico/Screens/auth_screen.dart';
import 'package:eventico/Screens/events_screen.dart';
import 'package:eventico/Screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eventico/firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(ProviderScope(
    child: MyApp(theme: theme),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: widget.theme,
      title: 'Eventico',
      home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              if (firebaseAuth.currentUser != null) {
                //firebaseAuth.signOut();
                print('fd');
                ref.read(AuthProvider.notifier).gettingNamePick(context);
                ref.read(ImportExportDataProvider.notifier).importingEvents();
                print('arrived');
                return const EventsScreen();
              } else {
                return const AuthScreen();
              }
            } else {
              if (snapshot.data!['isLoading']! && snapshot.data!['isSigned']!) {
                print('second');
                ref.read(AuthProvider.notifier).gettingNamePick(context);
                ref.read(ImportExportDataProvider.notifier).importingEvents();
                return const EventsScreen();
              } else {
                //ref.read(ImportExportDataProvider.notifier).importingEvents();
                return const EventsScreen();
              }
            }
            
          },
          stream: ref.watch(AuthProvider.notifier).userState.stream),
      themeMode: ThemeMode.dark,
    );
  }
}