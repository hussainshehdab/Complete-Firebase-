import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:flutter/material.dart';

class AddFireStoreData extends StatefulWidget {
  const AddFireStoreData({super.key});

  @override
  State<AddFireStoreData> createState() => _AddFireStoreDataState();
}

class _AddFireStoreDataState extends State<AddFireStoreData> {
  bool loading = false;
  final datacontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add data to firestore'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: datacontroller,
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
                  firestore.doc(id).set({
                    'title': datacontroller.text.toString(),
                    'id': datacontroller.text.toString()
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utills().ToastMessage('data uploaded sucessfully');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utills().ToastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
