import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/UI/verifynumber.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPhoneNumber extends StatefulWidget {
  const MyPhoneNumber({super.key});

  @override
  State<MyPhoneNumber> createState() => _MyPhoneNumberState();
}

class _MyPhoneNumberState extends State<MyPhoneNumber> {
  final phonenumer = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with phone '),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          TextFormField(
            controller: phonenumer,
            // keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '+12345',
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundBut(
              title: 'Login',
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                _auth.verifyPhoneNumber(
                  phoneNumber: phonenumer.text,
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    Utills().ToastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                  codeSent: (String verificationID, int? token) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => VerifyMyNumber(
                                  verificationID: verificationID,
                                )));
                  },
                  codeAutoRetrievalTimeout: (e) {
                    setState(() {
                      loading = false;
                    });
                    Utills().ToastMessage(e.toString());
                  },
                );
              })
        ]),
      ),
    );
  }
}
