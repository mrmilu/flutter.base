/// Ejemplos de uso del ApiFailure con sealed class
///
/// Este archivo muestra diferentes formas de usar el ApiFailure
/// en escenarios reales de desarrollo.
library;

import 'package:flutter/material.dart';

import '../failures/api_failure_example.dart';

class ApiFailureUsageExamples {
  /// Ejemplo 1: Manejo de respuesta de API con códigos de error
  static ApiFailure handleApiResponse(Map<String, dynamic> response) {
    // Simulando diferentes tipos de respuestas de API

    // Caso 1: API devuelve código y mensaje
    if (response.containsKey('error')) {
      return ApiFailure.fromJson({
        'code': response['error']['code'],
        'message': response['error']['message'],
      });
    }

    // Caso 2: API devuelve error_code directamente
    if (response.containsKey('error_code')) {
      return ApiFailure.fromCode(
        response['error_code'],
        message: response['error_message'],
      );
    }

    // Caso 3: Error HTTP sin detalles específicos
    final statusCode = response['status_code'] as int?;
    if (statusCode != null && statusCode >= 400) {
      return switch (statusCode) {
        401 => ApiFailure.fromCode('AUTH_001'),
        403 => ApiFailure.fromCode('AUTH_001'),
        422 => ApiFailure.fromCode('VALIDATION_001'),
        429 => ApiFailure.fromCode('RATE_LIMIT'),
        500 => ApiFailure.fromCode('SERVER_001'),
        503 => ApiFailure.fromCode('SERVER_002'),
        _ => ApiFailure.fromCode('UNKNOWN_HTTP_$statusCode'),
      };
    }

    return ApiFailure.fromCode('UNKNOWN');
  }

  /// Ejemplo 2: Pattern matching exhaustivo para manejo de UI
  static String getUiMessage(ApiFailure failure) {
    return switch (failure) {
      // Errores de autenticación - redirigir al login
      ApiFailureUnauthorized() ||
      ApiFailureInvalidToken() ||
      ApiFailureTokenExpired() =>
        'Tu sesión ha expirado. Por favor, inicia sesión nuevamente.',

      // Errores de validación - mostrar campos específicos
      ApiFailureValidation() || ApiFailureRequiredField() =>
        failure.message, // Usar mensaje específico de la API
      // Errores de servidor - mensaje genérico amigable
      ApiFailureServerError() || ApiFailureServiceUnavailable() =>
        'Estamos experimentando problemas técnicos. Inténtalo más tarde.',

      // Errores de red - consejos al usuario
      ApiFailureNetworkTimeout() =>
        'La conexión está tardando más de lo esperado. Verifica tu conexión.',

      ApiFailureNoInternet() =>
        'No hay conexión a internet. Revisa tu conectividad.',

      // Rate limiting - tiempo de espera
      ApiFailureRateLimit() =>
        'Has realizado demasiadas solicitudes. Espera unos minutos.',

      // Errores desconocidos - logging y mensaje genérico
      ApiFailureUnknown(code: final code) =>
        'Ha ocurrido un error inesperado ($code). Contacta con soporte.',
    };
  }

  /// Ejemplo 3: Determinar acciones basadas en el tipo de error
  static ErrorAction getErrorAction(ApiFailure failure) {
    return switch (failure) {
      // Errores que requieren re-autenticación
      ApiFailureUnauthorized() ||
      ApiFailureInvalidToken() ||
      ApiFailureTokenExpired() => ErrorAction.redirectToLogin,

      // Errores que el usuario puede corregir
      ApiFailureValidation() ||
      ApiFailureRequiredField() => ErrorAction.showValidationErrors,

      // Errores temporales - permitir reintentos
      ApiFailureNetworkTimeout() ||
      ApiFailureServiceUnavailable() ||
      ApiFailureRateLimit() => ErrorAction.allowRetry,

      // Errores de conectividad
      ApiFailureNoInternet() => ErrorAction.showOfflineMode,

      // Errores graves - reportar
      ApiFailureServerError() || ApiFailureUnknown() => ErrorAction.reportError,
    };
  }

  /// Ejemplo 4: Logging estructurado basado en el tipo de error
  static void logError(ApiFailure failure) {
    final baseData = {
      'error_code': failure.code,
      'error_message': failure.message,
      'error_type': failure.runtimeType.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    switch (failure) {
      // Errores de autenticación - log de seguridad
      case ApiFailureUnauthorized() ||
          ApiFailureInvalidToken() ||
          ApiFailureTokenExpired():
        _logSecurity({
          ...baseData,
          'severity': 'warning',
          'category': 'authentication',
        });

      // Errores de validación - log de datos
      case ApiFailureValidation() || ApiFailureRequiredField():
        _logValidation({
          ...baseData,
          'severity': 'info',
          'category': 'validation',
        });

      // Errores de servidor - log crítico
      case ApiFailureServerError():
        _logCritical({
          ...baseData,
          'severity': 'error',
          'category': 'server',
          'requires_investigation': true,
        });

      // Errores de red - log de infraestructura
      case ApiFailureNetworkTimeout() ||
          ApiFailureNoInternet() ||
          ApiFailureServiceUnavailable():
        _logInfrastructure({
          ...baseData,
          'severity': 'warning',
          'category': 'network',
        });

      // Rate limiting - log de uso
      case ApiFailureRateLimit():
        _logUsage({
          ...baseData,
          'severity': 'warning',
          'category': 'rate_limit',
        });

      // Errores desconocidos - log para investigación
      case ApiFailureUnknown(code: final code):
        _logUnknown({
          ...baseData,
          'severity': 'error',
          'category': 'unknown',
          'original_code': code,
          'needs_analysis': true,
        });
    }
  }

  /// Ejemplo 5: Creación de failure desde diferentes fuentes
  static void demonstrateCreation() {
    // Desde código de API
    var failure1 = ApiFailure.fromCode('AUTH_001');
    debugPrint('From code: ${failure1.message}');

    // Desde JSON de respuesta
    var failure2 = ApiFailure.fromJson({
      'error_code': 'VALIDATION_001',
      'error_message': 'Email is required',
    });
    debugPrint('From JSON: ${failure2.message}');

    // Con mensaje personalizado
    var failure3 = ApiFailure.fromCode(
      'SERVER_001',
      message: 'Database connection failed',
    );
    debugPrint('With custom message: ${failure3.message}');

    // Serialización de vuelta a JSON
    var json = failure3.toJson();
    debugPrint('Serialized: $json');
  }

  // Métodos de logging simulados
  static void _logSecurity(Map<String, dynamic> data) {
    debugPrint('SECURITY LOG: $data');
  }

  static void _logValidation(Map<String, dynamic> data) {
    debugPrint('VALIDATION LOG: $data');
  }

  static void _logCritical(Map<String, dynamic> data) {
    debugPrint('CRITICAL LOG: $data');
  }

  static void _logInfrastructure(Map<String, dynamic> data) {
    debugPrint('INFRASTRUCTURE LOG: $data');
  }

  static void _logUsage(Map<String, dynamic> data) {
    debugPrint('USAGE LOG: $data');
  }

  static void _logUnknown(Map<String, dynamic> data) {
    debugPrint('UNKNOWN LOG: $data');
  }
}

/// Enum para definir acciones basadas en el tipo de error
enum ErrorAction {
  redirectToLogin,
  showValidationErrors,
  allowRetry,
  showOfflineMode,
  reportError,
}
