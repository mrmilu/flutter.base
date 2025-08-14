import 'package:sentry_flutter/sentry_flutter.dart';

class ErrorMonitoring {
  static void captureException(
    Object error,
    StackTrace trace, {
    Map<String, Object?>? extra,
  }) {
    ErrorMonitoring.addBreadcrumb(error, extra: extra);
    Sentry.captureException(error, stackTrace: trace);
  }

  static void addBreadcrumb(Object error, {Map<String, Object?>? extra}) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: error.toString(),
        data: {'error-code': 'no error code'}..addAll(extra ?? {}),
        level: SentryLevel.error,
      ),
    );
  }
}
