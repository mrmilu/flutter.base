import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/power_failure.dart';

extension PowerFailureTranslation on PowerFailure {
  String toTranslation(BuildContext context) {
    if (this is PowerFailureEmpty) {
      return S.of(context).empty;
    }

    if (this is PowerFailureInvalid) {
      return S.of(context).powerIsNotValid;
    }

    if (this is PowerFailureLess) {
      return S.of(context).powerIsLess;
    }

    if (this is PowerFailureMore) {
      return S.of(context).powerIsMore;
    }

    return S.of(context).empty;
  }
}
