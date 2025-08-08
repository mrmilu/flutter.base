import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'flavors.dart';
import 'src/shared/data/services/app_flyer_service.dart';
import 'src/shared/data/services/simple_notifications_push_service.dart';
import 'src/shared/domain/models/env_vars.dart';
import 'src/shared/helpers/analytics_helper.dart';
import 'src/shared/helpers/error_monitoring.dart';

Future<void> main() async {
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.beta,
  );

  await dotenv.load(fileName: '.env.${F.name}');
  final env = EnvVars();
  debugPrint('appId: ${env.appId}, flavor: ${F.name}');

  await SentryFlutter.init(
    (options) {
      options.dsn = kReleaseMode ? env.sentryDSN : '';
      options.environment = env.environment;
      options.debug = false;
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      appFlyerService = AppFlyerService();
      await Future.wait([
        appFlyerService!.init(),
        PushNotificationService.initialize(),
        MyAnalyticsHelper.initialize(enableInDebug: !kReleaseMode),
      ]);

      FlutterError.onError = (details) {
        final error = details.exception;
        final stack = details.stack ?? StackTrace.current;
        ErrorMonitoring.captureException(error, stack);
        FlutterError.presentError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        Sentry.captureException(error, stackTrace: stack);
        debugPrintStack(label: error.toString(), stackTrace: stack);
        return true;
      };

      runApp(const App());
    },
  );
}

Future<void> mainTest() async {
  // Solo inicializar appFlavor si no está ya inicializado
  try {
    F.appFlavor = Flavor.values.firstWhere(
      (element) => element.name == appFlavor,
      orElse: () => Flavor.beta,
    );
  } catch (e) {
    // Si ya está inicializado, continúa
    debugPrint('appFlavor ya está inicializado: ${F.name}');
  }

  await dotenv.load(fileName: '.env.${F.name}');
  final env = EnvVars();
  debugPrint('appId: ${env.appId}, flavor: ${F.name}');

  WidgetsFlutterBinding.ensureInitialized();

  // Solo inicializar Firebase si no está ya inicializado
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase ya está inicializado');
  }

  // appFlyerService = AppFlyerService();
  // await Future.wait([
  //   appFlyerService!.init(),
  //   PushNotificationService.initialize(),
  //   MyAnalyticsHelper.initialize(enableInDebug: !kReleaseMode),
  // ]);

  runApp(const App());
}
