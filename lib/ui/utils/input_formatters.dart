import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';

class AgeInputFormatter extends TextInputFormatter {
  static removeMask(String value) => value.replaceAll(RegExp(r'[^0-9]'),'');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numbers = newValue.text.replaceAll(RegExp(r'[^0-9]'),'');
    final newText = numbers.length > 2 ? numbers.substring(0, 2) : numbers;
    return TextEditingValue(
      text: newText.isNotEmpty ? LocaleKeys.inputFormatters_age.plural(int.parse(newText)) : '',
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class WeightInputFormatter extends TextInputFormatter {
  static removeMask(String value) => value.replaceAll(RegExp(r'[^(0-9)(,)(.)]'),'');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(LocaleKeys.inputFormatters_weight.tr(),'');
    return TextEditingValue(
      text: newText.isNotEmpty ? '$newText ${LocaleKeys.inputFormatters_weight.tr()}' : '',
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
