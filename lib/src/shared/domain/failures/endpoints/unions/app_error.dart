import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppBaseError with _$AppBaseError {
  const factory AppBaseError.unauthorized({
    @Default('No estás autorizado. Por favor, inicia sesión.') String message,
  }) = Unauthorized;

  const factory AppBaseError.internalError({
    @Default('Error interno del servidor. Intenta más tarde.') String message,
  }) = InternalError;

  const factory AppBaseError.networkError({
    @Default('Sin conexión a internet. Verifica tu red.') String message,
  }) = NetworkError;

  const factory AppBaseError.timeoutError({
    @Default('La solicitud tardó demasiado. Intenta de nuevo.') String message,
  }) = TimeoutError;

  const factory AppBaseError.invalidResponseFormat({
    @Default('Formato de respuesta inválido. Contacta soporte.') String message,
  }) = InvalidResponseFormat;

  const factory AppBaseError.unexpectedError({
    @Default('Error inesperado. Intenta más tarde.') String message,
  }) = UnexpectedError;

  const AppBaseError._();

  @override
  String get message => when(
    unauthorized: (message) => message,
    internalError: (message) => message,
    networkError: (message) => message,
    timeoutError: (message) => message,
    invalidResponseFormat: (message) => message,
    unexpectedError: (message) => message,
  );

  dynamic get typeError => when(
    unauthorized: (message) => Unauthorized(message: message),
    internalError: (message) => InternalError(message: message),
    networkError: (message) => NetworkError(message: message),
    timeoutError: (message) => TimeoutError(message: message),
    invalidResponseFormat: (message) => InvalidResponseFormat(message: message),
    unexpectedError: (message) => UnexpectedError(message: message),
  );

  String get codeError => when(
    unauthorized: (_) => 'unauthorized',
    internalError: (_) => 'internalError',
    networkError: (_) => 'networkError',
    timeoutError: (_) => 'timeoutError',
    invalidResponseFormat: (_) => 'invalidResponseFormat',
    unexpectedError: (_) => 'unexpectedError',
  );

  static AppBaseError fromString(String code, String? message) {
    return switch (code) {
      'unauthorized' => Unauthorized(
        message: message ?? 'No estás autorizado. Por favor, inicia sesión.',
      ),
      'internalError' => InternalError(
        message: message ?? 'Error interno del servidor. Intenta más tarde.',
      ),
      'networkError' => NetworkError(
        message: message ?? 'Sin conexión a internet. Verifica tu red.',
      ),
      'timeoutError' => TimeoutError(
        message: message ?? 'La solicitud tardó demasiado. Intenta de nuevo.',
      ),
      'invalidResponseFormat' => InvalidResponseFormat(
        message: message ?? 'Formato de respuesta inválido. Contacta soporte.',
      ),
      'unexpectedError' => UnexpectedError(
        message: message ?? 'Error inesperado. Intenta más tarde.',
      ),
      _ => UnexpectedError(
        message: message ?? 'Error inesperado. Intenta más tarde.',
      ),
    };
  }
}
