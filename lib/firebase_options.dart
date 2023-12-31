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
    apiKey: 'AIzaSyDXXV_DP1EoLMTr5-XMfTCHcz2K-B0GTMk',
    appId: '1:75276225446:web:060f960db5d94ec955dd67',
    messagingSenderId: '75276225446',
    projectId: 'uts-h1d021020',
    authDomain: 'uts-h1d021020.firebaseapp.com',
    storageBucket: 'uts-h1d021020.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoBU1DutcpqHy6lQBQyHiKBQ0qfWktWpg',
    appId: '1:75276225446:android:73d7d632f707bdcd55dd67',
    messagingSenderId: '75276225446',
    projectId: 'uts-h1d021020',
    storageBucket: 'uts-h1d021020.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClJRO3lTYANl_QUbw9HKv-31sBAkMCRMg',
    appId: '1:75276225446:ios:9d8f9ff6c498e1e555dd67',
    messagingSenderId: '75276225446',
    projectId: 'uts-h1d021020',
    storageBucket: 'uts-h1d021020.appspot.com',
    iosBundleId: 'com.example.firebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClJRO3lTYANl_QUbw9HKv-31sBAkMCRMg',
    appId: '1:75276225446:ios:2eee449923510ad855dd67',
    messagingSenderId: '75276225446',
    projectId: 'uts-h1d021020',
    storageBucket: 'uts-h1d021020.appspot.com',
    iosBundleId: 'com.example.firebase.RunnerTests',
  );
}
