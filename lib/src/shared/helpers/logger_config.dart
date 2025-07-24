// import 'package:logger/logger.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// class LoggerConfig {
//   late LogFilter _filter;
//   late LogPrinter _printer;
//   LogOutput? _output;
//   Level? _level;
//   FirebaseCrashlytics? _crashlytics;

//   LogFilter get filter => _filter;
//   LogPrinter get printer => _printer;
//   LogOutput? get output => _output;
//   Level? get level => _level;
//   FirebaseCrashlytics? get crashlyticsInstance => _crashlytics;

//   static final LoggerConfig instance = LoggerConfig._internal();

//   LoggerConfig._internal();

//   factory LoggerConfig.init({
//     LogFilter? filter,
//     LogPrinter? printer,
//     LogOutput? output,
//     Level? level,
//     FirebaseCrashlytics? crashlytics,
//   }) {
//     instance._filter = filter ?? MyFilter();
//     instance._printer = printer ?? PrettyPrinter();
//     instance._output = output;
//     instance._level = level;
//     instance._crashlytics = crashlytics;
//     return instance;
//   }

//   void changeFilter(LogFilter filter) {
//     instance._filter = filter;
//   }

//   void changePrinter(LogPrinter printer) {
//     instance._printer = printer;
//   }

//   void changeOutput(LogOutput output) {
//     instance._output = output;
//   }

//   void changeLevel(Level level) {
//     instance._level = level;
//   }

//   void changeCrashlyticsInstance(FirebaseCrashlytics crashlytics) {
//     instance._crashlytics = crashlytics;
//   }
// }

// /// Prints all logs with `level >= Logger.level` while in development mode (eg
// /// when `assert`s are evaluated, Flutter calls this debug mode).
// ///
// /// In release mode prints logs with `level >= Level.warning`.
// class MyFilter extends LogFilter {
//   @override
//   bool shouldLog(LogEvent event) {
//     var shouldLog = false;
//     assert(() {
//       if (event.level.index >= level!.index) {
//         shouldLog = true;
//       }
//       return true;
//     }());
//     if (event.level.index >= Level.warning.index) {
//       shouldLog = true;
//     }
//     return shouldLog;
//   }
// }
