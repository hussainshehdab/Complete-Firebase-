import 'package:complete_firebase/UI/FORgot_Password.dart';
import 'package:complete_firebase/UI/homescren.dart';
import 'package:complete_firebase/UI/phonenum.dart';
import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/UI/signup.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((value) {
      Utills().ToastMessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomeScre()));
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utills().ToastMessage(error.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
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
                title: 'Login',
                ontap: () {
                  if (_formkey.currentState!.validate()) {
                    login();
                  } else {}
                }),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MySign()));
                },
                child: const Text(
                    'If You Donot Have AN ACOUNT then click here for signup')),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyPhoneNumber())),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Login with Firebase'),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyForgotPassword())),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('forget password'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
