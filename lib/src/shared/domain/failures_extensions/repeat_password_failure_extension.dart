import 'package:flutter/cupertino.dart';

import '../../presentation/l10n/generated/l10n.dart';
import '../failures/repeat_password_failure.dart';

extension RepeatPasswordFailureTranslation on RepeatPasswordFailure {
  String toTranslate(BuildContext context) {
    return when(
      mismatched: (_) => S.of(context).mismatchedPasswords,
    );
  }
}
