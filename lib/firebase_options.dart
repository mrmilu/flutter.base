import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions webStaging = FirebaseOptions(
    apiKey: 'AIzaSyD8-HkMTx3HhfSZ3mcfsIfwjwIU6bnhDeM',
    authDomain: 'flutter-base-1e320.firebaseapp.com',
    projectId: 'flutter-base-1e320',
    storageBucket: 'flutter-base-1e320.appspot.com',
    messagingSenderId: '426720039629',
    appId: '1:426720039629:web:5f22b405b4923353fa0f84',
  );

  static const FirebaseOptions webProd = FirebaseOptions(
    apiKey: 'AIzaSyB_Pw-tffIISl8HSD0Fx_xmTz4FA7oFAqo',
    authDomain: 'flutter-base-live.firebaseapp.com',
    projectId: 'flutter-base-live',
    storageBucket: 'flutter-base-live.appspot.com',
    messagingSenderId: '795134483527',
    appId: '1:795134483527:web:01d7f2ac638dcad5fa6562',
  );
}
