// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBxClCMhEAlg3HPIyvGorfkcuO8jq_mFjA',
    appId: '1:224644799035:web:2a728a30adf2851d891a1e',
    messagingSenderId: '224644799035',
    projectId: 'visitor-authorization-system',
    authDomain: 'visitor-authorization-system.firebaseapp.com',
    storageBucket: 'visitor-authorization-system.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2ybE9TeDkqMz8T4-xTLL_IUg7i-aqcx0',
    appId: '1:224644799035:android:bc7b1fc12eb942eb891a1e',
    messagingSenderId: '224644799035',
    projectId: 'visitor-authorization-system',
    storageBucket: 'visitor-authorization-system.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_FPD4QCgwhPoEe_a8_Ak6nUzy-0MGlSI',
    appId: '1:224644799035:ios:787cdc97b4199bbb891a1e',
    messagingSenderId: '224644799035',
    projectId: 'visitor-authorization-system',
    storageBucket: 'visitor-authorization-system.appspot.com',
    iosBundleId: 'com.example.fyp',
  );
}
