import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';

class ResetPasswordUseCaseInput {
  final String email;

  const ResetPasswordUseCaseInput({
    required this.email,
  });

}

@Injectable()
class ResetPasswordUseCase {
  final IAuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  call(ResetPasswordUseCaseInput input) {
    return _authRepository.requestResetPassword(input.email);
  }
}