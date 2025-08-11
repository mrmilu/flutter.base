import 'package:flutter/cupertino.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';
import '../failures/nie_failure.dart';

extension NieFailureTranslation on NieFailure {
  String toTranslate(BuildContext context) {
    switch (this) {
      case NieFailure.tooLong:
        return context.l10n.tooLong;
      case NieFailure.tooShort:
        return context.l10n.tooShort;
      case NieFailure.invalidFormat:
        return context.l10n.nieInvalid;
    }
  }
}
