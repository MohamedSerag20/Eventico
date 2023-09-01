import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final fireStore = FirebaseFirestore.instance;

class AuthNotifier extends StateNotifier<Map<String, dynamic>> {
  AuthNotifier() : super({});

  String? email;
  String? password;
  String? username;
  String? imageUrl;

//////////////////////////////////////////////////////////////////////////////////////////////
  sign_in({required email, required password, required context}) async {
    try {
      state = {};
      final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
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
    this.email = email;
    this.password = password;
    this.username = username;
    try {
      state = {};
      final UserCredentials = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final path = '$username images/userImage/$username image';
      await firebaseStorage.ref().child(path).putFile(imageF);
      final imageUrl = await firebaseStorage.ref(path).getDownloadURL();
      print(imageUrl);
      fireStore
          .collection(firebaseAuth.currentUser!.uid)
          .doc('UserSpecifications')
          .set({
        "Email": email.toString(),
        "ImageUrl": imageUrl.toString(),
        "Password": password.toString(),
        "Username": username.toString(),
      });
      print('/////////////////////////////////////////////////////////////////////');
    } on FirebaseAuthException catch (error) {
      state = {'isUserFailed': true};
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed.')));
    } on Exception {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An Error has Happened, Try Later..')));
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
}

final AuthProvider =
    StateNotifierProvider<AuthNotifier, Map<String, dynamic>>((ref) {
  return AuthNotifier();
});













// class SignupNotifier extends StateNotifier<Map<String, String>> {
//   SignupNotifier() : super({});

//   String? email;
//   String? password;
//   String? username;
//   String? imageUrl;
// }


// sign_in({required email, required password, required context}) async {
//   try {
//     state = {};
//     final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   } on FirebaseAuthException catch (error) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error.message ?? 'Authentication Failed.')));
//   }
// }

// void gettingData(BuildContext context) async {
//   try {
//     final currentUid = firebaseAuth.currentUser!.uid;
//     final userCredintials = await FirebaseFirestore.instance
//         .collection(currentUid)
//         .doc('UserSpecifications')
//         .get();
//     final userMap = userCredintials.data();
//     username = userMap!['Username'] as String;
//     imageUrl = userMap['ImageUrl'] as String;
//     state = {
//       'Username': username!,
//       'ImageUrl': imageUrl!,
//     };
//   } catch (error) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Your email is not available, try later!')));
//   }
// }


// sign_up(
//     {required email,
//     required password,
//     required username,
//     required imageF,
//     required context}) async {
//   this.email = email;
//   this.password = password;
//   this.username = username;
//   try {
//     state = {};
//     final UserCredentials = await firebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     final responseStorage = await firebaseStorage
//         .ref(username + ' images')
//         .child('userImage')
//         .child(username + ' image')
//         .putFile(imageF);
//     imageUrl = await responseStorage.ref.getDownloadURL();

//     final response = await fireStore
//         .collection(UserCredentials.user!.uid)
//         .doc('UserSpecifications')
//         .set({
//       'Email': email,
//       'Password': password,
//       'Username': username,
//       'ImageUrl': imageUrl!,
//     });
//   } on FirebaseAuthException catch (error) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error.message ?? 'Authentication Failed.')));
//   }
// }

// void gettingData(BuildContext context) async {
//   try {
//     final currentUid = firebaseAuth.currentUser!.uid;
//     final userCredintials = await FirebaseFirestore.instance
//         .collection(currentUid)
//         .doc('UserSpecifications')
//         .get();

//     final userMap = userCredintials.data();

//     email = userMap!['Email'] as String;
//     password = userMap['Password'] as String;
//     username = userMap['Username'] as String;
//     imageUrl = userMap['ImageUrl'] as String;

//     state = {
//       'Email': email!,
//       'Password': password!,
//       'Username': username!,
//       'ImageUrl': imageUrl!,
//     };
//   } catch (error) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(error.toString())));
//   }
// }