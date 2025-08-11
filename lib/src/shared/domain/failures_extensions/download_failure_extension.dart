import 'package:flutter/cupertino.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';
import '../failures/download_file_failure.dart';

extension DownloadFileFailureTranslation on DownloadFileFailure {
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
