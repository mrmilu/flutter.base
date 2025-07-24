import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/signup_failure.dart';

extension SignUpFailureTranslation on SignUpFailure {
  String toTranslate(BuildContext context) {
    if (this is SignUpFailureEmailAlreadyInUser) {
      return S.of(context).emailAlreadyInUser;
    }

    if (this is SignUpFailureInvalidEmail) {
      return S.of(context).signupError;
    }

    if (this is SignUpFailureOperationNotAllowed) {
      return S.of(context).operationNotAllowed;
    }

    if (this is SignUpFailureWeakPassword) {
      return S.of(context).weakPassword;
    }

    return S.of(context).emailAlreadyInUser;
  }
}
