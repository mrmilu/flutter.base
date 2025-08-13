import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_base_failure.freezed.dart';

@freezed
abstract class GeneralBaseFailure with _$GeneralBaseFailure {
  const factory GeneralBaseFailure.unauthorized({
    @Default('unauthorized') String code,
    @Default('No estás autorizado. Por favor, inicia sesión.') String message,
  }) = GeneralBaseFailureUnauthorized;

  const factory GeneralBaseFailure.internalError({
    @Default('internalError') String code,
    @Default('Error interno del servidor. Intenta más tarde.') String message,
  }) = GeneralBaseFailureInternalError;

  const factory GeneralBaseFailure.networkError({
    @Default('networkError') String code,
    @Default('Sin conexión a internet. Verifica tu red.') String message,
  }) = GeneralBaseFailureNetworkError;

  const factory GeneralBaseFailure.timeoutError({
    @Default('timeoutError') String code,
    @Default('La solicitud tardó demasiado. Intenta de nuevo.') String message,
  }) = GeneralBaseFailureTimeoutError;

  const factory GeneralBaseFailure.invalidResponseFormat({
    @Default('invalidResponseFormat') String code,
    @Default('Formato de respuesta inválido. Contacta soporte.') String message,
  }) = GeneralBaseFailureInvalidResponseFormat;

  const factory GeneralBaseFailure.unexpectedError({
    @Default('unexpectedError') String code,
    @Default('Error inesperado. Intenta más tarde.') String message,
  }) = GeneralBaseFailureUnexpectedError;

  const GeneralBaseFailure._();

  dynamic get typeError => when(
    unauthorized: (code, message) =>
        GeneralBaseFailure.unauthorized(code: code, message: message),
    internalError: (code, message) =>
        GeneralBaseFailure.internalError(code: code, message: message),
    networkError: (code, message) =>
        GeneralBaseFailure.networkError(code: code, message: message),
    timeoutError: (code, message) =>
        GeneralBaseFailure.timeoutError(code: code, message: message),
    invalidResponseFormat: (code, message) =>
        GeneralBaseFailure.invalidResponseFormat(code: code, message: message),
    unexpectedError: (code, message) =>
        GeneralBaseFailure.unexpectedError(code: code, message: message),
  );

  static GeneralBaseFailure fromString(String code, [String? message]) {
    return switch (code) {
      'unauthorized' => GeneralBaseFailure.unauthorized(
        code: code,
        message: message ?? 'No estás autorizado. Por favor, inicia sesión.',
      ),
      'internalError' => GeneralBaseFailure.internalError(
        code: code,
        message: message ?? 'Error interno del servidor. Intenta más tarde.',
      ),
      'networkError' => GeneralBaseFailure.networkError(
        code: code,
        message: message ?? 'Sin conexión a internet. Verifica tu red.',
      ),
      'timeoutError' => GeneralBaseFailure.timeoutError(
        code: code,
        message: message ?? 'La solicitud tardó demasiado. Intenta de nuevo.',
      ),
      'invalidResponseFormat' => GeneralBaseFailure.invalidResponseFormat(
        code: code,
        message: message ?? 'Formato de respuesta inválido. Contacta soporte.',
      ),
      _ => GeneralBaseFailure.unexpectedError(
        code: code,
        message: message ?? 'Error inesperado. Intenta más tarde.',
      ),
    };
  }
}
