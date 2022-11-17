import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:flutter_base/core/auth/domain/use_cases/social_auth_use_case.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/core/user/domain/use_cases/user_and_cats_use_case.dart';
import 'package:injectable/injectable.dart';

class LoginUseCaseInput {
  final String? email;
  final String? password;
  final AuthProvider provider;

  const LoginUseCaseInput({
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
          'If email provider is chosen email and password are required.',
        );
}

@Injectable()
class LoginUseCase {
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;
  final GetUserUseCase _userAndCatsUseCase;
  final SocialAuthUseCase _socialAuthUseCase;

  LoginUseCase(
    this._userAndCatsUseCase,
    this._authRepository,
    this._tokenRepository,
    this._socialAuthUseCase,
  );

  Future<User> call(LoginUseCaseInput input) async {
    late LoginInputModel loginInput;

    if (input.provider == AuthProvider.google ||
        input.provider == AuthProvider.apple) {
      final socialAuthUser = await _socialAuthUseCase(
        SocialAuthUseCaseInput(authProvider: input.provider),
      );
      loginInput = LoginInputModel(
        email: socialAuthUser.email,
        password: socialAuthUser.password,
      );
    } else if (input.provider == AuthProvider.email) {
      loginInput = LoginInputModel(
        email: input.email!,
        password: input.password!,
      );
    }

    final token = await _authRepository.login(loginInput);
    if (kDebugMode) print(token);
    await _tokenRepository.update(TokenModel(token: token));
    return _userAndCatsUseCase();
  }
}
