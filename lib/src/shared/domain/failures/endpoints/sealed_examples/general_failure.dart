/// Ejemplo de failure usando sealed class
/// Maneja códigos de error de API y mensajes personalizados
sealed class GeneralFailure {
  /// Mensaje de error personalizado (puede venir de la API)
  final String? customMessage;

  const GeneralFailure({this.customMessage});

  /// Factory para crear un failure desde código de API
  factory GeneralFailure.fromCode(String code, {String? message}) {
    return switch (code) {
      'AUTH_001' ||
      'UNAUTHORIZED' => GeneralFailureUnauthorized(customMessage: message),
      'AUTH_002' ||
      'INVALID_TOKEN' => GeneralFailureInvalidToken(customMessage: message),
      'AUTH_003' ||
      'TOKEN_EXPIRED' => GeneralFailureTokenExpired(customMessage: message),
      'SERVER_001' ||
      'INTERNAL_ERROR' => GeneralFailureServerError(customMessage: message),
      'NETWORK_001' || 'CONNECTION_TIMEOUT' => GeneralFailureNetworkTimeout(
        customMessage: message,
      ),
      'NETWORK_002' ||
      'NO_INTERNET' => GeneralFailureNoInternet(customMessage: message),
      _ => GeneralFailureUnknown(newCode: code, customMessage: message),
    };
  }

  /// Factory para crear desde JSON de respuesta de API
  factory GeneralFailure.fromJson(Map<String, dynamic> json) {
    final code =
        json['code'] as String? ?? json['error_code'] as String? ?? 'UNKNOWN';
    final message =
        json['message'] as String? ?? json['error_message'] as String?;

    return GeneralFailure.fromCode(code, message: message);
  }

  /// Obtiene el mensaje final (personalizado o por defecto)
  String get message => customMessage ?? defaultMessage;

  /// Mensaje por defecto basado en el tipo de failure
  String get defaultMessage {
    return switch (this) {
      GeneralFailureUnauthorized() => 'No autorizado para realizar esta acción',
      GeneralFailureInvalidToken() => 'Token de autenticación inválido',
      GeneralFailureTokenExpired() => 'Token de autenticación expirado',
      GeneralFailureServerError() => 'Error interno del servidor',
      GeneralFailureNetworkTimeout() => 'Tiempo de conexión agotado',
      GeneralFailureNoInternet() => 'Sin conexión a internet',
      GeneralFailureUnknown(code: String codeDos) =>
        'Error desconocido: $codeDos',
    };
  }

  /// Código de error asociado
  String get code {
    return when(
      unauthorized: () => 'AUTH_001',
      invalidToken: () => 'AUTH_002',
      tokenExpired: () => 'AUTH_003',
      serverError: () => 'SERVER_001',
      networkTimeout: () => 'NETWORK_001',
      noInternet: () => 'NETWORK_002',
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
  String toString() => 'GeneralFailure(code: $code, message: $message)';

  // when
  R when<R>({
    required R Function() unauthorized,
    required R Function() invalidToken,
    required R Function() tokenExpired,
    required R Function() serverError,
    required R Function() networkTimeout,
    required R Function() noInternet,
    required R Function(String code) unknown,
  }) {
    return switch (this) {
      GeneralFailureUnauthorized() => unauthorized(),
      GeneralFailureInvalidToken() => invalidToken(),
      GeneralFailureTokenExpired() => tokenExpired(),
      GeneralFailureServerError() => serverError(),
      GeneralFailureNetworkTimeout() => networkTimeout(),
      GeneralFailureNoInternet() => noInternet(),
      GeneralFailureUnknown(newCode: final codeDos) => unknown(codeDos),
    };
  }
}

// Failures de autenticación
final class GeneralFailureUnauthorized extends GeneralFailure {
  const GeneralFailureUnauthorized({super.customMessage});
}

final class GeneralFailureInvalidToken extends GeneralFailure {
  const GeneralFailureInvalidToken({super.customMessage});
}

final class GeneralFailureTokenExpired extends GeneralFailure {
  const GeneralFailureTokenExpired({super.customMessage});
}

// Failures de servidor
final class GeneralFailureServerError extends GeneralFailure {
  const GeneralFailureServerError({super.customMessage});
}

// Failures de red
final class GeneralFailureNetworkTimeout extends GeneralFailure {
  const GeneralFailureNetworkTimeout({super.customMessage});
}

final class GeneralFailureNoInternet extends GeneralFailure {
  const GeneralFailureNoInternet({super.customMessage});
}

// Failure genérico para casos no contemplados
final class GeneralFailureUnknown extends GeneralFailure {
  final String newCode;

  const GeneralFailureUnknown({
    required this.newCode,
    super.customMessage,
  });
}
