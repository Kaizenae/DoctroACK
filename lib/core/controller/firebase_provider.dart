import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationListenerProvider {
  void getMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification notification = event.notification!;

      try {
        sendNotification(
            hashCode: notification.hashCode,
            title: notification.title!,
            body: notification.body);
        // ignore: empty_catches
      } catch (e) {}

      ///Show Alert dialog
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: Text(notification.title!),
      //         content: Text(notification.body!),
      //       );
      //     });
    });
  }
}

void sendNotification({int? hashCode, String? title, String? body}) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ////Set the settings for various platform
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'hello',
  );
  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    // onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
  );

  ///
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_channel', 'Reservation',
      description: "This channel is for important Reservation notification",
      importance: Importance.max);

  flutterLocalNotificationsPlugin.show(
    hashCode!,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(channel.id, channel.name,
          channelDescription: channel.description),
    ),
  );
}
