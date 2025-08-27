import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/change_language_failure.dart';

extension ChangeLanguageFailureExtension on ChangeLanguageFailure {
  String toTranslate(BuildContext context) {
    return when(
      general: (appError) => appError.toTranslate(context),
    );
  }
}
