import 'package:flutter_base/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/auth/domain/interfaces/token_repository.dart';
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
