import 'package:flutter/cupertino.dart';

import '../../presentation/l10n/generated/l10n.dart';
import '../failures/general_base_failure.dart';
import '../failures/get_user_failure.dart';

extension GeneralBaseFailureExtension on GeneralBaseFailure {
  String toTranslation(BuildContext context) {
    return when(
      unauthorized: (_, _) => S.of(context).unauthorized,
      internalError: (_, _) => S.of(context).internalError,
      networkError: (_, _) => 'Si conexión a internet. Verifica tu red.',
      timeoutError: (_, _) => 'La solicitud tardó demasiado. Intenta de nuevo.',
      invalidResponseFormat: (_, _) =>
          'Formato de respuesta inválido. Contacta soporte.',
      unexpectedError: (_, _) => 'Error inesperado. Intenta más tarde.',
    );
  }
}

extension GetUserFailureExtension on GetUserFailure {
  String toTranslation(BuildContext context) {
    return when(
      userNotFound: (_, _) => S.of(context).cancelledByUser,
      userInvalid: (_, _) => S.of(context).internalError,
      general: (appError) => appError.toTranslation(context),
    );
  }
}
