import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ResendResetPasswordEmailUseCase {
  final IAuthRepository _authRepository;

  ResendResetPasswordEmailUseCase(this._authRepository);

  Future<void> call(String email) {
    return _authRepository.resendPasswordResetEmail(email);
  }
}
