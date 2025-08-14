import 'package:flutter/cupertino.dart';

import '../../presentation/utils/extensions/buildcontext_extensions.dart';
import '../failures/nie_failure.dart';

extension NieFailureTranslation on NieFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => context.l10n.empty,
      invalid: (_) => context.l10n.nieInvalid,
      tooLong: (_, length) => context.l10n.tooLong,
      tooShort: (_, length) => context.l10n.tooShort,
    );
  }
}
