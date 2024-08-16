import 'package:easy_localization/easy_localization.dart';

extension DateTimeFormatter on DateTime {
  /// Format date time with [pattern]
  ///
  /// Optinal can pass [locale]
  String format(String pattern, {String? locale}) {
    return DateFormat(pattern, locale).format(this);
  }
}
