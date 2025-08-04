import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../locale/presentation/utils/custom_localization_delegate.dart';
import '../../../helpers/value_object.dart';
import '../../l10n/generated/l10n.dart';

extension ContextExtension on BuildContext {
  S get l10n => S.of(this);

  CustomLocalization get cl => CustomLocalization.of(this);

  Locale get locale => Localizations.localeOf(this);

  double get paddingBottomPlus =>
      MediaQuery.paddingOf(this).bottom + (Platform.isAndroid ? 24 : 24);

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension IterableOfValueObject on Iterable<ValueObject> {
  bool get areValid => every((element) => element.isValid());
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
