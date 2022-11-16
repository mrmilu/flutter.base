import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:injectable/injectable.dart';

class ResendResetPasswordEmailUseCaseInput {
  final String email;

  const ResendResetPasswordEmailUseCaseInput({
    required this.email,
  });
}

@Injectable()
class ResendResetPasswordEmailUseCase {
  final IAuthRepository _authRepository;

  ResendResetPasswordEmailUseCase(this._authRepository);

  Future<void> call(ResendResetPasswordEmailUseCaseInput input) {
    return _authRepository.resendPasswordResetEmail(input.email);
  }
}
