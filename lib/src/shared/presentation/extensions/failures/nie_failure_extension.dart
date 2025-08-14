import 'package:flutter/cupertino.dart';

import '../../../domain/failures/nie_failure.dart';
import '../buildcontext_extensions.dart';

extension NieFailureExtension on NieFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => context.l10n.empty,
      invalid: (_) => context.l10n.nieInvalid,
      tooLong: (_, length) => context.l10n.tooLong,
      tooShort: (_, length) => context.l10n.tooShort,
    );
  }
}
