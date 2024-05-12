import 'dart:io';

import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyUploadFileScreen extends StatefulWidget {
  const MyUploadFileScreen({super.key});

  @override
  State<MyUploadFileScreen> createState() => _MyUploadFileScreenState();
}

class _MyUploadFileScreenState extends State<MyUploadFileScreen> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _image;
  bool loading = false;
  final picker = ImagePicker();
  DatabaseReference databaseref = FirebaseDatabase.instance.ref('post');
  Future<void> getImagefromGallery() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        _image = File(PickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPload file'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getImagefromGallery();
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                ),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : Icon(Icons.browse_gallery_sharp),
              ),
            ),
            RoundBut(
                title: "Upload",
                loading: loading,
                ontap: () async {
                  setState(() {
                    loading = true;
                  });
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('ffolder' + "SHeh");
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_image!.absolute);
                  await Future.value(uploadTask).then((value) async {
                    var newurl = await ref.getDownloadURL();
                    String id =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    databaseref.child(id).set({
                      'title': newurl.toString(),
                    }).then((value) {
                      setState(() {
                        loading = false;
                      });
                      Utills().ToastMessage('Uploaded');
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utills().ToastMessage(error.toString());
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utills().ToastMessage(error.toString());
                  });
                }),
          ],
        ),
      ),
    );
  }
}
