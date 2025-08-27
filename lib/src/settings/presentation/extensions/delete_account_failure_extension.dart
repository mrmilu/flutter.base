import 'package:flutter/cupertino.dart';

import '../../../shared/presentation/extensions/failures/general_base_failure_extension.dart';
import '../../domain/failures/delete_account_failure.dart';

extension DeleteAccountFailureExtension on DeleteAccountFailure {
  String toTranslate(BuildContext context) {
    return when(
      general: (appError) => appError.toTranslate(context),
    );
  }
}
