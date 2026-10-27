import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../../l10n/generated/l10n.dart';

extension PasswordFailureExtension on PasswordFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      minLength: (_, length) => S.of(context).minLength(length),
      includeUppercase: (_) => S.of(context).includeUppercase,
      includeLowercase: (_) => S.of(context).includeLowercase,
      includeDigit: (_) => S.of(context).includeDigit,
      includeSpecialCharacter: (_) => S.of(context).includeSpecialCharacter,
    );
  }
}
