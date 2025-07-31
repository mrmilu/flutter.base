import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';

enum ChangeEmailFailure {
  noPermission,
  unknown;

  const ChangeEmailFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() unknown,
  }) {
    switch (this) {
      case ChangeEmailFailure.noPermission:
        return noPermission();
      case ChangeEmailFailure.unknown:
        return unknown();
    }
  }

  static ChangeEmailFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return ChangeEmailFailure.noPermission;
      case 'unknown':
        return ChangeEmailFailure.unknown;
      default:
        return ChangeEmailFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case ChangeEmailFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case ChangeEmailFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
