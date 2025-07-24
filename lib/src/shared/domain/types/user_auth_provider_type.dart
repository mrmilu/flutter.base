abstract class UserAuthProviderType {
  const UserAuthProviderType();
  factory UserAuthProviderType.email() = UserAuthProviderTypeEmail;
  factory UserAuthProviderType.google() = UserAuthProviderTypeGoogle;
  factory UserAuthProviderType.apple() = UserAuthProviderTypeApple;

  void when({
    required void Function(UserAuthProviderTypeEmail) email,
    required void Function(UserAuthProviderTypeGoogle) google,
    required void Function(UserAuthProviderTypeApple) apple,
  }) {
    if (this is UserAuthProviderTypeEmail) {
      email.call(this as UserAuthProviderTypeEmail);
    }

    if (this is UserAuthProviderTypeGoogle) {
      google.call(this as UserAuthProviderTypeGoogle);
    }

    if (this is UserAuthProviderTypeApple) {
      apple.call(this as UserAuthProviderTypeApple);
    }

    email.call(this as UserAuthProviderTypeEmail);
  }

  R map<R>({
    required R Function(UserAuthProviderTypeEmail) email,
    required R Function(UserAuthProviderTypeGoogle) google,
    required R Function(UserAuthProviderTypeApple) apple,
  }) {
    if (this is UserAuthProviderTypeEmail) {
      return email.call(this as UserAuthProviderTypeEmail);
    }

    if (this is UserAuthProviderTypeGoogle) {
      return google.call(this as UserAuthProviderTypeGoogle);
    }

    if (this is UserAuthProviderTypeApple) {
      return apple.call(this as UserAuthProviderTypeApple);
    }

    return email.call(this as UserAuthProviderTypeEmail);
  }

  void maybeWhen({
    void Function(UserAuthProviderTypeEmail)? email,
    void Function(UserAuthProviderTypeGoogle)? google,
    void Function(UserAuthProviderTypeApple)? apple,
    required void Function() orElse,
  }) {
    if (this is UserAuthProviderTypeEmail && email != null) {
      email.call(this as UserAuthProviderTypeEmail);
    }

    if (this is UserAuthProviderTypeGoogle && google != null) {
      google.call(this as UserAuthProviderTypeGoogle);
    }

    if (this is UserAuthProviderTypeApple && apple != null) {
      apple.call(this as UserAuthProviderTypeApple);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(UserAuthProviderTypeEmail)? email,
    R Function(UserAuthProviderTypeGoogle)? google,
    R Function(UserAuthProviderTypeApple)? apple,
    required R Function() orElse,
  }) {
    if (this is UserAuthProviderTypeEmail && email != null) {
      return email.call(this as UserAuthProviderTypeEmail);
    }

    if (this is UserAuthProviderTypeGoogle && google != null) {
      return google.call(this as UserAuthProviderTypeGoogle);
    }

    if (this is UserAuthProviderTypeApple && apple != null) {
      return apple.call(this as UserAuthProviderTypeApple);
    }

    return orElse.call();
  }

  factory UserAuthProviderType.fromString(String value) {
    if (value == 'EMAIL') {
      return UserAuthProviderType.email();
    }

    if (value == 'GOOGLE') {
      return UserAuthProviderType.google();
    }

    if (value == 'APPLE') {
      return UserAuthProviderType.apple();
    }

    return UserAuthProviderType.email();
  }

  @override
  String toString() {
    if (this is UserAuthProviderTypeEmail) {
      return 'EMAIL';
    }

    if (this is UserAuthProviderTypeGoogle) {
      return 'GOOGLE';
    }

    if (this is UserAuthProviderTypeApple) {
      return 'APPLE';
    }

    return 'EMAIL';
  }
}

class UserAuthProviderTypeEmail extends UserAuthProviderType {}

class UserAuthProviderTypeGoogle extends UserAuthProviderType {}

class UserAuthProviderTypeApple extends UserAuthProviderType {}
