import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mrmilu/src/interfaces/social_auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthService implements ISocialAuthService {
  String _generateNonce([int length = 32]) {
    const charset =
        "0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._";
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<User> signInWithApple() async {
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

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    final loggedUser =
        (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
            .user;
    if (loggedUser == null) throw Exception("NULL_LOGGED_USER");

    if (loggedUser.displayName == null) {
      await loggedUser.updateDisplayName(fixDisplayNameFromApple);
      await loggedUser.reload();
    }

    return loggedUser;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final loggedUser =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    if (loggedUser == null) throw Exception("NULL_LOGGED_USER");
    return loggedUser;
  }

  @override
  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
