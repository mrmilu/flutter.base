import 'dart:io';

import 'package:flutter/widgets.dart';

import '../../locale/presentation/utils/custom_localization_delegate.dart';
import '../presentation/l10n/generated/l10n.dart';
import 'value_object.dart';

extension ContextExtension on BuildContext {
  S get l10n => S.of(this);

  CustomLocalization get cl => CustomLocalization.of(this);

  Locale get locale => Localizations.localeOf(this);

  double get paddingBottomPlus =>
      MediaQuery.of(this).viewPadding.bottom + (Platform.isAndroid ? 12 : 0);
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
