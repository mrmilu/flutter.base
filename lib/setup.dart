import 'package:easy_localization/easy_localization.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:flutter_base/core/app/domain/models/env_vars.dart';
import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:flutter_base/ui/app.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void startApp() async {
  final env = EnvVars().environment;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  LicenseRegistry.addLicense(() async* {
    final poppinsLicense =
        await rootBundle.loadString('fonts/poppins_license.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], poppinsLicense);
  });

  configureDependencies(env: env);

  final providerContainer = GetIt.I.get<ProviderContainer>();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(error, stackTrace: stack);

    providerContainer
        .read(uiProvider.notifier)
        .showSnackBar('Something went wrong');
    debugPrint('PlatformDispatcher.instance/$error');
    return true;
  };

  await SentryFlutter.init(
    (options) {
      options.dsn = !kDebugMode ? GetIt.I.get<IEnvVars>().sentryDSN : '';
      options.environment = GetIt.I.get<IEnvVars>().environment;
    },
    appRunner: () => runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: UncontrolledProviderScope(
          container: GetIt.I.get<ProviderContainer>(),
          child: const App(),
        ),
      ),
    ),
  );
}
