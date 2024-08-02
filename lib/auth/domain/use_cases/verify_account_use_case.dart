import 'package:flutter_base/auth/domain/interfaces/i_auth_repository.dart';
import 'package:injectable/injectable.dart';

class VerifyAccountUseCaseInput {
  final String token;

  const VerifyAccountUseCaseInput({
    required this.token,
  });
}

@Injectable()
class VerifyAccountUseCase {
  final IAuthRepository _authRepository;

  VerifyAccountUseCase(this._authRepository);

  Future<void> call(VerifyAccountUseCaseInput input) {
    return _authRepository.verifyAccount(input.token);
  }
}
