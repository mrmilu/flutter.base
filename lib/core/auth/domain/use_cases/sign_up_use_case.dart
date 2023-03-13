import 'package:flutter_base/core/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:flutter_base/core/auth/domain/use_cases/social_auth_use_case.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/core/user/domain/use_cases/get_user_use_case.dart';
import 'package:injectable/injectable.dart';

class SignUpUseCaseInput {
  final String name;
  final String email;
  final String password;
  final SocialAuthServiceProvider? socialAuthProvider;

  const SignUpUseCaseInput({
    this.name = '',
    this.email = '',
    this.password = '',
    this.socialAuthProvider,
  }) : assert(
          (email.length > 0 && password.length > 0) ||
              ((socialAuthProvider == SocialAuthServiceProvider.google ||
                      socialAuthProvider == SocialAuthServiceProvider.apple) &&
                  email.length <= 0 &&
                  password.length <= 0),
          'If social auth provider is chosen email and password are not required.',
        );
}

@Injectable()
class SignUpUseCase {
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;
  final GetUserUseCase _getUserUseCase;
  final SocialAuthUseCase _socialAuthUseCase;

  SignUpUseCase(
    this._authRepository,
    this._tokenRepository,
    this._getUserUseCase,
    this._socialAuthUseCase,
  );

  Future<User> call(SignUpUseCaseInput input) async {
    late String token;

    if (input.socialAuthProvider == SocialAuthServiceProvider.google ||
        input.socialAuthProvider == SocialAuthServiceProvider.apple) {
      final socialAuthToken = await _socialAuthUseCase(
        // ignore: avoid-non-null-assertion
        SocialAuthUseCaseInput(authProvider: input.socialAuthProvider!),
      );
      token = await _authRepository.socialAuth(socialAuthToken);
    } else {
      final signUpInput = SignUpInputModel(
        email: input.email,
        password: input.password,
        name: input.name,
      );
      token = await _authRepository.signUp(signUpInput);
    }

    await _tokenRepository.update(TokenModel(token: token));
    return _getUserUseCase();
  }
}
