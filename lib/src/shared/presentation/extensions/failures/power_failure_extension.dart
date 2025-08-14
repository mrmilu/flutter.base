import 'package:flutter/cupertino.dart';

import '../../../domain/failures/power_failure.dart';
import '../../l10n/generated/l10n.dart';

extension PowerFailureExtension on PowerFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).powerIsNotValid,
      less: (_) => S.of(context).powerIsLess,
      more: (_) => S.of(context).powerIsMore,
    );
  }
}
