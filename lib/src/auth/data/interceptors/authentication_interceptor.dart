import 'package:dio/dio.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';

class AuthorizationInterceptor extends QueuedInterceptorsWrapper {
  final ITokenRepository tokenRepository;

  AuthorizationInterceptor({required this.tokenRepository});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenRepository.getToken();

    if (token.isEmpty) {
      tokenRepository.clear();
      return handler.next(options);
    }
    _addTokenToHeader(options, token);
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      tokenRepository.clear();
    }
    handler.next(err);
  }

  void _addTokenToHeader(RequestOptions options, String accessToken) {
    options.headers
        .addAll(<String, String>{'Authorization': 'Token $accessToken'});
  }
}
