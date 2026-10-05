import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../domain/failures/endpoints/general_base_failure.dart';
import '../extensions/dio_exception_extension.dart';
import 'resource.dart';
import 'result_or.dart';

final _log = Logger('HandleRequest');

Future<Resource<F, T>> handleRequest<F, T>({
  required Future<T> Function() request,
  required F Function(String, String?) fromString,
  required F Function(GeneralBaseFailure) general,
  T? mockData,
  bool useMockData = false,
}) async {
  try {
    if (useMockData && mockData != null) {
      await Future.delayed(const Duration(seconds: 1));
      return Resource.success(mockData);
    }
    final result = await request();
    return Resource.success(result);
  } on DioException catch (e) {
    _log.severe('DioException: ', e, e.stackTrace);
    return Resource.failure(
      e.toFailure(fromString, general),
    );
  } on Exception catch (e, s) {
    _log.severe('Error Resource: ', e, s);
    return Resource.failure(
      general(const GeneralBaseFailure.invalidResponseFormat()),
    );
  }
}

Future<ResultOr<F>> handleRequestResultOr<F>({
  required Future<void> Function() request,
  required F Function(String, String?) fromString,
  required F Function(GeneralBaseFailure) general,
  bool useMockData = false,
}) async {
  try {
    if (useMockData) {
      await Future.delayed(const Duration(seconds: 1));
      return ResultOr.success();
    }
    await request();
    return ResultOr.success();
  } on DioException catch (e) {
    _log.severe('DioException: ', e, e.stackTrace);
    return ResultOr.failure(
      e.toFailure(fromString, general),
    );
  } on Exception catch (e, s) {
    _log.severe('Error ResultOr: ', e, s);
    return ResultOr.failure(
      general(const GeneralBaseFailure.invalidResponseFormat()),
    );
  }
}
