import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/required_password_failure.dart';

extension RequiredPasswordFailureExtension on RequiredPasswordFailure {
  String toTranslate(BuildContext context) {
    return when(
      general: (appError) => appError.toTranslate(context),
    );
  }
}
