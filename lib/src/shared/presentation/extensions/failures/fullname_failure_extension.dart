import 'package:flutter/cupertino.dart';

import '../../../domain/failures/fullname_failure.dart';
import '../../l10n/generated/l10n.dart';

extension FullnameFailureExtension on FullnameFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).invalidName,
      tooLong: (_, _) => S.of(context).tooLong,
    );
  }
}
