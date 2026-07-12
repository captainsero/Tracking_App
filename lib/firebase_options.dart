// File generated (by hand, mirroring the FlutterFire CLI output) to point
// the Tracking App at the SAME Firebase project as the Florista app
// (track-app-d33ab), so both apps read/write the same Firestore database.
//
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS yet. '
          'The Tracking App\'s iOS bundle id (com.example.trackingApp) has '
          'not been registered as an app in the track-app-d33ab Firebase '
          'project. Run `flutterfire configure --project=track-app-d33ab` '
          'from this app\'s root to register it and regenerate this file.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS yet. '
          'Run `flutterfire configure --project=track-app-d33ab` to add it.',
        );
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

  // Android app is already registered in the track-app-d33ab project
  // (package: com.example.tracking_app) — see android/app/google-services.json.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMpJ9T50h9c9rMqUYaB7zxqZ2-FPYOxRo',
    appId: '1:685078061318:android:f075dba71bb5e0e5de3e87',
    messagingSenderId: '685078061318',
    projectId: 'track-app-d33ab',
    storageBucket: 'track-app-d33ab.firebasestorage.app',
  );

  // Web isn't restricted by package/bundle id, so it's safe to reuse the
  // project's web app credentials here (same project = same Firestore).
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBEE4weQurlra1PhZFreVfPmvS9RKvpZAA',
    appId: '1:685078061318:web:1d10596f60be58b8de3e87',
    messagingSenderId: '685078061318',
    projectId: 'track-app-d33ab',
    authDomain: 'track-app-d33ab.firebaseapp.com',
    storageBucket: 'track-app-d33ab.firebasestorage.app',
    measurementId: 'G-58PRQ07DJ2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBEE4weQurlra1PhZFreVfPmvS9RKvpZAA',
    appId: '1:685078061318:web:b990f9d20ea4763dde3e87',
    messagingSenderId: '685078061318',
    projectId: 'track-app-d33ab',
    authDomain: 'track-app-d33ab.firebaseapp.com',
    storageBucket: 'track-app-d33ab.firebasestorage.app',
    measurementId: 'G-HEJGB89K0D',
  );
}
