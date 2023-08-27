import 'dart:io';
import 'package:eventico/Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final formKeyLogin = GlobalKey<FormState>();
String enteredEmail = '';
String enteredPassword = '';

class LoginTexts extends ConsumerStatefulWidget {
  const LoginTexts({super.key});

  @override
  ConsumerState<LoginTexts> createState() => _LoginTextsState();
}

class _LoginTextsState extends ConsumerState<LoginTexts> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
          key: formKeyLogin,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
            child: Column(
              children: [
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
                        !value.contains('@') ||
                        value == null) {
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
                        value.length < 6 ||
                        value == null) {
                      return 'Your Password is Should be More Than Six Characters...';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    enteredPassword = newValue!;
                  },
                )
              ],
            ),
          )),
    );
  }
}
