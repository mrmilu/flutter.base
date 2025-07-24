import 'package:flutter/cupertino.dart';

import '../../presentation/l10n/generated/l10n.dart';
import '../failures/repeat_email_failure.dart';

extension RepeatEmailFailureTranslation on RepeatEmailFailure {
  String toTranslation(BuildContext context) {
    if (this is MismatchedEmail) {
      return S.of(context).mismatchedEmail;
    }

    return S.of(context).empty;
  }
}
