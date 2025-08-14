import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toFString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String toFStringWithTime() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  String toFStringMonthLetter() {
    return DateFormat('MMM').format(this);
  }

  String toFStringDayAndMonthLetter() {
    return DateFormat('dd MMM').format(this);
  }

  String toFStringDayMonthLetterYear() {
    return DateFormat('dd MMM yyyy').format(this);
  }

  String toMonthAndYear() {
    return DateFormat('MMMM yyyy').format(this);
  }

  String toMonth() {
    return DateFormat('MMMM').format(this).substring(0, 1).toUpperCase() +
        DateFormat('MMMM').format(this).substring(1);
  }

  String toDay({String? locale}) {
    return DateFormat('EEEE', locale).format(this);
  }

  String toFStringDayMonthLetterYearWithArticle() {
    return DateFormat('dd \'de\' MMMM \'de\' yyyy').format(this);
  }

  String toFStringDayMonthLetter() {
    return DateFormat('dd \'de\' MMMM').format(this);
  }

  String toHourAndMinute() {
    return DateFormat('HH:mm').format(this);
  }
}
