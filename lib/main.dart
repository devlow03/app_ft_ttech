import 'dart:async';
import 'dart:io';

import 'package:app_ft_tmart/src/core/global_data.dart';
import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/core/dependency_injections.dart';
import 'package:app_ft_tmart/src/modules/index/index_view.dart';
import 'package:app_ft_tmart/src/modules/notification/notification_view.dart';
import 'package:app_ft_tmart/src/modules/order_history/order_detail/order_detail_view.dart';
import 'package:app_ft_tmart/src/modules/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';
// SharedPreferences? pre;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjections().dependencies();// fix lỗi dependency injection - SharedPreferences
  await Firebase.initializeApp(
    
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider(GlobalData.reCapChaKey),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
        // your preferred provider. Choose from:
        // 1. Debug provider
        // 2. Device Check provider
        // 3. App Attest provider
        // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(GlobalData.fCmToken,"${await FirebaseMessaging.instance.getToken()}");
  print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>${await FirebaseMessaging.instance.getToken()}");
  FirebaseMessaging.instance.subscribeToTopic('notifications');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String title = message.notification?.title ?? '--';
    String body = message.notification?.body ?? '--';
    

    Get.snackbar(
      backgroundColor: Colors.grey.shade200,
      colorText: Colors.black,
      title,
      body,
      onTap: (snack) {
        var messageData = message;
        if (messageData.data['orderId']!=null) {
          // Xử lý khi người dùng nhấn vào thông báo
          Get.to(OrderDetailPage(id: messageData.data['orderId'],));
        }
       
      },
      icon: Image.asset("assets/images/tmart.png")
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['orderId']!=null) {
          // Xử lý khi người dùng nhấn vào thông báo
          Get.to(OrderDetailPage(id: message.data['orderId'],));
        }
      // Xử lý sự kiện khi ứng dụng được mở từ thông báo
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,


  );

  
  // if (Platform.isIOS || true) {
  //   iosSubscription = FirebaseMessaging.onMessage.listen((data) {
  //     Get.snackbar("Thông báo", "Bạn vừa có thông báo mới");
  //   });

  //   FirebaseMessaging.instance.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // }
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //  useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'TMart',
      theme: ThemeData(
          fontFamily: 'Helvetica',
        primarySwatch: XColor.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: XColor.primary,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,

          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(

          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
              fontWeight: FontWeight.w400
          ),
          selectedItemColor: XColor.primary,
          unselectedItemColor: Colors.black,
          // showUnselectedLabels: true,
        )
        // buttonColor: XColor.primary,

      ),
      home: SplashPage(),
      
    );
  }
}


