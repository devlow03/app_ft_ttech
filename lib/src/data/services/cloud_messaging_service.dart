import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_logic.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudMessagingService {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final notificationLogic = Get.put(NotificationLogic());
  void configureFirebaseMessaging() async {
    // Initialize flutter_local_notifications
    await AwesomeNotifications().initialize(null,
      [
        NotificationChannel(
          playSound: true,

          channelShowBadge: true,
          criticalAlerts: true,
          importance: NotificationImportance.Max,
          channelGroupKey: 'notify_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',

        )
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'notify_group',
            channelGroupName: 'push notify group',


        )
      ]
    );

    bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
    if(!isAllowedToSendNotification){
      AwesomeNotifications().requestPermissionToSendNotifications();
    }




    // Request device token
    String? deviceToken = await _firebaseMessaging.getToken();
    print(">>>>>>>>>>deviceToken: $deviceToken");
     final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(GlobalData.deviceToken, deviceToken??"");
    // Subscribe to topic
    _firebaseMessaging.subscribeToTopic('notifications');

    // Configure Firebase Messaging callbacks
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle message when app is opened from background or terminated
      showNotification(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle message when app is in foreground
      showNotification(message);
    });

    Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      showNotification(message);
    }
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );





    // Request permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Configure notification presentation options
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showNotification(RemoteMessage message) async {
    // Extract notification details
    String title = message.notification?.title ?? '--';
    String body = message.notification?.body ?? '--';
    String image = message.notification?.android?.imageUrl??'--';
    print(">>>>>>>>>>>>>$image");
    int id =1;
    await AwesomeNotifications().createNotification(
      // schedule:NotificationInterval(
      //   interval: 2,
      //   timeZone:
      //   await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      //   preciseAlarm: true,
      // ),
      content: NotificationContent(
        id: id+=1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        bigPicture: image,
        notificationLayout: NotificationLayout.BigPicture,
        largeIcon: "assets/images/tmart.png",
        showWhen: true



      ),

    );
   await  AwesomeNotifications().shouldShowRationaleToRequest();
   notificationLogic.getNotification();
    // Get.snackbar(
    //     borderRadius: null,
    //     // backgroundColor: Colors.white,
    //     colorText: Colors.black,
    //     title,
    //     body,
    //     onTap: (snack) {
    //       var messageData = message;
    //       // if (messageData.data['orderId']!=null) {
    //       //   // Xử lý khi người dùng nhấn vào thông báo
    //       //
    //       // }
    //
    //     },
    //     icon: Image.network(image)
    // );
    // Build notification


  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {

    }
  }
}
