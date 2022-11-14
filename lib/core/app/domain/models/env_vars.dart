import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVars implements IEnvVars {
  @override
  String get apiUrl => dotenv.env["API_URL"] ?? "";

  @override
  String get sentryDSN => dotenv.env["SENTRY_DSN"] ?? "";

  @override
  String get environment => dotenv.env["ENVIRONMENT"] ?? "";
}
