import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions webStaging = FirebaseOptions(
    apiKey: 'AIzaSyDnAB_UfQrBp_6RxBpn51s0BMfX3vV5a5U',
    appId: '1:441627736227:web:c3f6f3ef5ec03f9ca66716',
    messagingSenderId: '441627736227',
    projectId: 'flutter-base-beta',
    authDomain: 'flutter-base-beta.firebaseapp.com',
    storageBucket: 'flutter-base-beta.appspot.com',
  );

  static const FirebaseOptions webProd = FirebaseOptions(
    apiKey: 'AIzaSyDnAB_UfQrBp_6RxBpn51s0BMfX3vV5a5U',
    appId: '1:441627736227:web:c3f6f3ef5ec03f9ca66716',
    messagingSenderId: '441627736227',
    projectId: 'flutter-base-beta',
    authDomain: 'flutter-base-beta.firebaseapp.com',
    storageBucket: 'flutter-base-beta.appspot.com',
  );
}
