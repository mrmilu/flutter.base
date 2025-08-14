import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension DoubleX on double {
  String toTwoDecimalStringNF(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formatter = NumberFormat("#,##0.00", locale);
    return formatter.format(this);
  }

  String toOneDecimalStringNF(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final formatter = NumberFormat("#,##0.0", locale);
    final roundedUp = (this * 10).ceil() / 10.0;
    return formatter.format(roundedUp);
  }
}
