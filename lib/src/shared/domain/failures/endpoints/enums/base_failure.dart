enum BaseFailureType {
  unauthorized,
  internalError,
  networkError,
  timeoutError,
  invalidResponseFormat,
  unexpectedError;

  String get defaultMessage {
    switch (this) {
      case BaseFailureType.unauthorized:
        return 'No estás autorizado. Por favor, inicia sesión.';
      case BaseFailureType.internalError:
        return 'Error interno. Por favor, inténtalo de nuevo más tarde.';
      case BaseFailureType.networkError:
        return 'Error de red. Por favor, verifica tu conexión a Internet.';
      case BaseFailureType.timeoutError:
        return 'La solicitud ha expirado. Por favor, inténtalo de nuevo.';
      case BaseFailureType.invalidResponseFormat:
        return 'Formato de respuesta inválido. Por favor, contacta al soporte.';
      case BaseFailureType.unexpectedError:
        return 'Error inesperado. Por favor, inténtalo de nuevo más tarde.';
    }
  }

  R when<R>({
    required R Function() unauthorized,
    required R Function() internalError,
    required R Function() networkError,
    required R Function() timeoutError,
    required R Function() invalidResponseFormat,
    required R Function() unexpectedError,
  }) {
    switch (this) {
      case BaseFailureType.unauthorized:
        return unauthorized();
      case BaseFailureType.internalError:
        return internalError();
      case BaseFailureType.networkError:
        return networkError();
      case BaseFailureType.timeoutError:
        return timeoutError();
      case BaseFailureType.invalidResponseFormat:
        return invalidResponseFormat();
      case BaseFailureType.unexpectedError:
        return unexpectedError();
    }
  }

  R map<R>({
    required R Function() unauthorized,
    required R Function() internalError,
    required R Function() networkError,
    required R Function() timeoutError,
    required R Function() invalidResponseFormat,
    required R Function() unexpectedError,
  }) {
    switch (this) {
      case BaseFailureType.unauthorized:
        return unauthorized();
      case BaseFailureType.internalError:
        return internalError();
      case BaseFailureType.networkError:
        return networkError();
      case BaseFailureType.timeoutError:
        return timeoutError();
      case BaseFailureType.invalidResponseFormat:
        return invalidResponseFormat();
      case BaseFailureType.unexpectedError:
        return unexpectedError();
    }
  }

  static BaseFailureType fromString(String value, String message) {
    return switch (value) {
      'unauthorized' => BaseFailureType.unauthorized,
      'internalError' => BaseFailureType.internalError,
      'networkError' => BaseFailureType.networkError,
      'timeoutError' => BaseFailureType.timeoutError,
      'invalidResponseFormat' => BaseFailureType.invalidResponseFormat,
      'unexpectedError' => BaseFailureType.unexpectedError,
      _ => BaseFailureType.unexpectedError,
    };
  }
}
