// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final fireStore = FirebaseFirestore.instance;

class AuthNotifier extends StateNotifier<Map<String, dynamic>> {
  AuthNotifier({required this.isSignUp}) : super({});

  IsSignUp isSignUp;
  String? email;
  String? password;
  String? username;
  File? imageF;
  String? imageUrl;

//////////////////////////////////////////////////////////////////////////////////////////////
  sign_in({required email, required password, required context}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      state = {'isUserFailed': true};
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')));
    }
  }

  gettingNamePick(BuildContext context) async {
    try {
      //firebaseAuth.signOut();
      final currentUid = firebaseAuth.currentUser!.uid;
      final userCredintials = await FirebaseFirestore.instance
          .collection(currentUid)
          .doc('UserSpecifications')
          .get();
      final userMap = userCredintials.data();
      username = userMap!['Username'] as String;
      imageUrl = userMap['ImageUrl'] as String;

      final currentUidy = firebaseAuth.currentUser!.uid;
      final userCredintialsy = await FirebaseFirestore.instance
          .collection(currentUid)
          .doc('UserSpecifications')
          .get();
      final userMapy = userCredintialsy.data();
      username = userMapy!['Username'] as String;
      imageUrl = userMapy['ImageUrl'] as String;
      state = {
        'Username': username!,
        'ImageUrl': imageUrl!,
      };
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
    this.username = username;
    this.email = email;
    this.username = username;
    this.imageF = imageF;
    try {
      isSignUp.isSignUp();
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      state = {'isUserFailed': true};
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed.')));
    }
  }

  void savingUser() async {
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
    state = {
      'Username': username,
      'ImageUrl': imageUrl,
    };
    isSignUp.stopSignUp();
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
}

class IsSignUp extends StateNotifier<bool> {
  IsSignUp() : super(false);

  isSignUp() {
    
    state = true;
  }

  stopSignUp() {
    state = false;
  }
}

final AuthProvider =
    StateNotifierProvider<AuthNotifier, Map<String, dynamic>>((ref) {
  return AuthNotifier(isSignUp: ref.watch(IsSignprovider.notifier));
});

final IsSignprovider = StateNotifierProvider<IsSignUp, bool>((ref) {
  return IsSignUp();
});
