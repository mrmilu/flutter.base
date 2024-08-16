import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Abstraction of dio library to Api REST implementations
class DioRestService {
  /// Use [baseUrl] to config a base url of api, like `https://api.mrmilu.com`
  final String baseUrl;

  /// Use optional [interceptors] to configure a interceptors list
  final List<Interceptor> interceptors;

  /// Optional [catchErrors] to get DioError. This is useful when need
  /// transform a DioError to custom error.
  final void Function(DioException)? catchErrors;

  /// Receive timeout in milliseconds
  ///
  /// By default `15` seconds
  final int receiveTimeout;

  /// Connect timeout in milliseconds
  ///
  /// By default `15` seconds
  final int connectTimeout;

  /// Send timeout in milliseconds
  ///
  /// By default `15` seconds
  final int sendTimeout;

  /// Valid codes to requests
  /// If some code is outside this list, the request will be throw a DioError
  ///
  /// By default `[200]`
  final List<int> validCodes;

  /// Http request headers. The keys of initial headers will be converted to lowercase,
  /// for example 'Content-Type' will be converted to 'content-type'.

  /// The key of Header Map is case-insensitive,
  /// eg: content-type and Content-Type are regard as the same key.
  final Map<String, dynamic>? headers;

  @internal
  late Dio dio;

  DioRestService({
    required this.baseUrl,
    this.interceptors = const [],
    this.catchErrors,
    this.receiveTimeout = 15000,
    this.connectTimeout = 15000,
    this.sendTimeout = 15000,
    this.validCodes = const [200],
    this.headers,
  }) {
    _initClient();
  }

  void _initClient() {
    final Dio initDio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        connectTimeout: Duration(milliseconds: connectTimeout),
        sendTimeout: Duration(milliseconds: sendTimeout),
        headers: headers,
        validateStatus: (int? code) => validCodes.contains(code),
      ),
    );

    if (interceptors.isNotEmpty) {
      initDio.interceptors.addAll(interceptors);
    }
    dio = initDio;
    return;
  }

  Future<T?> get<T>(
    String endpointPath, {
    Map<String, dynamic>? queryParam,
  }) async {
    return _tryCatch(
      () async {
        final response = await dio.get<T>(
          endpointPath,
          queryParameters: queryParam,
        );
        return response.data;
      },
    );
  }

  Future<T?> post<T>(
    String endpointPath, {
    data,
    Map<String, dynamic>? queryParam,
  }) async {
    return _tryCatch<T>(
      () async {
        final response = await dio.post<T>(
          endpointPath,
          data: data,
          queryParameters: queryParam,
        );
        return response.data;
      },
    );
  }

  Future<T?> put<T>(
    String endpointPath, {
    data,
    Map<String, dynamic>? queryParam,
  }) async {
    return _tryCatch<T>(
      () async {
        final response = await dio.put<T>(
          endpointPath,
          data: data,
          queryParameters: queryParam,
        );
        return response.data;
      },
    );
  }

  Future<T?> delete<T>(
    String endpointPath, {
    data,
    Map<String, dynamic>? queryParam,
  }) async {
    return _tryCatch<T>(
      () async {
        final response = await dio.delete<T>(
          endpointPath,
          data: data,
          queryParameters: queryParam,
        );
        return response.data;
      },
    );
  }

  Future<T?> patch<T>(
    String endpointPath, {
    data,
    Map<String, dynamic>? queryParam,
  }) async {
    return _tryCatch<T>(
      () async {
        final response = await dio.patch<T>(
          endpointPath,
          data: data,
          queryParameters: queryParam,
        );
        return response.data;
      },
    );
  }

  Future<T?> _tryCatch<T>(
    Future<T?> Function() function,
  ) async {
    try {
      return await function();
    } on DioException catch (e) {
      log('$runtimeType/DioError: ${e.error.toString()}');
      if (catchErrors == null) {
        rethrow;
      }
      catchErrors!(e);
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
