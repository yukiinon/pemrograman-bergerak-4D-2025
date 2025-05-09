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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDh9BlabYOvplukdR165knNnsGd5yqQCOM',
    appId: '1:399881380895:web:3b80a765ea24d5169be12a',
    messagingSenderId: '399881380895',
    projectId: 'jurnal-mood-harian',
    authDomain: 'jurnal-mood-harian.firebaseapp.com',
    storageBucket: 'jurnal-mood-harian.firebasestorage.app',
    measurementId: 'G-9GDE9XV2WT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBf04TgpjJ8eeuZUipBChUCesnxXyk0uuA',
    appId: '1:399881380895:android:89253436e4aa53809be12a',
    messagingSenderId: '399881380895',
    projectId: 'jurnal-mood-harian',
    storageBucket: 'jurnal-mood-harian.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDF8vrCAy6o43qBzAmJclhBNeheVD6Mq9g',
    appId: '1:399881380895:ios:3b6a4f7f21ede7ba9be12a',
    messagingSenderId: '399881380895',
    projectId: 'jurnal-mood-harian',
    storageBucket: 'jurnal-mood-harian.firebasestorage.app',
    iosBundleId: 'com.example.jurnalMoodHarian',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDF8vrCAy6o43qBzAmJclhBNeheVD6Mq9g',
    appId: '1:399881380895:ios:3b6a4f7f21ede7ba9be12a',
    messagingSenderId: '399881380895',
    projectId: 'jurnal-mood-harian',
    storageBucket: 'jurnal-mood-harian.firebasestorage.app',
    iosBundleId: 'com.example.jurnalMoodHarian',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDh9BlabYOvplukdR165knNnsGd5yqQCOM',
    appId: '1:399881380895:web:186cb1d9f890959e9be12a',
    messagingSenderId: '399881380895',
    projectId: 'jurnal-mood-harian',
    authDomain: 'jurnal-mood-harian.firebaseapp.com',
    storageBucket: 'jurnal-mood-harian.firebasestorage.app',
    measurementId: 'G-11H0KMQVQ1',
  );

}