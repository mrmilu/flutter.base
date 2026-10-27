import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';

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
