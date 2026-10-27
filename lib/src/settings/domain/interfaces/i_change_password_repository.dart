import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../../../shared/domain/failures/endpoints/change_password_firebase_failure.dart';

abstract class IChangePasswordRepository {
  Future<ResultOr<ChangePasswordFirebaseFailure>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
