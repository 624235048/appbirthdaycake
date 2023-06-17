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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBaFClRoOxkiAykfaRLjguelZ23WyOtu1s',
    appId: '1:918818936829:web:e6a138b19aed08b21eab94',
    messagingSenderId: '918818936829',
    projectId: 'appbirthdaycake',
    authDomain: 'appbirthdaycake.firebaseapp.com',
    storageBucket: 'appbirthdaycake.appspot.com',
    measurementId: 'G-93GV21XW1K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBupWS5cd0nStCN4XlmF3-W9L7SCHs_BpE',
    appId: '1:918818936829:android:eef68014a152e41d1eab94',
    messagingSenderId: '918818936829',
    projectId: 'appbirthdaycake',
    storageBucket: 'appbirthdaycake.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCstovMdzFr0O0fW9VmbxSJM_Yo9hQ625g',
    appId: '1:918818936829:ios:5dfb0f2d81ffdabf1eab94',
    messagingSenderId: '918818936829',
    projectId: 'appbirthdaycake',
    storageBucket: 'appbirthdaycake.appspot.com',
    iosClientId: '918818936829-0cqd4kpprlrq31qgdbk26fp9jendklr4.apps.googleusercontent.com',
    iosBundleId: 'com.example.appbirthdaycake',
  );
}