import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/fullname_failure.dart';

extension FullnameFailureTranslation on FullnameFailure {
  String toTranslation(BuildContext context) {
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
