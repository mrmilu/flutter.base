import 'package:flutter/cupertino.dart';

import '../../../domain/failures/email_failure.dart';
import '../../l10n/generated/l10n.dart';

extension EmailFailureExtension on EmailFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).invalidEmail,
    );
  }
}
