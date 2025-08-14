import 'package:flutter/cupertino.dart';

import '../../../domain/failures/endpoints/download_file_failure.dart';
import '../buildcontext_extensions.dart';
import 'general_base_failure_extension.dart';

extension DownloadFileFailureExtension on DownloadFileFailure {
  String toTranslate(BuildContext context) {
    return when(
      problemWithSaveFile: (code, msg) => context.l10n.problemWithSaveFile,
      notFound: (code, msg) => context.l10n.fileNotFound,
      noPermission: (code, msg) => context.l10n.operationNotAllowed,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
