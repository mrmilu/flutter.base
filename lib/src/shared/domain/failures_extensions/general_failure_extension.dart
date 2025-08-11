import 'package:flutter/cupertino.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';
import '../failures/general_failure.dart';

extension GeneralFailureTranslation on GeneralFailure {
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
