import 'package:app_ft_tmart/src/core/config.dart';
import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/data/dependency_injections.dart';
import 'package:app_ft_tmart/src/module/index/index_view.dart';
import 'package:app_ft_tmart/src/module/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
// SharedPreferences? pre;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjections().dependencies();// fix lỗi dependency injection - SharedPreferences
  await Firebase.initializeApp(
    // name: Platform.isIOS ? null : 'gas-luxen',
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          unselectedItemColor: Colors.grey,
          // showUnselectedLabels: true,
        )
        // buttonColor: XColor.primary,

      ),
      home: SplashPage(),
    );
  }
}


