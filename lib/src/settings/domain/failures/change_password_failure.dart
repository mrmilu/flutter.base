import 'package:flutter/material.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';

enum ChangePasswordFailure {
  noPermission,
  unknown;

  const ChangePasswordFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() unknown,
  }) {
    switch (this) {
      case ChangePasswordFailure.noPermission:
        return noPermission();
      case ChangePasswordFailure.unknown:
        return unknown();
    }
  }

  static ChangePasswordFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return ChangePasswordFailure.noPermission;
      case 'unknown':
        return ChangePasswordFailure.unknown;
      default:
        return ChangePasswordFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case ChangePasswordFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case ChangePasswordFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
