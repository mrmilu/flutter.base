import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';

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

  call(VerifyAccountUseCaseInput input) {
    return _authRepository.verifyAccount(input.token);
  }
}