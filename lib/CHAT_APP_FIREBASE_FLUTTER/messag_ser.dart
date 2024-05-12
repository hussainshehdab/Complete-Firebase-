import 'package:complete_firebase/CHAT_APP_FIREBASE_FLUTTER/local-noti.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingServiceFCM {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init() async {
    _fcm.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
      LocalNotificationService.initialize();
    });
  }
}
