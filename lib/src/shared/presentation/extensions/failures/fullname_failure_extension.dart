import 'package:flutter/cupertino.dart';

import '../../../domain/failures/fullname_failure.dart';
import '../../l10n/generated/l10n.dart';

extension FullnameFailureExtension on FullnameFailure {
  String toTranslate(BuildContext context) {
    if (this is FullnameFailureEmpty) {
      return S.of(context).empty;
    }

    if (this is FullnameFailureInvalid) {
      return S.of(context).invalidName;
    }

    if (this is FullnameFailureTooLong) {
      return S.of(context).tooLong;
    }

    return S.of(context).empty;
  }
}
