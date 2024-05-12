import 'package:complete_firebase/UI/login.dart';
import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySign extends StatefulWidget {
  const MySign({super.key});

  @override
  State<MySign> createState() => _MyLoginState();
}

class _MyLoginState extends State<MySign> {
  bool loading = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void signup() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: emailcontroller.text.toString(),
              password: passwordcontroller.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utills().ToastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    decoration:
                        const InputDecoration(label: Text('Enter Email')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter value ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    decoration:
                        const InputDecoration(label: Text('Enter password')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter value ';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundBut(
                title: 'Sign Up',
                loading: loading,
                ontap: () {
                  signup();
                }),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyLogin()));
                },
                child: const Text(
                    'If You  Have AN ACOUNT then click here for Login'))
          ],
        ),
      ),
    );
  }
}
