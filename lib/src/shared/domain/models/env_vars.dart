import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../interfaces/i_env_vars.dart';

class EnvVars implements IEnvVars {
  @override
  String get apiUrl => dotenv.env['API_URL_RELEASE'] ?? '';

  @override
  String get sentryDSN => dotenv.env['SENTRY_DSN'] ?? '';

  @override
  String get environment => dotenv.env['ENVIRONMENT'] ?? '';

  @override
  String get appId => dotenv.env['APP_ID'] ?? '';

  @override
  String get appName => dotenv.env['APP_NAME'] ?? '';

  @override
  String get dynamicLinkHost => dotenv.env['DYNAMIC_LINK_HOST'] ?? '';

  @override
  String get afDevKey => dotenv.env['AF_DEV_KEY'] ?? '';

  @override
  String get appIdAndroid => dotenv.env['APP_ID_ANDROID'] ?? '';

  @override
  String get appIdIOS => dotenv.env['APP_ID_IOS'] ?? '';

  @override
  String get firebaseClientIdAndroid =>
      dotenv.env['FIREBASE_CLIENT_ID_ANDROID'] ?? '';

  @override
  String get firebaseClientIdIOS => dotenv.env['FIREBASE_CLIENT_ID_IOS'] ?? '';

  @override
  String get firebaseReversedClientId =>
      dotenv.env['FIREBASE_REVERSED_CLIENT_ID'] ?? '';
}
