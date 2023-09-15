// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final fireStore = FirebaseFirestore.instance;

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() : super();
  String? email;
  String? password;
  Map<String, dynamic> content = {};
  StreamController<Map<String, bool>> userState = StreamController();

//////////////////////////////////////////////////////////////////////////////////////////////
  sign_in({required email, required password, required context}) async {
    try {
      final user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userState.add({'isLoading': true, 'isSigned': true});
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')));
    }
  }

  gettingNamePick(BuildContext context) async {
    try {
      final currentUid = firebaseAuth.currentUser!.uid;
      final userCredintials = await FirebaseFirestore.instance
          .collection(currentUid)
          .doc('UserSpecifications')
          .get();
      final userMap = userCredintials.data();
      final username = userMap!['Username'] as String;
      final imageUrl = userMap['ImageUrl'] as String;
      content = {
        'Username': username,
        'ImageUrl': imageUrl,
      };
      userState.add({'isLoading': false, 'isSigned': true});
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
  sign_up(
      {required email,
      required password,
      required username,
      required imageF,
      required context}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userState.add({'isLoading': true, 'isSigned': false});
      final path = '$username images/userImage/$username image';
      await firebaseStorage.ref().child(path).putFile(imageF!);
      final imageUrl = await firebaseStorage.ref(path).getDownloadURL();
      fireStore
          .collection(firebaseAuth.currentUser!.uid)
          .doc('UserSpecifications')
          .set({
        "Email": email.toString(),
        "ImageUrl": imageUrl.toString(),
        "Password": password.toString(),
        "Username": username.toString(),
      });
      userState.add({'isLoading': true, 'isSigned': true});
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed.')));
    }
  }

  refresh() {
    userState.add({});
    //print('added');
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
}

final AuthProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier();
});
