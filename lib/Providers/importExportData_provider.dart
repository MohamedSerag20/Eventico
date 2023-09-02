import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImportExportDataNotifier extends StateNotifier<List<dynamic>> {
  ImportExportDataNotifier() : super([]);

  importingEvents() async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final userCredintials = await FirebaseFirestore.instance
        .collection(currentUid)
        .doc('UserEvents')
        .get();
    final userCredintialsMap = userCredintials.data();
    if (userCredintialsMap == null || userCredintialsMap.isEmpty) {
      state = [];
    }
    else{
      final userEventsArray = userCredintialsMap["Events"] as List;
      state = userEventsArray;
    }
  }

  exportingEvents(Map<String, Object> newValue) async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final userCredintials = await FirebaseFirestore.instance
        .collection(currentUid)
        .doc('UserEvents')
        .update({
      'Events': [
        ...state,
        {
          'Date': DateTime.now().toString(),
          'Discription': '',
          'EventName': '',
          'ImagesUrl': ['', ''],
          'Story': '',
          'UserKey': '',
          'WithWhom': [
            {'Name': '', 'Email': ''},
            {'Name': '', 'Email': ''}
          ]
        }
      ]
    });
    state = [
      ...state,
      {
        'Date': DateTime.now().toString(),
        'Discription': '',
        'EventName': '',
        'ImagesUrl': ['', ''],
        'Story': '',
        'UserKey': '',
        'WithWhom': [
          {'Name': '', 'Email': ''},
          {'Name': '', 'Email': ''}
        ]
      }
    ];
  }
}

final ImportExportDataProvider =
    StateNotifierProvider<ImportExportDataNotifier, List<dynamic>>(
        (ref) => ImportExportDataNotifier());
