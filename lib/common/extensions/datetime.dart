import 'package:easy_localization/easy_localization.dart';

extension FormatDate on DateTime {
  String format(String pattern, {String? locale}) {
    return DateFormat(pattern, locale).format(this);
  }
}

extension GetYearsFromNow on DateTime {
  int yearsFromNow() {
    return (DateTime.now().difference(this).inDays / 365).round();
  }
}