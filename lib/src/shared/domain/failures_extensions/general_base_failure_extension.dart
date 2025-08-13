import 'package:flutter/cupertino.dart';

import '../../presentation/l10n/generated/l10n.dart';
import '../failures/general_base_failure.dart';

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
