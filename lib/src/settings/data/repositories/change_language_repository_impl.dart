import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../shared/presentation/extensions/dio_exception_extension.dart';
import '../../../shared/presentation/helpers/result_or.dart';
import '../../domain/failures/change_language_failure.dart';
import '../../domain/interfaces/i_change_language_repository.dart';

class ChangeLanguageRepositoryImpl implements IChangeLanguageRepository {
  final Dio _httpClient;
  ChangeLanguageRepositoryImpl(this._httpClient);

  @override
  Future<ResultOr<ChangeLanguageFailure>> changeLanguage(
    String languageCode,
  ) async {
    try {
      await _httpClient.patch(
        '/api/users',
        data: {
          'language': languageCode,
        },
      );

      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          ChangeLanguageFailure.fromString,
          ChangeLanguageFailure.unknown,
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(ChangeLanguageFailure.unknown);
    }
  }
}
