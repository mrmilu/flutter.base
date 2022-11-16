import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/models/social_auth_user.dart';
import 'package:injectable/injectable.dart';

class SocialAuthUseCaseInput {
  final AuthProvider authProvider;

  const SocialAuthUseCaseInput({
    required this.authProvider,
  }) : assert(
          authProvider != AuthProvider.email,
          "For social auth login provider can't be email",
        );
}

@Injectable()
class SocialAuthUseCase {
  final IAuthRepository _authRepository;

  SocialAuthUseCase(this._authRepository);

  Future<SocialAuthUser> call(SocialAuthUseCaseInput input) async {
    SocialAuthUser? socialAuthUser;

    if (input.authProvider == AuthProvider.apple) {
      socialAuthUser = await _authRepository.appleSocialAuth();
    } else if (input.authProvider == AuthProvider.google) {
      socialAuthUser = await _authRepository.googleSocialAuth();
    }

    if (socialAuthUser == null) {
      throw const AppError(
        message: "No social auth user generated",
        code: AppErrorCode.socialLoginError,
      );
    }
    return socialAuthUser;
  }
}
