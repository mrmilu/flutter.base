import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../shared/domain/models/env_vars.dart';

class CanceledByUserException implements Exception {
  @override
  String toString() => 'Canceled by user';
}

class FirebaseSocialAuthService {
  final FirebaseAuth firebaseAuth;
  FirebaseSocialAuthService(this.firebaseAuth);

  Future<String> getFirebaseTokenSignInWithGoogle() async {
    try {
      final env = EnvVars();
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        clientId: Platform.isIOS
            ? env.firebaseClientIdIOS
            : env.firebaseClientIdAndroid,
      );

      final googleSignInAccount = await googleSignIn.authenticate();

      final scopes = ['email', 'profile'];
      final auth = await googleSignIn.authorizationClient
          .authorizationForScopes(scopes);

      if (auth == null) {
        throw CanceledByUserException();
      }
      final googleSignInAuthentication = googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final firebaseCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final firebaseToken = await firebaseCredential.user?.getIdToken();

      if (firebaseToken == null) {
        throw Exception('Firebase token is null');
      }

      return firebaseToken;
    } catch (e, s) {
      if (e is CanceledByUserException) {
        throw CanceledByUserException();
      }
      if (e is GoogleSignInException &&
          e.code == GoogleSignInExceptionCode.canceled) {
        throw CanceledByUserException();
      }
      dev.log('Error: $e', stackTrace: s);
      rethrow;
    }
  }

  Future<String> getFirebaseTokenSignInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final fixDisplayNameFromApple =
          '${appleCredential.givenName ?? ""} ${appleCredential.familyName ?? ""}';

      final credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      final firebaseCredential =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      if (firebaseCredential == null) {
        throw CanceledByUserException();
      }

      if (firebaseCredential.displayName == null) {
        await firebaseCredential.updateDisplayName(fixDisplayNameFromApple);
        await firebaseCredential.reload();
      }

      final firebaseToken = await firebaseCredential.getIdToken();
      if (firebaseToken == null) {
        throw CanceledByUserException();
      }

      return firebaseToken;
    } on SignInWithAppleAuthorizationException catch (_) {
      rethrow;
    } catch (e, s) {
      if (e is CanceledByUserException) {
        throw CanceledByUserException();
      }
      dev.log('Error: $e', stackTrace: s);
      rethrow;
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
