import 'package:flutter/cupertino.dart';

import '../../presentation/l10n/generated/l10n.dart';
import '../failures/repeat_password_failure.dart';

extension RepeatPasswordFailureTranslation on RepeatPasswordFailure {
  String toTranslation(BuildContext context) {
    if (this is MismatchedPasswords) {
      return S.of(context).mismatchedPasswords;
    }

    return S.of(context).empty;
  }
}
