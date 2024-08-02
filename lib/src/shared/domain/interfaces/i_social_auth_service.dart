import 'package:firebase_auth/firebase_auth.dart';

abstract class ISocialAuthService {
  Future<User> signInWithApple();

  Future<User?> signInWithGoogle();

  Future<void> logout();
}
