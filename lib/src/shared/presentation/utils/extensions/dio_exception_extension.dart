import 'package:dio/dio.dart';

import '../const.dart';

extension DioExceptionExtension on DioException {
  /// Obtiene el código de error desde la respuesta.
  String? get apiErrorCode {
    return response?.data['detail'][errorCode] as String?;
  }

  T toFailure<T>(T Function(String errorCode) fromString, T serverError) {
    if (response?.statusCode == 500 ||
        response?.statusCode == 403 ||
        response?.data == null) {
      return serverError;
    }

    if (response?.data is! Map<String, dynamic>) {
      return serverError;
    }

    final codeError = response?.data[errorCode];
    if (codeError == null || codeError is! String) {
      return serverError;
    }

    return fromString(errorCode);
  }
}
