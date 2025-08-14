import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/validate_email_failure.dart';

extension ValidateEmailFailureTranslation on ValidateEmailFailure {
  String toTranslate(BuildContext context) {
    return when(
      noSupported: (code, msg) => msg,
      general: (appError) => appError.toTranslate(context),
    );
  }
}
