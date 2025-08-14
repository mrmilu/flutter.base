import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/power_failure.dart';

extension PowerFailureTranslation on PowerFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).powerIsNotValid,
      less: (_) => S.of(context).powerIsLess,
      more: (_) => S.of(context).powerIsMore,
    );
  }
}
