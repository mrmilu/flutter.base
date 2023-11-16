abstract class IErrorTrackingService {
  Future<void> setUser(ErrorTrackingUser user);
  Future<void> logout();
  Future<void> setTag(String key, String value);
  Future<void> setTags(Map<String, String> tags);
}

class ErrorTrackingUser {
  final String? id;
  final String? email;
  final String? name;
  final String? username;

  const ErrorTrackingUser({
    this.id,
    this.email,
    this.name,
    this.username,
  });
}
