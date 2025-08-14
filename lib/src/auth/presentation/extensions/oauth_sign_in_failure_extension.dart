import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../domain/failures/oauth_sign_in_failure.dart';

extension OAuthSingInFailureTranslation on OAuthSignInFailure {
  String toTranslate(BuildContext context) {
    return when(
      accountExistsWithDifferentCredential: (code, msg) =>
          S.of(context).differentCredentials,
      invalidCredential: (code, msg) => S.of(context).invalidCredentials,
      cancel: (code, msg) => S.of(context).cancelledByUser,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
