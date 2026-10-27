import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';

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

      return const ResultOr.success();
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
