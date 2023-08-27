import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final formKeyUp = GlobalKey<FormState>();
File? imageF;
String enteredEmail = '';
String enteredPassword = '';
String enteredUsername = '';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _LoginTextsState();
}

class _LoginTextsState extends ConsumerState<SignUp> {
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
          key: formKeyUp,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (image != null) {
                      imageF = File(image.path);
                      setState(() {
                        isImageSelected = true;
                      });
                    }
                  },
                  child: isImageSelected
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(imageF!),
                        )
                      : const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.photo_camera_front_outlined),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.email),
                    labelText: 'Your Email',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        !value.contains('@')) {
                      return 'Your Email is Incorrect...';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    enteredEmail = newValue!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.password),
                    labelText: 'Your Password',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        value.length < 6) {
                      return 'Should be More Than Six Characters...';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    enteredPassword = newValue!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.person),
                    labelText: 'Your Username',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        value.length < 3) {
                      return 'Should be More Than Three Characters...';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    enteredUsername = newValue!;
                  },
                )
              ],
            ),
          )),
    );
  }
}
