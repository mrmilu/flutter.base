import 'package:flutter/material.dart';

import '../../../presentation/l10n/generated/l10n.dart';
import '../../failures/endpoints/sealed/general_failure.dart';

extension AppErrorSealedTranslation on GeneralFailure {
  String toTranslation(BuildContext context) {
    return when(
      unauthorized: () => S.of(context).unauthorized,
      invalidToken: () => 'Invalid token',
      tokenExpired: () => 'Token expired',
      serverError: () => 'Server error',
      networkTimeout: () => 'Network timeout',
      noInternet: () => 'No internet connection',
      unknown: (code) => code,
    );
  }
}
