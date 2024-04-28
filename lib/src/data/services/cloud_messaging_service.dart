// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// class CloudMessagingService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

//   void configureFirebaseMessaging() async {
//     // Initialize flutter_local_notifications
//     await AwesomeNotifications().initialize(null,
//       [
//         NotificationChannel(
//           channelGroupKey: 'notify_group',
//           channelKey: 'basic_channel',
//           channelName: 'Basic notifications',
//           channelDescription: 'Notification channel for basic notifications',

//         )
//       ],
//       channelGroups: [
//         // NotificationChannelGroup(
//         //     channelGroupKey: 'notify_group',
//         //     channelGroupName: 'push notify group',
//         //
//         //
//         // )
//       ]
//     );

//     bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
//     if(!isAllowedToSendNotification){
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }


//     // Request device token
//     String? deviceToken = await _firebaseMessaging.getToken();
//     print(">>>>>>>>>>deviceToken: $deviceToken");

//     // Subscribe to topic
//     _firebaseMessaging.subscribeToTopic('notifications');

//     // Configure Firebase Messaging callbacks
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       // Handle message when app is opened from background or terminated
//       showNotification(message);
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Handle message when app is in foreground
//       showNotification(message);
//     });

//     // Request permissions
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     // Configure notification presentation options
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   void showNotification(RemoteMessage message) async {
//     // Extract notification details
//     String title = message.notification?.title ?? '--';
//     String body = message.notification?.body ?? '--';
//     String image = message.notification?.android?.imageUrl??'--';
//     print(">>>>>>>>>>>>>$image");
//     int id =1;
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: id+=1,
//         channelKey: 'basic_channel',
//         title: title,
//         body: body,
//         bigPicture: image,
//         notificationLayout: NotificationLayout.BigPicture


//       ),

//     );
//     Get.snackbar(
//         backgroundColor: Colors.grey.shade200,
//         colorText: Colors.black,
//         title,
//         body,
//         onTap: (snack) {
//           var messageData = message;
//           // if (messageData.data['orderId']!=null) {
//           //   // Xử lý khi người dùng nhấn vào thông báo
//           //
//           // }

//         },
//         icon: Image.asset("assets/images/tmart.png")
//     );
//     // Build notification


//   }
// }
