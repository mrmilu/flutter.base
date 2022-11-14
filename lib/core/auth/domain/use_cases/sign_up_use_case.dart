import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:flutter_base/core/auth/domain/use_cases/social_auth_use_case.dart';
import 'package:flutter_base/core/user/domain/use_cases/user_and_cats_use_case.dart';

class SignUpUseCaseInput {
  final String? name;
  final String? email;
  final String? password;
  final AuthProvider provider;

  const SignUpUseCaseInput({
    this.name,
    this.email,
    this.password,
    required this.provider,
  }) : assert(
            (provider == AuthProvider.email &&
                    email != null &&
                    password != null) ||
                ((provider == AuthProvider.google ||
                        provider == AuthProvider.apple) &&
                    email == null &&
                    password == null),
            "If email provider is chosen email and password are required.");
}

@Injectable()
class SignUpUseCase {
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;
  final GetUserUseCase _userAndCatsUseCase;
  final SocialAuthUseCase _socialAuthUseCase;

  SignUpUseCase(
    this._authRepository,
    this._tokenRepository,
    this._userAndCatsUseCase,
    this._socialAuthUseCase,
  );

  Future<User> call(SignUpUseCaseInput input) async {
    late SignUpInputModel signUpInput;

    if (input.provider == AuthProvider.google ||
        input.provider == AuthProvider.apple) {
      final socialAuthUser = await _socialAuthUseCase(
          SocialAuthUseCaseInput(authProvider: input.provider));
      signUpInput = SignUpInputModel(
        email: socialAuthUser.email,
        password: socialAuthUser.password,
        name: socialAuthUser.name,
        provider: input.provider,
      );
    } else if (input.provider == AuthProvider.email) {
      signUpInput = SignUpInputModel(
        email: input.email!,
        password: input.password!,
        name: input.name,
        provider: input.provider,
      );
    }

    final token = await _authRepository.signUp(signUpInput);
    await _tokenRepository.update(TokenModel(token: token));
    return _userAndCatsUseCase();
  }
}
