// import 'dart:async';

// import 'package:doctor_ack/core/controller/database_helper.dart';
// import 'package:doctor_ack/core/utils/packages_imprts.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../general_models/notify_model.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await setupFlutterNotifications();
//   initFcm();
// }

// late AndroidNotificationChannel channel;

// bool isFlutterLocalNotificationsInitialized = false;

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'Reservation', // id
//     'Reservation Notifications', // title
//     description:
//         'This channel is used for important Reservation notifications.', // description
//     importance: Importance.high,
//   );

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// Future<void> onBackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   if (message.data.containsKey('data')) {
//     // Handle data message
//   }

//   if (message.data.containsKey('notification')) {
//     // Handle notification message
//   }
//   // Or do other work.
// }

// void showFlutterNotification(RemoteMessage message) async {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null && !kIsWeb) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           //      one that already exists in example app.
//           icon: '@mipmap/launcher_icon',
//         ),
//       ),
//     );

//     NotifyModel model = NotifyModel(
//       id: notification.hashCode,
//       title: notification.title ?? "",
//       body: notification.body ?? "",
//       time: DateFormat('h:mm a').format(message.sentTime!).toString(),
//     );
//     await DatabaseHelper.insertNotification(model);
//   }
// }

// String? initialMessage;
// bool resolved = false;
// void initFcm() async {
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.requestNotificationsPermission();
//   final firebaseMessaging = FCM();
//   firebaseMessaging.setNotifications();

// /*  FirebaseMessaging.instance.getInitialMessage().then(
//         (value) => setState(
//           () {
//         resolved = true;
//         initialMessage = value?.data.toString();
//         if (initialMessage != null) {
//           // var route = NavigationHistoryObserver().top;
//           // if(route!=null && route.settings.name!=NotificationScreen.routeName){
//           //   NavigationService.navigatorKey.currentState?.pushNamed(NotificationScreen.routeName);
//           // }
//         }
//       },
//     ),
//   );*/

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     showFlutterNotification(message);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     // var route = NavigationHistoryObserver().top;
//     // if(route!=null && route.settings.name!=NotificationScreen.routeName){
//     //   NavigationService.navigatorKey.currentState?.pushNamed(NotificationScreen.routeName);
//     // }
//   });
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('ic_launcher');
//   final DarwinInitializationSettings initializationSettingsDarwin =
//       DarwinInitializationSettings(
//           onDidReceiveLocalNotification: (id, title, body, payload) {
//     if (payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//   });
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin);
//   flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
// }

// void onDidReceiveNotificationResponse(
//     NotificationResponse notificationResponse) async {
//   //when user click on notification this method call
//   /* var route = NavigationHistoryObserver().top;
//     if(route!=null && route.settings.name!=NotificationScreen.routeName){
//       NavigationService.navigatorKey.currentState?.pushNamed(NotificationScreen.routeName).then((value) {
//         FBroadcast.instance().broadcast(
//           "update_count",
//           value: 0,
//         );
//       });
//     }
//     else{
//       NavigationService.navigatorKey.currentState?.pushReplacementNamed(NotificationScreen.routeName).then((value) {
//         FBroadcast.instance().broadcast(
//           "update_count",
//           value: 0,
//         );
//       });
//     }*/
// }

// void sendNotification() async {
//   // await FirebaseMessaging.instance.sendMessage(
//   //   messageId: ,
//   //   messageType: ,
//   //   data: ,
//   //   to: ,
//   //   ttl:
//   // )
// }

// class FCM {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final streamCtlr = StreamController<String>.broadcast();
//   final titleCtlr = StreamController<String>.broadcast();
//   final bodyCtlr = StreamController<String>.broadcast();

//   setNotifications() {
//     FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

//     // handle when app in active state
//     forgroundNotification();

//     // handle when app running in background state
//     backgroundNotification();

//     // handle when app completely closed by the user
//     terminateNotification();

//     // With this token you can test it easily on your phone
//     _firebaseMessaging.getToken().then((token) async {});
//   }

//   forgroundNotification() {
//     FirebaseMessaging.onMessage.listen(
//       (message) async {
//         showFlutterNotification(message);

//         if (message.data.containsKey('data')) {
//           // Handle data message
//           streamCtlr.sink.add(message.data['data']);
//         }
//         if (message.data.containsKey('notification')) {
//           // Handle notification message
//           streamCtlr.sink.add(message.data['notification']);
//         }
//         // Or do other work.
//         titleCtlr.sink.add(message.notification!.title!);
//         bodyCtlr.sink.add(message.notification!.body!);
//         showFlutterNotification(message);
//       },
//     );
//   }

//   backgroundNotification() {
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (message) async {
//         if (message.data.containsKey('data')) {
//           // Handle data message
//           streamCtlr.sink.add(message.data['data']);
//         }
//         if (message.data.containsKey('notification')) {
//           // Handle notification message
//           streamCtlr.sink.add(message.data['notification']);
//         }
//         // Or do other work.
//         titleCtlr.sink.add(message.notification!.title!);
//         bodyCtlr.sink.add(message.notification!.body!);
//       },
//     );
//   }

//   terminateNotification() async {
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();

//     if (initialMessage != null) {
//       if (initialMessage.data.containsKey('data')) {
//         // Handle data message
//         streamCtlr.sink.add(initialMessage.data['data']);
//       }
//       if (initialMessage.data.containsKey('notification')) {
//         // Handle notification message
//         streamCtlr.sink.add(initialMessage.data['notification']);
//       }
//       // Or do other work.
//       titleCtlr.sink.add(initialMessage.notification!.title!);
//       bodyCtlr.sink.add(initialMessage.notification!.body!);
//     }
//   }

//   dispose() {
//     streamCtlr.close();
//     bodyCtlr.close();
//     titleCtlr.close();
//   }
// }
