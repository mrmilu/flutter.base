import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase {
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;

  LogoutUseCase(this._authRepository, this._tokenRepository);

  Future<void> call() async {
    await _authRepository.logout();
    await _tokenRepository.clear();
  }
}
