import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../../l10n/generated/l10n.dart';

extension EmailFailureExtension on EmailFailure {
  String toTranslate(BuildContext context) {
    return when(
      empty: (_) => S.of(context).empty,
      invalid: (_) => S.of(context).invalidEmail,
    );
  }
}
