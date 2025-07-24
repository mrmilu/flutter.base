import '../../../shared/helpers/result_or.dart';
import '../failures/change_email_failure.dart';
import '../failures/change_password_failure.dart';
import '../failures/personal_data_failure.dart';
import '../failures/required_password_failure.dart';

abstract class IPersonalInfoRepository {
  Future<ResultOr<PersonalDataFailure>> setPersonalData({
    required String name,
    required String lastName,
    required String phone,
  });

  Future<ResultOr<RequiredPasswordFailure>> checkPassword({
    required String password,
  });

  Future<ResultOr<ChangeEmailFailure>> changeEmail({
    required String email,
  });

  Future<ResultOr<ChangePasswordFailure>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
