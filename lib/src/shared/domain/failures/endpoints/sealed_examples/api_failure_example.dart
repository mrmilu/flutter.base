/// Ejemplo de failure usando sealed class
/// Maneja códigos de error de API y mensajes personalizados
sealed class ApiFailure {
  /// Mensaje de error personalizado (puede venir de la API)
  final String? customMessage;

  const ApiFailure({this.customMessage});

  /// Factory para crear un failure desde código de API
  factory ApiFailure.fromCode(String code, {String? message}) {
    return switch (code) {
      'AUTH_001' ||
      'UNAUTHORIZED' => ApiFailureUnauthorized(customMessage: message),
      'AUTH_002' ||
      'INVALID_TOKEN' => ApiFailureInvalidToken(customMessage: message),
      'AUTH_003' ||
      'TOKEN_EXPIRED' => ApiFailureTokenExpired(customMessage: message),
      'VALIDATION_001' ||
      'INVALID_DATA' => ApiFailureValidation(customMessage: message),
      'VALIDATION_002' ||
      'REQUIRED_FIELD' => ApiFailureRequiredField(customMessage: message),
      'SERVER_001' ||
      'INTERNAL_ERROR' => ApiFailureServerError(customMessage: message),
      'SERVER_002' || 'SERVICE_UNAVAILABLE' => ApiFailureServiceUnavailable(
        customMessage: message,
      ),
      'NETWORK_001' ||
      'CONNECTION_TIMEOUT' => ApiFailureNetworkTimeout(customMessage: message),
      'NETWORK_002' ||
      'NO_INTERNET' => ApiFailureNoInternet(customMessage: message),
      'RATE_LIMIT' ||
      'TOO_MANY_REQUESTS' => ApiFailureRateLimit(customMessage: message),
      _ => ApiFailureUnknown(newCode: code, customMessage: message),
    };
  }

  /// Factory para crear desde JSON de respuesta de API
  factory ApiFailure.fromJson(Map<String, dynamic> json) {
    final code =
        json['code'] as String? ?? json['error_code'] as String? ?? 'UNKNOWN';
    final message =
        json['message'] as String? ?? json['error_message'] as String?;

    return ApiFailure.fromCode(code, message: message);
  }

  /// Obtiene el mensaje final (personalizado o por defecto)
  String get message => customMessage ?? defaultMessage;

  /// Mensaje por defecto basado en el tipo de failure
  String get defaultMessage {
    return switch (this) {
      ApiFailureUnauthorized() => 'No autorizado para realizar esta acción',
      ApiFailureInvalidToken() => 'Token de autenticación inválido',
      ApiFailureTokenExpired() => 'Token de autenticación expirado',
      ApiFailureValidation() => 'Los datos proporcionados no son válidos',
      ApiFailureRequiredField() => 'Falta un campo obligatorio',
      ApiFailureServerError() => 'Error interno del servidor',
      ApiFailureServiceUnavailable() => 'Servicio temporalmente no disponible',
      ApiFailureNetworkTimeout() => 'Tiempo de conexión agotado',
      ApiFailureNoInternet() => 'Sin conexión a internet',
      ApiFailureRateLimit() => 'Demasiadas solicitudes, inténtalo más tarde',
      ApiFailureUnknown(code: String codeDos) => 'Error desconocido: $codeDos',
    };
  }

  /// Código de error asociado
  String get code {
    return when(
      unauthorized: () => 'AUTH_001',
      invalidToken: () => 'AUTH_002',
      tokenExpired: () => 'AUTH_003',
      validation: () => 'VALIDATION_001',
      requiredField: () => 'VALIDATION_002',
      serverError: () => 'SERVER_001',
      serviceUnavailable: () => 'SERVER_002',
      networkTimeout: () => 'NETWORK_001',
      noInternet: () => 'NETWORK_002',
      rateLimit: () => 'RATE_LIMIT',
      unknown: (code) => code,
    );
  }

  /// Serialización a JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'type': runtimeType.toString(),
    };
  }

  /// Para logging y debugging
  @override
  String toString() => 'ApiFailure(code: $code, message: $message)';

  // when
  R when<R>({
    required R Function() unauthorized,
    required R Function() invalidToken,
    required R Function() tokenExpired,
    required R Function() validation,
    required R Function() requiredField,
    required R Function() serverError,
    required R Function() serviceUnavailable,
    required R Function() networkTimeout,
    required R Function() noInternet,
    required R Function() rateLimit,
    required R Function(String code) unknown,
  }) {
    return switch (this) {
      ApiFailureUnauthorized() => unauthorized(),
      ApiFailureInvalidToken() => invalidToken(),
      ApiFailureTokenExpired() => tokenExpired(),
      ApiFailureValidation() => validation(),
      ApiFailureRequiredField() => requiredField(),
      ApiFailureServerError() => serverError(),
      ApiFailureServiceUnavailable() => serviceUnavailable(),
      ApiFailureNetworkTimeout() => networkTimeout(),
      ApiFailureNoInternet() => noInternet(),
      ApiFailureRateLimit() => rateLimit(),
      ApiFailureUnknown(newCode: final codeDos) => unknown(codeDos),
    };
  }
}

// Failures de autenticación
final class ApiFailureUnauthorized extends ApiFailure {
  const ApiFailureUnauthorized({super.customMessage});
}

final class ApiFailureInvalidToken extends ApiFailure {
  const ApiFailureInvalidToken({super.customMessage});
}

final class ApiFailureTokenExpired extends ApiFailure {
  const ApiFailureTokenExpired({super.customMessage});
}

// Failures de validación
final class ApiFailureValidation extends ApiFailure {
  const ApiFailureValidation({super.customMessage});
}

final class ApiFailureRequiredField extends ApiFailure {
  const ApiFailureRequiredField({super.customMessage});
}

// Failures de servidor
final class ApiFailureServerError extends ApiFailure {
  const ApiFailureServerError({super.customMessage});
}

final class ApiFailureServiceUnavailable extends ApiFailure {
  const ApiFailureServiceUnavailable({super.customMessage});
}

// Failures de red
final class ApiFailureNetworkTimeout extends ApiFailure {
  const ApiFailureNetworkTimeout({super.customMessage});
}

final class ApiFailureNoInternet extends ApiFailure {
  const ApiFailureNoInternet({super.customMessage});
}

// Failures de límites
final class ApiFailureRateLimit extends ApiFailure {
  const ApiFailureRateLimit({super.customMessage});
}

// Failure genérico para casos no contemplados
final class ApiFailureUnknown extends ApiFailure {
  final String newCode;

  const ApiFailureUnknown({
    required this.newCode,
    super.customMessage,
  });
}
