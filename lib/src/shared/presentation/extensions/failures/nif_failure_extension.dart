import 'package:flutter/cupertino.dart';

import '../../../domain/failures/nif_failure.dart';
import '../buildcontext_extensions.dart';

extension NifFailureExtension on NifFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => context.l10n.empty,
      invalid: (_) => context.l10n.nifInvalid,
      tooLong: (_, length) => context.l10n.tooLong,
      tooShort: (_, length) => context.l10n.tooShort,
    );
  }
}
