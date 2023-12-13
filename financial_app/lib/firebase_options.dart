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
    apiKey: 'AIzaSyCsQ_QqecNhGO2UXsACTj2rkS3JZirwyj8',
    appId: '1:14259205782:web:843a321378e812235af4b7',
    messagingSenderId: '14259205782',
    projectId: 'galaxyray-e2f37',
    authDomain: 'galaxyray-e2f37.firebaseapp.com',
    storageBucket: 'galaxyray-e2f37.appspot.com',
    measurementId: 'G-JVRFB0H6ZM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ9KZEG8DzJoJGeddWVQJtTZEDhZ_VH64',
    appId: '1:14259205782:android:c9940a9e8a64c6355af4b7',
    messagingSenderId: '14259205782',
    projectId: 'galaxyray-e2f37',
    storageBucket: 'galaxyray-e2f37.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_SSpNJHcBvSmkw1zbfaQkcHqxHLKr5m0',
    appId: '1:14259205782:ios:2d41a74e178f6e7f5af4b7',
    messagingSenderId: '14259205782',
    projectId: 'galaxyray-e2f37',
    storageBucket: 'galaxyray-e2f37.appspot.com',
    iosBundleId: 'com.example.financialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_SSpNJHcBvSmkw1zbfaQkcHqxHLKr5m0',
    appId: '1:14259205782:ios:63b48be50440f91b5af4b7',
    messagingSenderId: '14259205782',
    projectId: 'galaxyray-e2f37',
    storageBucket: 'galaxyray-e2f37.appspot.com',
    iosBundleId: 'com.example.financialApp.RunnerTests',
  );
}