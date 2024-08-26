import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';

extension DateTimeFormatter on DateTime {
  /// Format date time with [pattern]
  ///
  /// Optinal can pass [locale]
  String format(String pattern, {String? locale}) {
    return DateFormat(pattern, locale).format(this);
  }

  // Time ago
  String toTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    final num years = difference.inDays / 365;

    if (difference.inSeconds < 45) {
      return LocaleKeys.times_fromLessThanOneMinute.tr();
    } else if (difference.inSeconds < 90) {
      return LocaleKeys.times_fromOneMinute.tr();
    } else if (difference.inMinutes < 45) {
      return LocaleKeys.times_fromMinutes
          .tr(namedArgs: {'value': difference.inMinutes.toString()});
    } else if (difference.inMinutes < 90) {
      return LocaleKeys.times_fromOneHour.tr();
    } else if (difference.inHours < 24) {
      return LocaleKeys.times_fromHours
          .tr(namedArgs: {'value': difference.inHours.toString()});
    } else if (difference.inHours < 48) {
      return LocaleKeys.times_fromHours
          .tr(namedArgs: {'value': difference.inHours.toString()});
    } else if (difference.inDays < 30) {
      return LocaleKeys.times_fromDays
          .tr(namedArgs: {'value': difference.inDays.toString()});
    } else if (difference.inDays < 60) {
      return LocaleKeys.times_fromOneMonth.tr();
    } else if (difference.inDays < 365) {
      return LocaleKeys.times_fromMonths.tr(
        namedArgs: {'value': (difference.inDays / 30).round().toString()},
      );
    } else if (years < 2) {
      return LocaleKeys.times_fromOneYear.tr();
    } else {
      return LocaleKeys.times_fromYears
          .tr(namedArgs: {'value': years.round().toString()});
    }
  }
}
