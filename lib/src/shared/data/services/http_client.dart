import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../auth/presentation/pages/initial_page.dart';
import '../../../locale/presentation/providers/locale_cubit.dart';
import '../../../splash/presentation/providers/splash_cubit.dart';
import '../../helpers/toasts.dart';
import '../../presentation/router/app_router.dart';
import '../../presentation/router/page_names.dart';
import '../../presentation/utils/extensions/buildcontext_extensions.dart';

final baseOptions = BaseOptions(
  baseUrl:
      (kReleaseMode
          ? dotenv.env['API_URL_RELEASE']
          : dotenv.env['API_URL_DEBUG']) ??
      'https://flutterbase.com',
  headers: {
    'Content-Type': 'application/json; charset=utf-8',
  },
);

class AuthInterceptor extends Interceptor {
  final ITokenRepository tokenRepository;
  AuthInterceptor({required this.tokenRepository});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userToken = await tokenRepository.getToken();

    if (kDebugMode) {
      print('Authorization token $userToken');
      print(options.uri.toString());
    }

    if (userToken != null) {
      final version = appVersion;
      final appLanguage = appLocaleCode;

      _updateHeader(options, userToken, version, appLanguage);
    }

    return super.onRequest(options, handler);
  }

  void _updateHeader(
    RequestOptions options,
    String accessToken,
    String appVersion,
    String appLanguage,
  ) {
    options.headers.addAll(<String, String>{
      'Authorization': 'token $accessToken',
      'Accept-Language': appLanguage,
      'App-Version': appVersion,
      'App-Language': appLanguage,
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('Response: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (kDebugMode) {
      print('Error DIO: ${err.message}');
    }
    final request = err.requestOptions;
    if (err.response?.statusCode == 401 &&
        !request.extra.containsKey('retry')) {
      try {
        final newToken = await tokenRepository.refreshToken();
        if (newToken != null) {
          request.extra['retry'] = true;
          request.headers['Authorization'] = 'token $newToken';
          final clonedRequest = await Dio().fetch(request);
          return handler.resolve(clonedRequest);
        }
        clearFor401(err, tokenRepository);
      } catch (e) {
        clearFor401(err, tokenRepository);
      }
    }

    super.onError(err, handler);
  }
}

void clearFor401(
  DioException err,
  ITokenRepository tokenRepository,
) async {
  if (err.response?.statusCode == 401) {
    await tokenRepository.clear();
    final currentContext = rootNavigatorKey.currentContext;
    if (currentContext != null && currentContext.mounted) {
      showInfo(currentContext, message: currentContext.l10n.sesionExpired);
      routerApp.goNamed(
        PageNames.initial,
        extra: InitialStep.signInEmail.index,
      );
    }
  }
}

Dio getMyHttpClient(ITokenRepository tokenRepository) {
  final httpClient = Dio(baseOptions)
    ..interceptors.add(
      AuthInterceptor(
        tokenRepository: tokenRepository,
      ),
    );

  return httpClient;
}
