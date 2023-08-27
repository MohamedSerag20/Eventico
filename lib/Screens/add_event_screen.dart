import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddEventScr extends StatefulWidget {
  const AddEventScr({super.key});

  @override
  State<AddEventScr> createState() => _AddEventScrState();
}

class _AddEventScrState extends State<AddEventScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Event')),
      body: Column(),
    );
  }
}
