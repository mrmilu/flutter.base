import 'package:flutter_base/common/services/error_tracking_service.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase {
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;
  final IErrorTrackingService _errorTrackingService;

  LogoutUseCase(
    this._authRepository,
    this._tokenRepository,
    this._errorTrackingService,
  );

  Future<void> call() async {
    await _authRepository.logout();
    await _tokenRepository.clear();
    await _errorTrackingService.logout();
  }
}
