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
    apiKey: 'AIzaSyCruy7I-UMvTqZQHs42agWh-6GSUpGf974',
    appId: '1:117161893776:web:518d6c4cd969db99171d15',
    messagingSenderId: '117161893776',
    projectId: 'appfttmart-3c6e3',
    authDomain: 'appfttmart-3c6e3.firebaseapp.com',
    storageBucket: 'appfttmart-3c6e3.appspot.com',
    measurementId: 'G-DB47TVZ67Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoK31BiMdLQekQFCxh_L2YSUNqGVC1MmY',
    appId: '1:117161893776:android:ce2f1df2bc8cf095171d15',
    messagingSenderId: '117161893776',
    projectId: 'appfttmart-3c6e3',
    storageBucket: 'appfttmart-3c6e3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLRvYlSOoHgpk1Z4lIk8TXGS-dkiL3r2s',
    appId: '1:117161893776:ios:8111ca13f58b5f08171d15',
    messagingSenderId: '117161893776',
    projectId: 'appfttmart-3c6e3',
    storageBucket: 'appfttmart-3c6e3.appspot.com',
    iosBundleId: 'com.example.appFtTmart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLRvYlSOoHgpk1Z4lIk8TXGS-dkiL3r2s',
    appId: '1:117161893776:ios:8a0ce835341fafcd171d15',
    messagingSenderId: '117161893776',
    projectId: 'appfttmart-3c6e3',
    storageBucket: 'appfttmart-3c6e3.appspot.com',
    iosBundleId: 'com.example.appFtTmart.RunnerTests',
  );
}
