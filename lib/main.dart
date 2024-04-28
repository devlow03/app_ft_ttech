import 'package:app_ft_tmart/src/core/xcolor.dart';
import 'package:app_ft_tmart/src/core/dependency_injections.dart';
import 'package:app_ft_tmart/src/modules/splash/splash_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// SharedPreferences? pre;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjections().dependencies();// fix lỗi dependency injection - SharedPreferences
  // await Firebase.initializeApp(

  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // final CloudMessagingService cloudMessagingService = CloudMessagingService();
  // cloudMessagingService.configureFirebaseMessaging();
  // if(!kDebugMode) {
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.playIntegrity,
  //     appleProvider: AppleProvider.appAttest,
  //     webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   );
  // } else {
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.debug,
  //     appleProvider: AppleProvider.debug,
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
      defaultTransition: Transition.rightToLeft,
      //  useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'TMart',
      theme: ThemeData(
        primaryColorDark: XColor.primary,
        primaryColorLight: XColor.primary,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white
        ),
        // colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white,primarySwatch: XColor.primary,backgroundColor: Colors.white,cardColor: Colors.white,brightness: Brightness.light,errorColor: Colors.red),
        indicatorColor: XColor.primary,
        dialogBackgroundColor: Colors.white,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.grey,
          circularTrackColor: XColor.primary,
          refreshBackgroundColor: Colors.white,linearTrackColor: XColor.primary

        ),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: XColor.primary,backgroundColor: Colors.white),
        primaryColor: XColor.primary,
          fontFamily: 'Helvetica',
        primarySwatch: XColor.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: XColor.primary,
          iconTheme: const IconThemeData(
            color: Colors.black
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,

          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
              color: MaterialStateColor.resolveWith((states) => XColor.primary)
            ))
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => XColor.primary,),
            textStyle: MaterialStateProperty.resolveWith((states) => const TextStyle(
                color: Colors.white
            ))
          )
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: XColor.primary,

        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(

          backgroundColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
              fontWeight: FontWeight.w400
          ),
          selectedItemColor: XColor.primary,
          unselectedItemColor: Colors.grey,
          // showUnselectedLabels: true,
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,


        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.white
        )
        // buttonColor: XColor.primary,

      ),
      home: const SplashPage(),
      
    );
  }
}


