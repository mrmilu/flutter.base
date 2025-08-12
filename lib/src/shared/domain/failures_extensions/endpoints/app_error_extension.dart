import 'package:flutter/cupertino.dart';

import '../../../presentation/l10n/generated/l10n.dart';
import '../../failures/endpoints/unions/app_error.dart';
import '../../failures/endpoints/unions/user_endpoint_failure.dart';

extension AppBaseErrorTranslation on AppBaseError {
  String toTranslation(BuildContext context) {
    return when(
      unauthorized: (_) => S.of(context).unauthorized,
      internalError: (_) => S.of(context).internalError,
      networkError: (_) => 'Si conexión a internet. Verifica tu red.',
      timeoutError: (_) => 'La solicitud tardó demasiado. Intenta de nuevo.',
      invalidResponseFormat: (_) =>
          'Formato de respuesta inválido. Contacta soporte.',
      unexpectedError: (_) => 'Error inesperado. Intenta más tarde.',
    );
  }
}

extension UserEndpointErrorTranslation on UserEndpointError {
  String toTranslation(BuildContext context) {
    return when(
      userNotFound: (_) => S.of(context).cancelledByUser,
      userInvalid: (_) => S.of(context).internalError,
      general: (appError) => appError.toTranslation(context),
    );
  }
}
