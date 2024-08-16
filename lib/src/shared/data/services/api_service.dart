import 'package:flutter_base/src/auth/data/interceptors/authentication_interceptor.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/src/shared/data/services/dio_rest_service.dart';
import 'package:flutter_base/src/shared/data/transformers/error_transformer.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_env_vars.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

class ApiService extends DioRestService {
  ApiService({
    required super.baseUrl,
    required ITokenRepository tokenRepository,
  }) : super(
          validCodes: [200, 201, 204],
          catchErrors: errorsHandler,
          interceptors: [
            AuthorizationInterceptor(tokenRepository: tokenRepository),
          ],
        );
}

@module
abstract class ApiServiceModule {
  @lazySingleton
  ApiService get httpClient => ApiService(
        baseUrl: '${GetIt.I<IEnvVars>().apiUrl}/api',
        tokenRepository: GetIt.I<ITokenRepository>(),
      );
}
