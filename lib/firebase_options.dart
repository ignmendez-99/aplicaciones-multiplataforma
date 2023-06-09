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
    apiKey: 'AIzaSyDp0QCTPcDGDggnigEqgYgIkrS6IhayneE',
    appId: '1:849835430554:web:7524dc9828b07c035e4523',
    messagingSenderId: '849835430554',
    projectId: 'ser-manos-flutter',
    authDomain: 'ser-manos-flutter.firebaseapp.com',
    storageBucket: 'ser-manos-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoCbgbYeSy3otXdAz08ikvCVcyj4qa3WA',
    appId: '1:849835430554:android:705effc377b2b1ca5e4523',
    messagingSenderId: '849835430554',
    projectId: 'ser-manos-flutter',
    storageBucket: 'ser-manos-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk9OAj1l5GNz6VNey584zjNAl2EmBOpW8',
    appId: '1:849835430554:ios:b04eb93867ada9f75e4523',
    messagingSenderId: '849835430554',
    projectId: 'ser-manos-flutter',
    storageBucket: 'ser-manos-flutter.appspot.com',
    iosClientId: '849835430554-g9mb9edqa88h7coqk7theevpjfl9b2q4.apps.googleusercontent.com',
    iosBundleId: 'com.example.aplicacionesMultiplataforma',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBk9OAj1l5GNz6VNey584zjNAl2EmBOpW8',
    appId: '1:849835430554:ios:b04eb93867ada9f75e4523',
    messagingSenderId: '849835430554',
    projectId: 'ser-manos-flutter',
    storageBucket: 'ser-manos-flutter.appspot.com',
    iosClientId: '849835430554-g9mb9edqa88h7coqk7theevpjfl9b2q4.apps.googleusercontent.com',
    iosBundleId: 'com.example.aplicacionesMultiplataforma',
  );
}
