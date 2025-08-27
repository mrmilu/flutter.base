import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/splash_failure.dart';

extension SplashFailureFailureTranslation on SplashFailure {
  String toTranslate(BuildContext context) {
    return when(
      appSettings: (code, msg) => S.of(context).appSettingsError,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
