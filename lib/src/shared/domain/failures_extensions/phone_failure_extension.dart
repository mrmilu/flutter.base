import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/phone_failure.dart';

extension PhoneFailureTranslation on PhoneFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).invalidPhone,
      tooLong: (_, length) => S.of(context).tooLong,
    );
  }
}
