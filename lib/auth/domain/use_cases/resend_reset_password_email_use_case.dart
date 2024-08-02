import 'package:flutter_base/auth/domain/interfaces/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ResendResetPasswordEmailUseCase {
  final IAuthRepository _authRepository;

  ResendResetPasswordEmailUseCase(this._authRepository);

  Future<void> call(String email) {
    return _authRepository.resendPasswordResetEmail(email);
  }
}
