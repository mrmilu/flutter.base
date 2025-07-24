import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/phone_failure.dart';

extension PhoneFailureTranslation on PhoneFailure {
  String toTranslation(BuildContext context) {
    if (this is PhoneFailureEmpty) {
      return S.of(context).empty;
    }

    if (this is PhoneFailureInvalid) {
      return S.of(context).invalidPhone;
    }

    if (this is PhoneFailureTooLong) {
      return S.of(context).tooLong;
    }

    return S.of(context).empty;
  }
}
