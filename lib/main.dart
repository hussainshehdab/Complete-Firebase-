import 'dart:io';

import 'package:complete_firebase/CHAT_APP_FIREBASE_FLUTTER/messag_ser.dart';
import 'package:complete_firebase/UI/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final messagingService = MessagingServiceFCM();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBfEpdQoos5jwy1Cy98BhPfu5vkmNCoU9Y",
              appId: "1:464122104680:android:8c3e6ff9c987a5333324dd",
              messagingSenderId: "464122104680",
              projectId: "asdfghjk-9d65d",
              storageBucket: "asdfghjk-9d65d.appspot.com"),
        )
      : await Firebase.initializeApp();
  messagingService.init();
  FirebaseMessaging.onBackgroundMessage(_firebasebackgroundhandler);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebasebackgroundhandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
