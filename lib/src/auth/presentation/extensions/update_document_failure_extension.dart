import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/update_document_failure.dart';

extension UpdateDocumentFailureTranslation on UpdateDocumentFailure {
  String toTranslate(BuildContext context) {
    return when(
      noSupported: (code, msg) => msg,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
