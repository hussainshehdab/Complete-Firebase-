import 'package:complete_firebase/UI/homescren.dart';
import 'package:complete_firebase/UI/round_button.dart';
import 'package:complete_firebase/Utills_/error_handlin/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyMyNumber extends StatefulWidget {
  final verificationID;
  const VerifyMyNumber({super.key, required this.verificationID});

  @override
  State<VerifyMyNumber> createState() => _VerifyMyNumberState();
}

class _VerifyMyNumberState extends State<VerifyMyNumber> {
  bool loading = false;
  final verifynumber = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify '),
        centerTitle: true,
      ),
      body: Column(children: [
        TextFormField(
          controller: verifynumber,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '+12345',
          ),
        ),
        SizedBox(
          height: 30,
        ),
        RoundBut(
            title: 'Verify',
            loading: loading,
            ontap: () async {
              setState(() {
                loading = true;
              });
              final Credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationID,
                  smsCode: verifynumber.text.toString());
              try {
                await auth.signInWithCredential(Credential);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomeScre()));
              } catch (e) {
                setState(() {
                  loading = false;
                });
                Utills().ToastMessage(e.toString());
              }
            })
      ]),
    );
  }
}
