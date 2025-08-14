import 'package:flutter/material.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';

enum PersonalDataFailure {
  noPermission,
  unknown;

  const PersonalDataFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() unknown,
  }) {
    switch (this) {
      case PersonalDataFailure.noPermission:
        return noPermission();
      case PersonalDataFailure.unknown:
        return unknown();
    }
  }

  static PersonalDataFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return PersonalDataFailure.noPermission;
      case 'unknown':
        return PersonalDataFailure.unknown;
      default:
        return PersonalDataFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case PersonalDataFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case PersonalDataFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
