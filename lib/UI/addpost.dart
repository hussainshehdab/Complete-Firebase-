import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyAddPost extends StatefulWidget {
  const MyAddPost({super.key});

  @override
  State<MyAddPost> createState() => _MyAddPostState();
}

class _MyAddPostState extends State<MyAddPost> {
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('Post');
  final postcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add post'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: postcont,
              decoration: const InputDecoration(
                  hintMaxLines: 5,
                  border: OutlineInputBorder(),
                  hintText: 'Whats in your mind '),
            ),
            SizedBox(
              height: 20,
            ),
            RoundBut(
                title: 'Add',
                loading: loading,
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  databaseref.child(id).set({
                    'title': postcont.text.toString(),
                    'id': id,
                  }).then((value) {
                    Utills().ToastMessage('Post added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utills().ToastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
