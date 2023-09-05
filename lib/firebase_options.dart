// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDk1szLmBThWaKkZXsXJ_x1XJa7UXuuDGM',
    appId: '1:392911829696:web:36543541b33e0fe7744b25',
    messagingSenderId: '392911829696',
    projectId: 'apptmart-9ff47',
    authDomain: 'apptmart-9ff47.firebaseapp.com',
    storageBucket: 'apptmart-9ff47.appspot.com',
    measurementId: 'G-W5N4BZ7QP7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqTAMGGG3VXVRHbuVfq5YM7GrqPnCqzJM',
    appId: '1:392911829696:android:af88031f3dc18343744b25',
    messagingSenderId: '392911829696',
    projectId: 'apptmart-9ff47',
    storageBucket: 'apptmart-9ff47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbcbM-3cz_UgXyi9oUCmdHfKt0fx_pAaA',
    appId: '1:392911829696:ios:435233d41e5c8d3e744b25',
    messagingSenderId: '392911829696',
    projectId: 'apptmart-9ff47',
    storageBucket: 'apptmart-9ff47.appspot.com',
    iosClientId: '392911829696-dnan608o5cfneclh8h4akh3f8bvcq7ia.apps.googleusercontent.com',
    iosBundleId: 'com.example.appFtTmart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbcbM-3cz_UgXyi9oUCmdHfKt0fx_pAaA',
    appId: '1:392911829696:ios:3e3b97d7b7a08f6a744b25',
    messagingSenderId: '392911829696',
    projectId: 'apptmart-9ff47',
    storageBucket: 'apptmart-9ff47.appspot.com',
    iosClientId: '392911829696-91arnd03hpmv7lhnpghj4gnu2ucbd5v2.apps.googleusercontent.com',
    iosBundleId: 'com.example.appFtTmart.RunnerTests',
  );
}