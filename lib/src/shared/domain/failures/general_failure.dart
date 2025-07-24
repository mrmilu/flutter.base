import 'package:flutter/material.dart';

import '../../../shared/helpers/extensions.dart';

enum GeneralFailure {
  noPermission,
  internalError,
  serverError,
  unknown;

  const GeneralFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() internalError,
    required R Function() serverError,
    required R Function() unknown,
  }) {
    switch (this) {
      case GeneralFailure.noPermission:
        return noPermission();
      case GeneralFailure.internalError:
        return internalError();
      case GeneralFailure.serverError:
        return serverError();
      case GeneralFailure.unknown:
        return unknown();
    }
  }

  static GeneralFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return GeneralFailure.noPermission;
      case 'internalError':
        return GeneralFailure.internalError;
      case 'serverError':
        return GeneralFailure.serverError;
      case 'unknown':
        return GeneralFailure.unknown;
      default:
        return GeneralFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case GeneralFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case GeneralFailure.internalError:
        return context.l10n.internalError;
      case GeneralFailure.serverError:
        return context.l10n.serverError;
      case GeneralFailure.unknown:
        return context.l10n.unknownError;
    }
  }
}
