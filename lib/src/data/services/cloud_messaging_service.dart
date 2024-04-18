import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CloudMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void configureFirebaseMessaging() async {
    // Initialize flutter_local_notifications
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {

      },
      onDidReceiveNotificationResponse: (details) {

      },
    );

    // Request device token
    String? deviceToken = await _firebaseMessaging.getToken();
    print(">>>>>>>>>>deviceToken: $deviceToken");

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

    // Build notification
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',

      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: AndroidNotificationDetails("1", "a"));
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: message.data['orderId'], // Optional payload
    );
  }
}
