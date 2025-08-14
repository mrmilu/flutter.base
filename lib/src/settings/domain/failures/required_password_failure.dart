import 'package:flutter/material.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';

enum RequiredPasswordFailure {
  noPermission,
  unknown;

  const RequiredPasswordFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() unknown,
  }) {
    switch (this) {
      case RequiredPasswordFailure.noPermission:
        return noPermission();
      case RequiredPasswordFailure.unknown:
        return unknown();
    }
  }

  static RequiredPasswordFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return RequiredPasswordFailure.noPermission;
      case 'unknown':
        return RequiredPasswordFailure.unknown;
      default:
        return RequiredPasswordFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case RequiredPasswordFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case RequiredPasswordFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
