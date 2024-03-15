import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/route_path.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  initNotification() async {
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      await firebaseMessaging.requestPermission();
      // final token = await firebaseMessaging.getToken();

      firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {}
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        showLog(message.data.toString());
      });

      FirebaseMessaging.onBackgroundMessage(notificationHander);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showLog('Message data: ${message.data}');
        if (message.notification != null) {
          showLog(
              'Message also contained a notification: ${message.notification}');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> notificationHander(RemoteMessage message) async {
    BuildContext context = NavigatorState().context;
    Navigator.pushNamed(context, notificationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Notification'));
  }
}
