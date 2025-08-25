import 'dart:io';

import 'package:flutter/material.dart';

import '../../../locale/presentation/utils/custom_localization_delegate.dart';
import '../l10n/generated/l10n.dart';

extension ContextExtension on BuildContext {
  S get l10n => S.of(this);

  CustomLocalization get cl =>
      Localizations.of<CustomLocalization>(this, CustomLocalization)!;

  Locale get locale => Localizations.localeOf(this);

  double get paddingBottomPlus =>
      MediaQuery.paddingOf(this).bottom + (Platform.isAndroid ? 24 : 24);

  TextTheme get textTheme => Theme.of(this).textTheme;
}
