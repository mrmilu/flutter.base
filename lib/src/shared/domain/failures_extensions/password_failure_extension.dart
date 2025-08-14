import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/password_failure.dart';

extension PasswordFailureTranslation on PasswordFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      minLength: (_, length) => S.of(context).minLength(length),
      includeUppercase: (_) => S.of(context).includeUppercase,
      includeLowercase: (_) => S.of(context).includeLowercase,
      includeDigit: (_) => S.of(context).includeDigit,
    );
  }
}
