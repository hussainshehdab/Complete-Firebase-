import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_firebase/fire_store_data.dart/add_firestore_data.dart';
import 'package:flutter/material.dart';

class MyHomeFireStore extends StatefulWidget {
  const MyHomeFireStore({super.key});

  @override
  State<MyHomeFireStore> createState() => _MyHomeFireStoreState();
}

class _MyHomeFireStoreState extends State<MyHomeFireStore> {
  final filtercontroller = TextEditingController();
  final showcont = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext conttext,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              ref
                                  .doc(snapshot.data!.docs[index]['id']
                                      .toString())
                                  .delete();
                            },
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle:
                                Text(snapshot.data!.docs[index].id.toString()),
                          );
                        }));
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddFireStoreData()));
      }),
    );
  }

  Future<void> showMydialog(String title, id) async {
    showcont.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: showcont,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Update")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel")),
            ],
          );
        });
  }
}
