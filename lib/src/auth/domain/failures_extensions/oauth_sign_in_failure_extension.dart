import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../failures/oauth_sign_in_failure.dart';

extension OAuthSingInFailureTranslation on OAuthSignInFailure {
  String toTranslate(BuildContext context) {
    if (this is OAuthSignInFailureAccountExistsWithDifferentCredential) {
      return S.of(context).differentCredentials;
    }

    if (this is OAuthSignInFailureInvalidCredential) {
      return S.of(context).invalidCredentials;
    }

    if (this is OAuthSignInFailureServerError) {
      return S.of(context).serverError;
    }

    if (this is OAuthSignInFailureCancel) {
      return S.of(context).cancelledByUser;
    }

    return S.of(context).serverError;
  }
}
