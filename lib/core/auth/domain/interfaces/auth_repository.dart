import 'package:flutter_base/core/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';

abstract class IAuthRepository {
  Future<String> signUp(SignUpInputModel input);

  Future<String> login(LoginInputModel input);

  Future logout();

  Future<String> socialAuth(String token);

  Future<String> googleSocialAuth();

  Future<String> appleSocialAuth();

  Future<void> requestResetPassword(String email);

  Future<void> resendPasswordResetEmail(String email);

  Future<void> changePassword(ChangePasswordInputModel input);

  Future<void> verifyAccount(String token);
}
