import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../shared/domain/failures/endpoints/general_base_failure.dart';
import '../../../shared/presentation/extensions/dio_exception_extension.dart';
import '../../../shared/presentation/helpers/result_or.dart';
import '../../domain/failures/change_password_failure.dart';
import '../../domain/failures/change_user_info_failure.dart';
import '../../domain/failures/required_password_failure.dart';
import '../../domain/interfaces/i_personal_info_repository.dart';

class PersonalInfoRepositoryImpl implements IPersonalInfoRepository {
  final Dio httpClient;
  final ITokenRepository tokenRepository;
  PersonalInfoRepositoryImpl({
    required this.httpClient,
    required this.tokenRepository,
  });

  @override
  Future<ResultOr<ChangeUserInfoFailure>> setPersonalData({
    required String name,
    required String lastName,
    required String phone,
  }) async {
    try {
      await httpClient.patch(
        '/api/update_user',
        data: {
          'name': name,
          'lastName': lastName,
          'phone': phone,
        },
      );

      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          ChangeUserInfoFailure.fromString,
          const ChangeUserInfoFailure.general(
            GeneralBaseFailure.unexpectedError(),
          ),
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(
        const ChangeUserInfoFailure.general(
          GeneralBaseFailure.unexpectedError(),
        ),
      );
    }
  }

  @override
  Future<ResultOr<RequiredPasswordFailure>> checkPassword({
    required String password,
  }) async {
    try {
      // await httpClient.post(
      //   'check_password',
      //   data: {
      //     'password': password,
      //   },
      // );

      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          RequiredPasswordFailure.fromString,
          const RequiredPasswordFailure.general(
            GeneralBaseFailure.unexpectedError(),
          ),
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(
        const RequiredPasswordFailure.general(
          GeneralBaseFailure.unexpectedError(),
        ),
      );
    }
  }

  @override
  Future<ResultOr<ChangePasswordFailure>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/users/change-password',
        data: {
          'current_password': oldPassword,
          'new_password': newPassword,
        },
      );
      final token = response.data['token'];
      await tokenRepository.saveTokens(token: token);
      await tokenRepository.savePassword(newPassword);
      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          ChangePasswordFailure.fromString,
          const ChangePasswordFailure.general(
            GeneralBaseFailure.unexpectedError(),
          ),
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(
        const ChangePasswordFailure.general(
          GeneralBaseFailure.unexpectedError(),
        ),
      );
    }
  }
}
