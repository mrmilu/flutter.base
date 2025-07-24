import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/password_failure.dart';

extension PasswordFailureTranslation on PasswordFailure {
  String toTranslation(BuildContext context) {
    if (this is PasswordFailureInvalidMinLength) {
      return S.of(context).minLength(8);
    }

    if (this is PasswordFailureIncludeUppercase) {
      return S.of(context).includeUppercase;
    }

    if (this is PasswordFailureIncludeLowercase) {
      return S.of(context).includeLowercase;
    }

    if (this is PasswordFailureIncludeDigit) {
      return S.of(context).includeDigit;
    }

    return S.of(context).empty;
  }
}
