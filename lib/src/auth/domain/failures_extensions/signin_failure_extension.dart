import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/signin_failure.dart';

extension SingInFailureTranslation on SignInFailure {
  String toTranslate(BuildContext context) {
    if (this is NonExistentUserAndPassword) {
      return S.of(context).nonExistentUserAndPassword;
    }

    if (this is ServerError) {
      return S.of(context).emailOrPasswordInvalid;
    }

    return S.of(context).nonExistentUserAndPassword;
  }
}
