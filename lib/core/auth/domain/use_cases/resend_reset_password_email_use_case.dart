import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';

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

  call(ResendResetPasswordEmailUseCaseInput input) {
    return _authRepository.resendPasswordResetEmail(input.email);
  }
}