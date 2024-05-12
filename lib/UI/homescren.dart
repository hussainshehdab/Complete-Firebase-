import 'package:complete_firebase/UI/addpost.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MyHomeScre extends StatefulWidget {
  const MyHomeScre({super.key});

  @override
  State<MyHomeScre> createState() => _MyHomeScreState();
}

class _MyHomeScreState extends State<MyHomeScre> {
  final ref = FirebaseDatabase.instance.ref('Post');
  final filtercontroller = TextEditingController();
  final showcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: filtercontroller,
              decoration: const InputDecoration(
                label: Text('Search'),
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                defaultChild: const Text('loading '),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (filtercontroller.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    Utills()
                                        .ToastMessage('Deleted Sucessfully');
                                  });
                                  Navigator.pop(context);
                                  ref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                title: const Text('Delete'),
                                leading: const Icon(Icons.delete),
                              )),
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMydialog(title,
                                      snapshot.child('id').value.toString());
                                },
                                title: const Text('Edit'),
                                leading: const Icon(Icons.edit),
                              ))
                        ],
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                      filtercontroller.text.toLowerCase().toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyAddPost()));
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
                    ref.child(id).update({
                      'title': showcont.text.toLowerCase(),
                    }).then((value) {
                      Utills().ToastMessage('Updated');
                    }).onError((error, stackTrace) {
                      Utills().ToastMessage(error.toString());
                    });
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
