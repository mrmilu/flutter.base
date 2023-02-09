import 'package:flutter_base/core/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
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
    late String socialToken;

    if (input.authProvider == SocialAuthServiceProvider.apple) {
      socialToken = await _authRepository.appleSocialAuth();
    } else if (input.authProvider == SocialAuthServiceProvider.google) {
      socialToken = await _authRepository.googleSocialAuth();
    }
    return socialToken;
  }
}
