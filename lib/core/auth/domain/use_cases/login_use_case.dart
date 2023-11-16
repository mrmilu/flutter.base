import 'package:flutter/foundation.dart';
import 'package:flutter_base/common/services/error_tracking_service.dart';
import 'package:flutter_base/core/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:flutter_base/core/auth/domain/use_cases/social_auth_use_case.dart';
import 'package:flutter_base/core/user/domain/enums/user_device_type.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/core/user/domain/use_cases/get_user_use_case.dart';
import 'package:flutter_base/core/user/domain/use_cases/set_user_device_use_case.dart';
import 'package:injectable/injectable.dart';

class LoginUseCaseInput {
  final String email;
  final String password;
  final SocialAuthServiceProvider? provider;
  final UserDeviceType userDeviceType;

  const LoginUseCaseInput({
    this.email = '',
    this.password = '',
    this.provider,
    required this.userDeviceType,
  }) : assert(
          (email.length > 0 && password.length > 0) ||
              ((provider == SocialAuthServiceProvider.google ||
                      provider == SocialAuthServiceProvider.apple) &&
                  email.length <= 0 &&
                  password.length <= 0),
          'If email provider is chosen email and password are required.',
        );
}

@Injectable()
class LoginUseCase {
  final IAuthRepository _authRepository;
  final ITokenRepository _tokenRepository;
  final GetUserUseCase _getUserUseCase;
  final SocialAuthUseCase _socialAuthUseCase;
  final SetUserDeviceUseCase _setUserDeviceUseCase;
  final IErrorTrackingService _errorTrackingService;

  LoginUseCase(
    this._getUserUseCase,
    this._authRepository,
    this._tokenRepository,
    this._socialAuthUseCase,
    this._setUserDeviceUseCase,
    this._errorTrackingService,
  );

  Future<User> call(LoginUseCaseInput input) async {
    late String token;

    if (input.provider == SocialAuthServiceProvider.google ||
        input.provider == SocialAuthServiceProvider.apple) {
      final socialAuthToken = await _socialAuthUseCase(
        // ignore: avoid-non-null-assertion
        SocialAuthUseCaseInput(authProvider: input.provider!),
      );
      token = await _authRepository.socialAuth(socialAuthToken);
    } else {
      final loginInput = LoginInputModel(
        email: input.email,
        password: input.password,
      );
      token = await _authRepository.login(loginInput);
    }

    debugPrint(token);
    await _tokenRepository.update(TokenModel(token: token));
    await _setUserDeviceUseCase(
      SetUserDeviceUseCaseInput(type: input.userDeviceType),
    );
    final user = await _getUserUseCase();
    _errorTrackingService.setUser(
      ErrorTrackingUser(
        id: user.id.toString(),
        email: user.email,
        name: user.name,
      ),
    );
    return user;
  }
}
