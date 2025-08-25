import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/change_user_info_failure.dart';

extension ChangeUserInfoFailureExtension on ChangeUserInfoFailure {
  String toTranslate(BuildContext context) {
    return when(
      invalidName: (code, msg) => context.l10n.invalidName,
      invalidSurname: (code, msg) => context.l10n.invalidSurname,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
