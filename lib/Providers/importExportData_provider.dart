import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImportExportDataNotifier extends StateNotifier<List<dynamic>?> {
  ImportExportDataNotifier() : super(null);

  importingEvents() async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final userCredintials = await FirebaseFirestore.instance
        .collection(currentUid)
        .doc('UserEvents')
        .get();
    final userCredintialsMap = userCredintials.data();
    if (userCredintialsMap == null || userCredintialsMap.isEmpty) {
      state = [];
    } else {
      final userEventsArray = userCredintialsMap["Events"] as List;
      state = userEventsArray;
    }
  }

  exportingEvents(
      {required String username,
        required String discription,
      required String eventName,
      required List<File> imagesF,
      required String story,
      required String userKey,
      required List<Map<String, String>> withWhom}) async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    List<String> imagesUrl = [];
    int imageNum = 1;

    for (File imageF in imagesF) {
      final path = '$username images/$eventName Images/"${imageNum.toString()}" image';
      await FirebaseStorage.instance.ref().child(path).putFile(imageF);
      imagesUrl.add(await FirebaseStorage.instance.ref(path).getDownloadURL());
      imageNum++;
    }

    await FirebaseFirestore.instance
        .collection(currentUid)
        .doc('UserEvents')
        .update({
      'Events': [
        ...state!,
        {
          'Date': DateTime.now().toString(),
          'Discription': discription,
          'EventName': eventName,
          'ImagesUrl': imagesUrl,
          'Story': story,
          'UserKey': userKey,
          'WithWhom': withWhom
        }
      ]
    });
    state = [
      ...state!,
      {
        'Date': DateTime.now().toString(),
        'Discription': discription,
        'EventName': eventName,
        'ImagesUrl': imagesUrl,
        'Story': story,
        'UserKey': userKey,
        'WithWhom': withWhom
      }
    ];
  }
}

final ImportExportDataProvider =
    StateNotifierProvider<ImportExportDataNotifier, List<dynamic>?>(
        (ref) => ImportExportDataNotifier());
