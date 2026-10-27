import 'dart:developer';

import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppLogger {
  static void init({required bool isRelease}) {
    Logger.root.level = isRelease ? Level.INFO : Level.ALL;

    Logger.root.onRecord.listen((record) async {
      final message = _format(record);

      log(message);

      if (record.level >= Level.WARNING) {
        await Sentry.captureMessage(
          message,
          level: _toSentryLevel(record.level),
        );

        if (record.error != null && record.level >= Level.SEVERE) {
          await Sentry.captureException(
            record.error,
            stackTrace: record.stackTrace,
          );
        }
      }
    });
  }

  static String _format(LogRecord r) {
    final icon = _iconForLevel(r.level);
    final error = r.error != null ? ' | error=${r.error}' : '';
    final stack = r.stackTrace != null ? ' | stack=${r.stackTrace}' : '';
    return '$icon [${r.level.name}] [${r.loggerName}] ${r.time.toIso8601String()} - ${r.message}$error$stack';
  }

  static String _iconForLevel(Level level) {
    if (level >= Level.SEVERE) return '[x]';
    if (level >= Level.WARNING) return '[!]';
    if (level >= Level.INFO) return '[i]';
    return '[.]';
  }

  static SentryLevel _toSentryLevel(Level l) {
    if (l >= Level.SEVERE) return SentryLevel.error;
    if (l >= Level.WARNING) return SentryLevel.warning;
    if (l >= Level.INFO) return SentryLevel.info;
    return SentryLevel.debug;
  }
}
