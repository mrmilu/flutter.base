import 'package:flutter/cupertino.dart';

import '../../../domain/failures/repeat_password_failure.dart';
import '../../l10n/generated/l10n.dart';

extension RepeatPasswordFailureExtension on RepeatPasswordFailure {
  String toTranslate(BuildContext context) {
    return when(
      mismatched: (_) => S.of(context).mismatchedPasswords,
    );
  }
}
