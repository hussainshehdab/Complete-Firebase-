import 'package:complete_firebase/CHAT_APP_FIREBASE_FLUTTER/notification_services.dart';
import 'package:flutter/material.dart';

class MyChatHome extends StatefulWidget {
  const MyChatHome({super.key});

  @override
  State<MyChatHome> createState() => _MyChatHomeState();
}

class _MyChatHomeState extends State<MyChatHome> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationServices.requestNotificationPermesion();
    notificationServices.getDeviceToken().then((value) {
      print('Token');
      print(value);
    });
    // notificationServices.refreshToken();
    // notificationServices.Firebasinit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
      ),
    );
  }
}
