import 'package:flutter/cupertino.dart';

import '../../../domain/failures/repeat_email_failure.dart';
import '../../l10n/generated/l10n.dart';

extension RepeatEmailFailureExtension on RepeatEmailFailure {
  String toTranslate(BuildContext context) {
    return when(
      mismatched: (_) => S.of(context).mismatchedPasswords,
    );
  }
}
