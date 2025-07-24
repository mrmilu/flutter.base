import 'package:flutter/material.dart';

import '../../../shared/helpers/extensions.dart';

enum ChangeLanguageFailure {
  noPermission,
  unknown;

  const ChangeLanguageFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() unknown,
  }) {
    switch (this) {
      case ChangeLanguageFailure.noPermission:
        return noPermission();
      case ChangeLanguageFailure.unknown:
        return unknown();
    }
  }

  static ChangeLanguageFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return ChangeLanguageFailure.noPermission;
      case 'unknown':
        return ChangeLanguageFailure.unknown;
      default:
        return ChangeLanguageFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case ChangeLanguageFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case ChangeLanguageFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
