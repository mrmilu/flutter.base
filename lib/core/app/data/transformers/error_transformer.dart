import 'package:dio/dio.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';

void errorsHandler(DioException error) {
  final String apiErrorMessage = _djangoApiRest(error.response);

  AppErrorCode? errorCode;
  final String path = error.response?.requestOptions.path ?? '';
  if (path.contains('login')) {
    errorCode = AppErrorCode.wrongCredentials;
  }

  switch (error.response?.statusCode) {
    case 400:
      throw AppError(
        message: apiErrorMessage,
        code: errorCode ?? AppErrorCode.badRequest,
      );
    case 401:
      throw AppError(
        message: apiErrorMessage,
        code: errorCode ?? AppErrorCode.unauthorized,
      );
    case 403:
      throw AppError(
        message: apiErrorMessage,
        code: errorCode ?? AppErrorCode.forbidden,
      );
    case 404:
      throw AppError(
        message: apiErrorMessage,
        code: errorCode ?? AppErrorCode.notFound,
      );
    case 500:
      throw AppError(
        message: apiErrorMessage,
        code: errorCode ?? AppErrorCode.internalServer,
      );
    default:
      throw AppError(
        message: apiErrorMessage,
        code: AppErrorCode.generalError,
      );
  }
}

// Parsing Django REST framework exceptions
// Reference: https://www.django-rest-framework.org/api-guide/exceptions/
String _djangoApiRest(Response? response) {
  String apiErrorMessage = '';
  if (response != null) {
    final data = response.data;
    if (data is Map) {
      apiErrorMessage = data['detail'] ?? data.toString();
      if (data['non_field_errors'] != null) {
        final List list = data['non_field_errors'];
        apiErrorMessage = list.first.toString();
      }
    }
    if (data is List) {
      apiErrorMessage = data.first.toString();
    }
    if (apiErrorMessage.isEmpty) {
      apiErrorMessage = response.statusMessage ?? '';
    }
  } else {
    apiErrorMessage = 'Empty or invalid response';
  }
  return apiErrorMessage;
}
