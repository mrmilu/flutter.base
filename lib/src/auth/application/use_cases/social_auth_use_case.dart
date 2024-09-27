import 'package:flutter_base/src/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:injectable/injectable.dart';

class SocialAuthUseCaseInput {
  final SocialAuthServiceProvider authProvider;

  const SocialAuthUseCaseInput({
    required this.authProvider,
  });
}

@Injectable()
class SocialAuthUseCase {
  final IAuthRepository _authRepository;

  SocialAuthUseCase(this._authRepository);

  Future<String> call(SocialAuthUseCaseInput input) async {
    late String? socialToken;

    if (input.authProvider == SocialAuthServiceProvider.apple) {
      socialToken = await _authRepository.appleSocialAuth();
    } else if (input.authProvider == SocialAuthServiceProvider.google) {
      socialToken = await _authRepository.googleSocialAuth();
    }
    if (socialToken == null) {
      throw const AppError(code: AppErrorCode.errorRetrievingDeviceToken);
    }
    return socialToken;
  }
}
