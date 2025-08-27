import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/change_password_failure.dart';

extension ChangePasswordFailureExtension on ChangePasswordFailure {
  String toTranslate(BuildContext context) {
    return when(
      weakPassword: (code, msg) => context.l10n.weakPassword,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
