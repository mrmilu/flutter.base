abstract class ITokenRepository {
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens({
    required String token,
    String? refreshToken,
  });
  Future<void> clear();
  Future<String?> refreshToken();

  Future<void> saveEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> savePassword(String password);
  Future<Map<String, String>?> getEmailAndPassword();
  Future<void> clearEmailAndPassword();
}
