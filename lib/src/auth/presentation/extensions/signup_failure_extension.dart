import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/signup_failure.dart';

extension SignUpFailureTranslation on SignupFailure {
  String toTranslate(BuildContext context) {
    return when(
      emailAlreadyExist: (code, msg) => S.of(context).emailAlreadyInUser,
      weakPassword: (code, msg) => S.of(context).weakPassword,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
