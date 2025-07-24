import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../shared/helpers/result_or.dart';
import '../../../shared/presentation/utils/extensions/dio_exception_extension.dart';
import '../../domain/failures/change_email_failure.dart';
import '../../domain/failures/change_password_failure.dart';
import '../../domain/failures/personal_data_failure.dart';
import '../../domain/failures/required_password_failure.dart';
import '../../domain/interfaces/i_personal_info_repository.dart';

class PersonalInfoRepositoryImpl extends IPersonalInfoRepository {
  final Dio httpClient;
  final ITokenRepository tokenRepository;
  PersonalInfoRepositoryImpl({
    required this.httpClient,
    required this.tokenRepository,
  });

  @override
  Future<ResultOr<PersonalDataFailure>> setPersonalData({
    required String name,
    required String lastName,
    required String phone,
  }) async {
    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));

      await httpClient.patch(
        'update_user',
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
          PersonalDataFailure.fromString,
          PersonalDataFailure.unknown,
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(PersonalDataFailure.unknown);
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
          RequiredPasswordFailure.unknown,
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(RequiredPasswordFailure.unknown);
    }
  }

  @override
  Future<ResultOr<ChangeEmailFailure>> changeEmail({
    required String email,
  }) async {
    try {
      await httpClient.patch(
        '/api/users',
        data: {
          'email': email,
        },
      );
      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          ChangeEmailFailure.fromString,
          ChangeEmailFailure.unknown,
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(ChangeEmailFailure.unknown);
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
          ChangePasswordFailure.unknown,
        ),
      );
    } catch (e, s) {
      log('e, s', error: e, stackTrace: s);
      return ResultOr.failure(ChangePasswordFailure.unknown);
    }
  }
}
