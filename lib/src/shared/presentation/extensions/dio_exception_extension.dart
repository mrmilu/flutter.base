import 'package:dio/dio.dart';

import '../../domain/failures/endpoints/general_base_failure.dart';

extension DioExceptionExtension on DioException {
  String? get apiErrorCode {
    return response?.data['detail']['code'] as String?;
  }

  String? get apiErrorMessage {
    return response?.data['detail']['message'] as String?;
  }

  T toFailure<T>(
    T Function(String errorCode, String? message) fromString,
    T Function(GeneralBaseFailure gF) fromGeneralFailure,
  ) {
    // Si tenemos un código de error específico de la API, lo usamos
    if (apiErrorCode != null) {
      return fromString(apiErrorCode!, apiErrorMessage);
    }

    // Si no hay código específico, mapeamos según el tipo de error de Dio
    final gF = _mapDioExceptionToGeneralFailure();
    return fromGeneralFailure(gF);
  }

  /// Mapea un DioException a un GeneralBaseFailure específico
  GeneralBaseFailure _mapDioExceptionToGeneralFailure() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return GeneralBaseFailure.timeoutError(
          message:
              apiErrorMessage ??
              'La solicitud tardó demasiado. Intenta de nuevo.',
        );

      case DioExceptionType.connectionError:
        return GeneralBaseFailure.networkError(
          message: apiErrorMessage ?? 'Ha falado la conexión',
        );

      case DioExceptionType.badResponse:
        return _mapHttpStatusToFailure();

      case DioExceptionType.cancel:
        return GeneralBaseFailure.networkError(
          message: apiErrorMessage ?? 'Solicitud cancelada.',
        );

      case DioExceptionType.badCertificate:
        return GeneralBaseFailure.networkError(
          message: apiErrorMessage ?? 'Error de certificado SSL.',
        );

      case DioExceptionType.unknown:
        return GeneralBaseFailure.unexpectedError(
          message: apiErrorMessage ?? 'Error inesperado. Intenta más tarde.',
        );
    }
  }

  /// Mapea códigos de estado HTTP a failures específicos
  GeneralBaseFailure _mapHttpStatusToFailure() {
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 401:
        return GeneralBaseFailure.unauthorized(
          message:
              apiErrorMessage ??
              'No estás autorizado. Por favor, inicia sesión.',
        );

      case 403:
        return GeneralBaseFailure.unauthorized(
          message:
              apiErrorMessage ??
              'No tienes permisos para realizar esta acción.',
        );

      case 404:
        return GeneralBaseFailure.internalError(
          message: apiErrorMessage ?? 'Recurso no encontrado.',
        );

      case 422:
        return GeneralBaseFailure.invalidResponseFormat(
          message: apiErrorMessage ?? 'Datos de entrada inválidos.',
        );

      case 429:
        return GeneralBaseFailure.networkError(
          message:
              apiErrorMessage ?? 'Demasiadas solicitudes. Intenta más tarde.',
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return GeneralBaseFailure.internalError(
          message:
              apiErrorMessage ??
              'Error interno del servidor. Intenta más tarde.',
        );

      default:
        // Para respuestas con formato inválido o códigos desconocidos
        if (response?.data == null || response?.data is! Map<String, dynamic>) {
          return GeneralBaseFailure.invalidResponseFormat(
            message: apiErrorMessage ?? 'Formato de respuesta inválido.',
          );
        }

        return GeneralBaseFailure.unexpectedError(
          message: apiErrorMessage ?? 'Error inesperado. Intenta más tarde.',
        );
    }
  }
}
