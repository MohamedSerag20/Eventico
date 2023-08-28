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
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                            child: const Center(
                                child: Icon(
                              Icons.add_a_photo_outlined,
                              size: 80,
                            )))
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
            Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
              child: (imageF.isEmpty || imageF.length == 1)
                  ? InkWell(
                      onTap: () {},
                      child: Container(
                          height: 90,
                          width: 105,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 40,
                          )),
                    )
                  : Row(children: [
                      ...imageF
                          .sublist(1, imageF.length)
                          .map((e) => Container(
                              height: 90,
                              width: 105,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(e), fit: BoxFit.cover),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)))))
                          .toList(),
                      InkWell(
                        onTap: () {},
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
            )),
          ],
        ));
  }
}
