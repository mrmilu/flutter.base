import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';

class EnvVars implements IEnvVars {
  @override
  String get apiUrl => const String.fromEnvironment('API_URL');

  @override
  String get sentryDSN => const String.fromEnvironment('SENTRY_DSN');

  @override
  String get environment => const String.fromEnvironment('ENVIRONMENT');
}
