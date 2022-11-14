import 'package:dio/dio.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/data/interceptors/authentication_interceptor.dart';


class ApiService extends DioRestService {
  ApiService({
    required super.baseUrl,
    required ITokenRepository tokenRepository,
  }) : super(
    validCodes: [200, 201, 204],
    catchErrors: ApiService.errorsHandler,
    interceptors: [
      AuthorizationInterceptor(tokenRepository: tokenRepository),
    ],
  );

  static errorsHandler (DioError error) {
    var apiErrorMessage = error.response?.data;
    if(apiErrorMessage is Map) {
    apiErrorMessage = apiErrorMessage.entries.first.value;
    }
    if(apiErrorMessage is List) {
      apiErrorMessage = apiErrorMessage.first;
    }

    AppErrorCode? errorCode;
    String path = error.response?.requestOptions.path ?? "";
    if(path.contains("login")) {
      errorCode = AppErrorCode.wrongCredentials;
    }

    switch (error.response?.statusCode) {
      case 401:
        throw AppError(message: apiErrorMessage ?? error.response?.statusMessage, code: AppErrorCode.unAuthorized);
      case 400:
        throw AppError(message: apiErrorMessage ?? error.response?.statusMessage, code: errorCode ?? AppErrorCode.badRequest);
      case 500:
      default:
        throw AppError(message: apiErrorMessage ?? error.response?.statusMessage, code: AppErrorCode.generalError);
    }
  }
}

@module
abstract class ApiServiceModule {
  @lazySingleton
  ApiService get httpClient => ApiService(
    baseUrl: "${GetIt.I<IEnvVars>().apiUrl}/api",
    tokenRepository: GetIt.I<ITokenRepository>(),
  );
}
