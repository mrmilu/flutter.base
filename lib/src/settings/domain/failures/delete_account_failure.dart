import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';

enum DeleteAccountFailure {
  noPermission,
  unknown;

  const DeleteAccountFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() unknown,
  }) {
    switch (this) {
      case DeleteAccountFailure.noPermission:
        return noPermission();
      case DeleteAccountFailure.unknown:
        return unknown();
    }
  }

  static DeleteAccountFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return DeleteAccountFailure.noPermission;
      case 'unknown':
        return DeleteAccountFailure.unknown;
      default:
        return DeleteAccountFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case DeleteAccountFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case DeleteAccountFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
