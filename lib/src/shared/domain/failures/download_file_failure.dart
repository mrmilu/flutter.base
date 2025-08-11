import 'package:flutter/material.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';

enum DownloadFileFailure {
  notFound,
  noPermission,
  unknown,
  problemWithSaveFile;

  const DownloadFileFailure();

  R map<R>({
    required R Function() notFound,
    required R Function() noPermission,
    required R Function() unknown,
    required R Function() problemWithSaveFile,
  }) {
    switch (this) {
      case DownloadFileFailure.notFound:
        return notFound();
      case DownloadFileFailure.noPermission:
        return noPermission();
      case DownloadFileFailure.unknown:
        return unknown();
      case DownloadFileFailure.problemWithSaveFile:
        return problemWithSaveFile();
    }
  }

  static DownloadFileFailure fromString(String value) {
    switch (value) {
      case 'notFound':
        return DownloadFileFailure.notFound;
      case 'noPermission':
        return DownloadFileFailure.noPermission;
      case 'unknown':
        return DownloadFileFailure.unknown;
      case 'problemWithSaveFile':
        return DownloadFileFailure.problemWithSaveFile;
      default:
        return DownloadFileFailure.unknown;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case DownloadFileFailure.notFound:
        return context.l10n.fileNotFound;
      case DownloadFileFailure.noPermission:
        return context.l10n.operationNotAllowed;
      case DownloadFileFailure.unknown:
        return context.l10n.getDocumentError;
      case DownloadFileFailure.problemWithSaveFile:
        return context.l10n.problemWithSaveFile;
    }
  }
}
