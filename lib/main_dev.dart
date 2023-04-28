import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_base/firebase_options.dart';
import 'package:flutter_base/setup.dart';

void main() async {
  startApp(
    firebaseOptions: kIsWeb ? DefaultFirebaseOptions.webStaging : null,
  );
}
