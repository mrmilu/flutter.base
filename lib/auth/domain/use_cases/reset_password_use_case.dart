import 'package:flutter_base/auth/domain/interfaces/auth_repository.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> call(ResetPasswordUseCaseInput input) {
    return _authRepository.requestResetPassword(input.email);
  }
}
