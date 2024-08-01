class SocialAuthUser {
  final String? name;
  final String email;
  final String password;

  const SocialAuthUser({
    this.name,
    required this.email,
    required this.password,
  });
}
