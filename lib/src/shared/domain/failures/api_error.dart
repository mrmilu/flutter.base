// lib/core/errors/app_error.dart

import 'package:flutter/material.dart';

/// Clase base sealed para todos los errores de la app.
/// Permite manejar exhaustivamente con switch y extender para endpoints específicos.
sealed class AppError {
  final String message;

  const AppError(this.message);
}

/// Errores comunes genéricos que todos los endpoints heredan.
final class Unauthorized extends AppError {
  Unauthorized() : super('No estás autorizado. Por favor, inicia sesión.');
}

final class InternalError extends AppError {
  InternalError() : super('Error interno del servidor. Intenta más tarde.');
}

final class NetworkError extends AppError {
  NetworkError() : super('Sin conexión a internet. Verifica tu red.');
}

final class TimeoutError extends AppError {
  TimeoutError() : super('La solicitud tardó demasiado. Intenta de nuevo.');
}

final class InvalidResponseFormat extends AppError {
  InvalidResponseFormat()
    : super('Formato de respuesta inválido. Contacta soporte.');
}

final class UnexpectedError extends AppError {
  UnexpectedError([String? customMessage])
    : super(customMessage ?? 'Error inesperado. Intenta de nuevo.');
}

/// Errores específicos del endpoint de usuarios, que extiende los genéricos de AppError.
sealed class UserEndpointError extends AppError {
  UserEndpointError(super.message);
}

/// Errores adicionales específicos.
final class UserNotFound extends UserEndpointError {
  UserNotFound(super.message);
}

final class InvalidCredentials extends UserEndpointError {
  InvalidCredentials() : super('Credenciales inválidas.');
}

final class InvalidCredentialTwo extends UserEndpointError {
  InvalidCredentialTwo() : super('Credenciales inválidas.');
}

extension ApiFailureTranslation on AppError {
  String toTranslation(BuildContext context) {
    return switch (this) {
      Unauthorized() => 'error.unauthorized',
      InternalError() => 'error.internal_error',
      NetworkError() => 'error.network_error',
      TimeoutError() => 'error.timeout_error',
      InvalidResponseFormat() => 'error.invalid_response_format',
      UnexpectedError() => 'error.unexpected_error',
      UserNotFound() => 'error.user_not_found',
      InvalidCredentials() => 'error.invalid_credentials',
      InvalidCredentialTwo() => 'error.invalid_credentials',
    };
  }
}

extension UserEndpointErrorTranslation on UserEndpointError {
  String toTranslation(BuildContext context) {
    return switch (this) {
      UserNotFound() => 'error.user_not_found',
      InvalidCredentials() => 'error.invalid_credentials',
      InvalidCredentialTwo() => 'error.invalid_credentials',
    };
  }
}
