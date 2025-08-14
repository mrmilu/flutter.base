import '../../../shared/domain/failures/endpoints/change_password_firebase_failure.dart';
import '../../../shared/presentation/helpers/result_or.dart';

abstract class IChangePasswordRepository {
  Future<ResultOr<ChangePasswordFirebaseFailure>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
