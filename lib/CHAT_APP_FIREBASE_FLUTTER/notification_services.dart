import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPermesion() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      criticalAlert: true,
      carPlay: true,
      sound: true,
      badge: true,
      provisional: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permession ');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted Provisional permession ');
    } else {
      print('User didnot agre with the system ');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token!;
  }

  void refreshToken() async {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      print('REfresh');
    });
  }

  void Firebasinit() {
    FirebaseMessaging.onMessage.listen((messages) {
      print(messages.notification!.title.toString());
      print(messages.notification!.body.toString());
      var andriodintializer =
          const AndroidInitializationSettings('@mipmap/ic_launcher.png');
      var iosintializer = const DarwinInitializationSettings();
      var intializationsetting = InitializationSettings(
        android: andriodintializer,
        iOS: iosintializer,
      );
      showNotification(messages);
    });
  }

  void initlocalnotification(
      BuildContext context, RemoteMessage message) async {
    var andriodintializer =
        const AndroidInitializationSettings('@mipmap/ic_launcher.png');
    var iosintializer = const DarwinInitializationSettings();
    var intializationsetting = InitializationSettings(
      android: andriodintializer,
      iOS: iosintializer,
    );
    await _localNotificationsPlugin.initialize(intializationsetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(), 'Maxi importance ',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'channel description ',
      priority: Priority.high,
      importance: Importance.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _localNotificationsPlugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }
}
