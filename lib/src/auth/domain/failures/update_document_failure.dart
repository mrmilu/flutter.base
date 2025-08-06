import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';

enum UpdateDocumentFailure {
  noPermission,
  noSupported,
  unknown,
  cancel;

  const UpdateDocumentFailure();

  R map<R>({
    required R Function() noPermission,
    required R Function() noSupported,
    required R Function() unknown,
    required R Function() cancel,
  }) {
    switch (this) {
      case UpdateDocumentFailure.noPermission:
        return noPermission();
      case UpdateDocumentFailure.noSupported:
        return noSupported();
      case UpdateDocumentFailure.unknown:
        return unknown();
      case UpdateDocumentFailure.cancel:
        return cancel();
    }
  }

  static UpdateDocumentFailure fromString(String value) {
    switch (value) {
      case 'noPermission':
        return UpdateDocumentFailure.noPermission;
      case 'noSupported':
        return UpdateDocumentFailure.noSupported;
      case 'unknown':
        return UpdateDocumentFailure.unknown;
      case 'cancel':
        return UpdateDocumentFailure.cancel;
      default:
        return UpdateDocumentFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case UpdateDocumentFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case UpdateDocumentFailure.noSupported:
        return context.l10n.notSupported;
      case UpdateDocumentFailure.unknown:
        return context.l10n.unknownError;
      case UpdateDocumentFailure.cancel:
        return context.l10n.cancel;
    }
  }
}
