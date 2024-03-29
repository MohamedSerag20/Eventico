import 'dart:io';

import 'package:eventico/Providers/auth_provider.dart';
import 'package:eventico/Providers/importExportData_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddEventScr extends ConsumerStatefulWidget {
  const AddEventScr({super.key});

  @override
  ConsumerState<AddEventScr> createState() => _AddEventScrState();
}

class _AddEventScrState extends ConsumerState<AddEventScr> {
  String? EventName;
  File? imagePF;
  List<File> imageFF = [];
  String? discription;
  String? story;
  List<Map<String, String>> withWhom = [];

  void validating() {
    if (formKey.currentState!.validate()) {
      if (imagePF == null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'You did not Select A Place Picture !!!',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } else {
        formKey.currentState!.save();
        ref.read(ImportExportDataProvider.notifier).exportingEvents(
            username: ref.read(AuthProvider.notifier).content["Username"],
            discription: discription.toString(),
            eventName: EventName!,
            imagesF: [imagePF!, ...imageFF],
            story: story!,
            userKey: ValueKey(story!).toString(),
            withWhom: withWhom);
      }
      Navigator.pop(context);
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('New Event'),
            backgroundColor: Theme.of(context).colorScheme.onSecondary),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(
                  child: InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            imagePF = File(image.path);
                          });
                        }
                      },
                      child: (imagePF == null)
                          ? Container(
                              height: 180,
                              width: 210,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.02),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.04),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.06),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.08),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.1),
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
                                      image: FileImage(imagePF!),
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
                child: (imageFF.isEmpty)
                    ? InkWell(
                        onTap: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image != null) {
                            setState(() {
                              imageFF.add(File(image.path));
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
                                      .withOpacity(0.02),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.04),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.06),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.08),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.1),
                                ]),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
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
                        ...imageFF
                            .map((e) => InkWell(
                                  onTap: () async {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (image != null) {
                                      setState(() {
                                        imageFF.insert(imageFF.indexOf(e),
                                            File(image.path));
                                        imageFF.remove(e);
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                imageFF.add(File(image.path));
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
                                        .withOpacity(0.02),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.04),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.06),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.08),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.1),
                                  ]),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
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
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.02),
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.04),
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.06),
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.08),
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.1),
                        ])),
                    child: Column(
                      children: [TextFormField(
                          maxLength: 300,
                          decoration: const InputDecoration(
                            label: Text('Event Name'),
                          ),
                          onSaved: (newValue) {
                            EventName = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.length < 4) {
                              return 'Should be more than than 4 Characters!';
                            }
                            return null;
                          },
                          enableSuggestions: false,
                          maxLines: 1,
                        ),
                        TextFormField(
                          maxLength: 300,
                          decoration: const InputDecoration(
                            label: Text('A Memorable Discription'),
                          ),
                          onSaved: (newValue) {
                            discription = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.length <= 10) {
                              return 'Your Discription is less than 10 Characters!';
                            }
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
                            if (value == null || value.length <= 10) {
                              return 'Your Discriped Story is less than 10 Characters!';
                            }
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
                                          if (value == null ||
                                              value.length <= 4) {
                                            return 'Your Name Should be Equal to 4 Characters or More!';
                                          }
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
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                        onPressed: () => validating(),
                        child: const Text('Save'))
                  ]),
            ],
          ),
        ));
  }
}
