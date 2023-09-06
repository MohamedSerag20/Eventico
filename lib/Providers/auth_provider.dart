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

class AuthNotifier extends ChangeNotifier {
  // AuthNotifier({required this.isSignUp}) : super({});
  AuthNotifier() : super();
  //IsSign isSignUp;
  String? email;
  String? password;
  Map<String, dynamic> content = {};
  bool? isLoading;
  UserCredential? user;
  bool errorr = false;

//////////////////////////////////////////////////////////////////////////////////////////////
  sign_in({required email, required password, required context}) async {
    try {
      isLoading = true;
      user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      isLoading = false;
    } on FirebaseAuthException catch (error) {
      errorr = true;
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
      final username = userMap!['Username'] as String;
      final imageUrl = userMap['ImageUrl'] as String;
      content = {
        'Username': username,
        'ImageUrl': imageUrl,
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
    try {
      //isSignUp.isSignUp();
      user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      content = {
        'Username': username,
        'ImageUrl': imageUrl,
      };
      //isSignUp.stopSignUp();
    } on FirebaseAuthException catch (error) {
      errorr = true;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed.')));
    }
  }

  // void savingUser() async {
  //   final path = '$username images/userImage/$username image';
  //   await firebaseStorage.ref().child(path).putFile(imageF!);
  //   final imageUrl = await firebaseStorage.ref(path).getDownloadURL();
  //   fireStore
  //       .collection(firebaseAuth.currentUser!.uid)
  //       .doc('UserSpecifications')
  //       .set({
  //     "Email": email.toString(),
  //     "ImageUrl": imageUrl.toString(),
  //     "Password": password.toString(),
  //     "Username": username.toString(),
  //   });
  //   state = {
  //     'Username': username,
  //     'ImageUrl': imageUrl,
  //   };
  //   //isSignUp.stopSignUp();
  // }

///////////////////////////////////////////////////////////////////////////////////////////////////////
}

// class IsSign extends StateNotifier<bool> {
//   IsSign() : super(false);

//   isSignUp() {
//     state = true;
//   }

//   stopSignUp() {
//     state = false;
//   }
// }

final AuthProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  // return AuthNotifier(isSignUp: ref.watch(IsSignprovider.notifier));
  return AuthNotifier();
});

// final IsSignprovider = StateNotifierProvider<IsSign, bool>((ref) {
//   return IsSign();
// });
