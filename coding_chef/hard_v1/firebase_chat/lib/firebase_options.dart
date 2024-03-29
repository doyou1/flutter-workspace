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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4rVu9s12mFpHEvpE74MP7TosVV_-Y7w4',
    appId: '1:159575364074:android:2f18cc869d4a85fa5b2293',
    messagingSenderId: '159575364074',
    projectId: 'flutter-chat-app-d5dce',
    databaseURL: 'https://flutter-chat-app-d5dce-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-chat-app-d5dce.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqJQC7c8U74yOEkFRy2QRSgzrMVlQggNU',
    appId: '1:159575364074:ios:371089a27c1c2b5e5b2293',
    messagingSenderId: '159575364074',
    projectId: 'flutter-chat-app-d5dce',
    databaseURL: 'https://flutter-chat-app-d5dce-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-chat-app-d5dce.appspot.com',
    iosClientId: '159575364074-s463hj1bspgv3iaejr8eb45qskrdfdgf.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseChat',
  );
}
