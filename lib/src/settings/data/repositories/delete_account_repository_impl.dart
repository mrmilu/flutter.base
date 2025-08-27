import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';
import '../../../shared/presentation/extensions/dio_exception_extension.dart';
import '../../../shared/presentation/helpers/result_or.dart';
import '../../domain/failures/delete_account_failure.dart';
import '../../domain/interfaces/i_delete_account_repository.dart';

class DeleteAccountRepositoryImpl implements IDeleteAccountRepository {
  final Dio _httpClient;
  DeleteAccountRepositoryImpl(this._httpClient);

  @override
  Future<ResultOr<DeleteAccountFailure>> deleteAccount() async {
    try {
      await _httpClient.delete(
        '/api/users',
      );

      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          DeleteAccountFailure.fromString,
          (gF) => DeleteAccountFailure.general(gF),
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(
        DeleteAccountFailure.general(
          GeneralBaseFailure.unexpectedError(message: e.toString()),
        ),
      );
    }
  }
}
