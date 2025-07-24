import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/email_failure.dart';

extension EmailFailureTranslation on EmailFailure {
  String toTranslation(BuildContext context) {
    if (this is EmailFailureEmpty) {
      return S.of(context).empty;
    }

    if (this is EmailFailureInvalid) {
      return S.of(context).invalidEmail;
    }

    return S.of(context).empty;
  }
}
