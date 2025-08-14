enum UserAuthProviderType {
  email,
  google,
  apple;

  const UserAuthProviderType();

  R map<R>({
    required R Function() email,
    required R Function() google,
    required R Function() apple,
  }) {
    switch (this) {
      case UserAuthProviderType.email:
        return email();
      case UserAuthProviderType.google:
        return google();
      case UserAuthProviderType.apple:
        return apple();
    }
  }

  @override
  String toString() {
    switch (this) {
      case UserAuthProviderType.email:
        return 'EMAIL';
      case UserAuthProviderType.google:
        return 'GOOGLE';
      case UserAuthProviderType.apple:
        return 'APPLE';
    }
  }

  static UserAuthProviderType fromString(String status) {
    switch (status) {
      case 'EMAIL':
        return UserAuthProviderType.email;
      case 'GOOGLE':
        return UserAuthProviderType.google;
      case 'APPLE':
        return UserAuthProviderType.apple;
      default:
        return UserAuthProviderType.email;
    }
  }
}
