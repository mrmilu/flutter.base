import 'package:flutter/cupertino.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';
import '../failures/nif_failure.dart';

extension NifFailureTranslation on NifFailure {
  String toTranslate(BuildContext context) {
    switch (this) {
      case NifFailure.tooLong:
        return context.l10n.tooLong;
      case NifFailure.tooShort:
        return context.l10n.tooShort;
      case NifFailure.invalidFormat:
        return context.l10n.nifInvalid;
    }
  }
}
