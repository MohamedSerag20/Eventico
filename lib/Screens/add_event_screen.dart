import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventScr extends StatefulWidget {
  const AddEventScr({super.key});

  @override
  State<AddEventScr> createState() => _AddEventScrState();
}

class _AddEventScrState extends State<AddEventScr> {
  List<File> imageF = [];
  String? discription;
  String? story;
  List<Map<String, String>> withWhom = [];
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('New Event')),
        body: ListView(
          children: [
            Center(
                child: InkWell(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image != null) {
                        setState(() {
                          imageF.add(File(image.path));
                        });
                      }
                    },
                    child: (imageF.isEmpty)
                        ? Container(
                            height: 180,
                            width: 210,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.05),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.15),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.25),
                                ]),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 80,
                                  ),
                                ),
                                Text('A Picture of the Place'),
                              ],
                            ))
                        : Container(
                            height: 180,
                            width: 210,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(imageF[0]),
                                    fit: BoxFit.cover),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25)))))),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: (imageF.isEmpty || imageF.length == 1)
                  ? InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            imageF.add(File(image.path));
                          });
                        }
                      },
                      child: Container(
                          height: 90,
                          width: 105,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.05),
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.1),
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.15),
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2),
                                Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.25),
                              ]),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 40,
                                ),
                              ),
                              Text('Friends'),
                            ],
                          )),
                    )
                  : Row(children: [
                      ...imageF
                          .sublist(1, imageF.length)
                          .map((e) => InkWell(
                                onTap: () async {
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (image != null) {
                                    setState(() {
                                      imageF.insert(
                                          imageF.indexOf(e), File(image.path));
                                      imageF.remove(e);
                                    });
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Container(
                                      height: 90,
                                      width: 105,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(e),
                                              fit: BoxFit.cover),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(25)))),
                                ),
                              ))
                          .toList(),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image != null) {
                            setState(() {
                              imageF.add(File(image.path));
                            });
                          }
                        },
                        child: Container(
                            height: 90,
                            width: 105,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 40,
                            )),
                      ),
                    ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: formKey,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.surface.withOpacity(0.1),
                        Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.15),
                        Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.2),
                        Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.25)
                      ])),
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 300,
                        decoration: const InputDecoration(
                          label: Text('A Memorable Discription'),
                        ),
                        onSaved: (newValue) {
                          discription = newValue;
                        },
                        validator: (value) {
                          return null;
                        },
                        enableSuggestions: true,
                        maxLines: 3,
                      ),
                      TextFormField(
                        maxLength: 300,
                        decoration: const InputDecoration(
                          label: Text('An Emotional Story Happened'),
                        ),
                        onSaved: (newValue) {
                          story = newValue;
                        },
                        validator: (value) {
                          return null;
                        },
                        enableSuggestions: true,
                        maxLines: 3,
                      ),
                      const Text(
                        'With Whom',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decorationStyle: TextDecorationStyle.dashed,
                            fontSize: 20),
                      ),
                      ...withWhom
                          .map((e) => Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        label: Text('Email (Optional)'),
                                      ),
                                      onSaved: (newValue) {
                                        e['Email'] = newValue!;
                                      },
                                      validator: (value) {
                                        return null;
                                      },
                                      enableSuggestions: true,
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        label: Text('Name'),
                                      ),
                                      onSaved: (newValue) {
                                        e['Name'] = newValue!;
                                      },
                                      validator: (value) {
                                        return null;
                                      },
                                      enableSuggestions: true,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              withWhom.add({'Email': '', 'Name': ''});
                            });
                          },
                          child: const Row(
                            children: [
                              Spacer(),
                              Text('Add a Friend'),
                              Icon(Icons.add)
                            ],
                          )),
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Cancel')),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Save'))
                ]),
          ],
        ));
  }
}
