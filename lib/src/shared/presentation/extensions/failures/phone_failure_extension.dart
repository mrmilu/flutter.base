import 'package:flutter/cupertino.dart';

import '../../../domain/failures/phone_failure.dart';
import '../../l10n/generated/l10n.dart';

extension PhoneFailureExtension on PhoneFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).invalidPhone,
      tooLong: (_, length) => S.of(context).tooLong,
    );
  }
}
