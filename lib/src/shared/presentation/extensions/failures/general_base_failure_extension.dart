import 'package:flutter/cupertino.dart';

import '../../../domain/failures/endpoints/general_base_failure.dart';
import '../../l10n/generated/l10n.dart';

extension GeneralBaseFailureExtension on GeneralBaseFailure {
  String toTranslate(BuildContext context) {
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
