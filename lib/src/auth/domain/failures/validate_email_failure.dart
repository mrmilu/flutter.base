import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';

enum ValidateEmailFailure {
  noPermission,
  noSupported,
  unknown,
  cancel;

  const ValidateEmailFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() noSupported,
    required R Function() unknown,
    required R Function() cancel,
  }) {
    switch (this) {
      case ValidateEmailFailure.noPermission:
        return noPermission();
      case ValidateEmailFailure.noSupported:
        return noSupported();
      case ValidateEmailFailure.unknown:
        return unknown();
      case ValidateEmailFailure.cancel:
        return cancel();
    }
  }

  static ValidateEmailFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return ValidateEmailFailure.noPermission;
      case 'noSupported':
        return ValidateEmailFailure.noSupported;
      case 'unknown':
        return ValidateEmailFailure.unknown;
      case 'cancel':
        return ValidateEmailFailure.cancel;
      default:
        return ValidateEmailFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case ValidateEmailFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case ValidateEmailFailure.noSupported:
        return context.l10n.notSupported;
      case ValidateEmailFailure.unknown:
        return context.l10n.unknownError;
      case ValidateEmailFailure.cancel:
        return context.l10n.cancel;
    }
  }
}
