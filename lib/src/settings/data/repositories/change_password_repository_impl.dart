import 'package:firebase_auth/firebase_auth.dart';

import '../../../shared/domain/failures/change_password_firebase_failure.dart';
import '../../../shared/helpers/result_or.dart';
import '../../domain/interfaces/i_change_password_repository.dart';

class ChangePasswordRepositoryImpl extends IChangePasswordRepository {
  @override
  Future<ResultOr<ChangePasswordFirebaseFailure>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: oldPassword,
      );
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
        credential,
      );
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      return ResultOr.success();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return ResultOr.failure(
            const ChangePasswordFirebaseFailure.wrongPassword(),
          );
        case 'invalid-credential':
          return ResultOr.failure(
            const ChangePasswordFirebaseFailure.invalidCredential(),
          );
        case 'invalid-argument':
          return ResultOr.failure(
            const ChangePasswordFirebaseFailure.invalidArgument(),
          );
        case 'too-many-requests':
          return ResultOr.failure(
            const ChangePasswordFirebaseFailure.tooManyRequests(),
          );
        default:
          return ResultOr.failure(
            const ChangePasswordFirebaseFailure.invalidArgument(),
          );
      }
    }
  }
}
