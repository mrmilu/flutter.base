import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_base/core/app/data/services/api_service.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/app/domain/models/enviroments_list.dart';
import 'package:flutter_base/core/auth/data/models/change_password_output_model.dart';
import 'package:flutter_base/core/auth/data/models/login_data_model.dart';
import 'package:flutter_base/core/auth/data/models/login_output_model.dart';
import 'package:flutter_base/core/auth/data/models/sign_up_data_model.dart';
import 'package:flutter_base/core/auth/data/models/sign_up_output_model.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@Injectable(as: IAuthRepository, env: onlineEnviroment)
class AuthRepository implements IAuthRepository {
  final ApiService _apiService;
  final ISocialAuthService _socialAuthService;

  AuthRepository(this._apiService, this._socialAuthService);

  @override
  Future<String> login(LoginInputModel input) async {
    final res = await _apiService.post(
      '/users/login/',
      data: input.toOutput().toJson(),
    );
    return LoginDataModel.fromJson(res ?? {}).token;
  }

  @override
  Future logout() async {
    await _apiService.post('/users/logout/');
    await _socialAuthService.logout();
  }

  @override
  Future<String> signUp(SignUpInputModel input) async {
    final res = await _apiService.post(
      '/users/registration/',
      data: input.toOutput().toJson(),
    );
    return SignUpDataModel.fromJson(res ?? {}).token;
  }

  @override
  Future<String> appleSocialAuth() async {
    late firebase_auth.User user;
    try {
      user = await _socialAuthService.signInWithApple();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        rethrow;
      } else {
        throw const AppError(
          message: 'Sign-in with Apple Canceled',
          code: AppErrorCode.appleAuthCanceled,
        );
      }
    }
    return user.getIdToken();
  }

  @override
  Future<String> googleSocialAuth() async {
    late firebase_auth.User? user;
    user = await _socialAuthService.signInWithGoogle();
    if (user == null) {
      throw const AppError(
        message: 'Sign-in with Google Canceled',
        code: AppErrorCode.googleAuthCanceled,
      );
    }
    return user.getIdToken();
  }

  @override
  Future<void> requestResetPassword(String email) async {
    await _apiService.post(
      '/users/password/reset/',
      data: {'email': email},
    );
  }

  @override
  Future<void> changePassword(ChangePasswordInputModel input) async {
    await _apiService.post(
      '/users/password/reset/confirm/',
      data: input.toOutput().toJson(),
    );
  }

  @override
  Future<void> resendPasswordResetEmail(String email) async {
    await _apiService.post(
      '/users/registration/resend-email/',
      data: {'email': email},
    );
  }

  @override
  Future<void> verifyAccount(String token) async {
    await _apiService.post(
      '/users/account-confirm-email/',
      data: {'key': token},
    );
  }

  @override
  Future socialAuth(String token) async {
    final res = await _apiService.post(
      '/users/social-auth/',
      data: {
        'firebase_token': token,
      },
    );
    return SignUpDataModel.fromJson(res ?? {}).token;
  }
}
