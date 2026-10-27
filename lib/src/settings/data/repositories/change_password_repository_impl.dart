import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../../../shared/domain/failures/endpoints/change_password_firebase_failure.dart';
import '../../domain/interfaces/i_change_password_repository.dart';

class ChangePasswordRepositoryImpl implements IChangePasswordRepository {
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
      return const ResultOr.success();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return const ResultOr.failure(
            ChangePasswordFirebaseFailure.wrongPassword(),
          );
        case 'invalid-credential':
          return const ResultOr.failure(
            ChangePasswordFirebaseFailure.invalidCredential(),
          );
        case 'invalid-argument':
          return const ResultOr.failure(
            ChangePasswordFirebaseFailure.invalidArgument(),
          );
        case 'too-many-requests':
          return const ResultOr.failure(
            ChangePasswordFirebaseFailure.tooManyRequests(),
          );
        default:
          return const ResultOr.failure(
            ChangePasswordFirebaseFailure.invalidArgument(),
          );
      }
    }
  }
}
