import 'dart:async';

import 'package:flutter/material.dart';

import '../CHAT_APP_FIREBASE_FLUTTER/Chat_home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final auth = FirebaseAuth.instance;
  // final User = auth.currentUser;
  // if(User!=null){
  //   Timer(Duration(seconds: 20), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomeScre())));
  // }else{
  //       Timer(Duration(seconds: 20), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin())));

  // }
  // SplashServices splashscree = SplashServices();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyLogin()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'FIREBASE',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      )),
    );
  }
}
