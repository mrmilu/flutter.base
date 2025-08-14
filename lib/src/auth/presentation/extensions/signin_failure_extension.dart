import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/signin_failure.dart';

extension SigninFailureTranslation on SigninFailure {
  String toTranslate(BuildContext context) {
    return when(
      notExistEmail: (code, msg) => S.of(context).nonExistentUserAndPassword,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
