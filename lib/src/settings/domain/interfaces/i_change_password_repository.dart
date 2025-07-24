import '../../../shared/domain/failures/change_password_firebase_failure.dart';
import '../../../shared/helpers/result_or.dart';

abstract class IChangePasswordRepository {
  Future<ResultOr<ChangePasswordFirebaseFailure>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
