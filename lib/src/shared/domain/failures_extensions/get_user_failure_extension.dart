import 'package:flutter/material.dart';

import '../../presentation/l10n/generated/l10n.dart';
import '../failures/endpoints/get_user_failure.dart';
import 'general_base_failure_extension.dart';

extension GetUserFailureExtension on GetUserFailure {
  String toTranslate(BuildContext context) {
    return when(
      userNotFound: (_, _) => S.of(context).cancelledByUser,
      userInvalid: (_, _) => S.of(context).internalError,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
