abstract class SignUpFailure {
  const SignUpFailure();
  factory SignUpFailure.emailAlreadyInUser() = SignUpFailureEmailAlreadyInUser;
  factory SignUpFailure.invalidEmail() = SignUpFailureInvalidEmail;
  factory SignUpFailure.operationNotAllowed() =
      SignUpFailureOperationNotAllowed;
  factory SignUpFailure.weakPassword() = SignUpFailureWeakPassword;

  void when({
    required void Function(SignUpFailureEmailAlreadyInUser) emailAlreadyInUser,
    required void Function(SignUpFailureInvalidEmail) invalidEmail,
    required void Function(SignUpFailureOperationNotAllowed)
    operationNotAllowed,
    required void Function(SignUpFailureWeakPassword) weakPassword,
  }) {
    if (this is SignUpFailureEmailAlreadyInUser) {
      emailAlreadyInUser.call(this as SignUpFailureEmailAlreadyInUser);
    }

    if (this is SignUpFailureInvalidEmail) {
      invalidEmail.call(this as SignUpFailureInvalidEmail);
    }

    if (this is SignUpFailureOperationNotAllowed) {
      operationNotAllowed.call(this as SignUpFailureOperationNotAllowed);
    }

    if (this is SignUpFailureWeakPassword) {
      weakPassword.call(this as SignUpFailureWeakPassword);
    }

    emailAlreadyInUser.call(this as SignUpFailureEmailAlreadyInUser);
  }

  R map<R>({
    required R Function(SignUpFailureEmailAlreadyInUser) emailAlreadyInUser,
    required R Function(SignUpFailureInvalidEmail) invalidEmail,
    required R Function(SignUpFailureOperationNotAllowed) operationNotAllowed,
    required R Function(SignUpFailureWeakPassword) weakPassword,
  }) {
    if (this is SignUpFailureEmailAlreadyInUser) {
      return emailAlreadyInUser.call(this as SignUpFailureEmailAlreadyInUser);
    }

    if (this is SignUpFailureInvalidEmail) {
      return invalidEmail.call(this as SignUpFailureInvalidEmail);
    }

    if (this is SignUpFailureOperationNotAllowed) {
      return operationNotAllowed.call(this as SignUpFailureOperationNotAllowed);
    }

    if (this is SignUpFailureWeakPassword) {
      return weakPassword.call(this as SignUpFailureWeakPassword);
    }

    return emailAlreadyInUser.call(this as SignUpFailureEmailAlreadyInUser);
  }

  void maybeWhen({
    void Function(SignUpFailureEmailAlreadyInUser)? emailAlreadyInUser,
    void Function(SignUpFailureInvalidEmail)? invalidEmail,
    void Function(SignUpFailureOperationNotAllowed)? operationNotAllowed,
    void Function(SignUpFailureWeakPassword)? weakPassword,
    required void Function() orElse,
  }) {
    if (this is SignUpFailureEmailAlreadyInUser && emailAlreadyInUser != null) {
      emailAlreadyInUser.call(this as SignUpFailureEmailAlreadyInUser);
    }

    if (this is SignUpFailureInvalidEmail && invalidEmail != null) {
      invalidEmail.call(this as SignUpFailureInvalidEmail);
    }

    if (this is SignUpFailureOperationNotAllowed &&
        operationNotAllowed != null) {
      operationNotAllowed.call(this as SignUpFailureOperationNotAllowed);
    }

    if (this is SignUpFailureWeakPassword && weakPassword != null) {
      weakPassword.call(this as SignUpFailureWeakPassword);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(SignUpFailureEmailAlreadyInUser)? emailAlreadyInUser,
    R Function(SignUpFailureInvalidEmail)? invalidEmail,
    R Function(SignUpFailureOperationNotAllowed)? operationNotAllowed,
    R Function(SignUpFailureWeakPassword)? weakPassword,
    required R Function() orElse,
  }) {
    if (this is SignUpFailureEmailAlreadyInUser && emailAlreadyInUser != null) {
      return emailAlreadyInUser.call(this as SignUpFailureEmailAlreadyInUser);
    }

    if (this is SignUpFailureInvalidEmail && invalidEmail != null) {
      return invalidEmail.call(this as SignUpFailureInvalidEmail);
    }

    if (this is SignUpFailureOperationNotAllowed &&
        operationNotAllowed != null) {
      return operationNotAllowed.call(this as SignUpFailureOperationNotAllowed);
    }

    if (this is SignUpFailureWeakPassword && weakPassword != null) {
      return weakPassword.call(this as SignUpFailureWeakPassword);
    }

    return orElse.call();
  }

  factory SignUpFailure.fromString(String value) {
    if (value == 'email-already-in-user') {
      return SignUpFailure.emailAlreadyInUser();
    }

    if (value == 'invalid-email') {
      return SignUpFailure.invalidEmail();
    }

    if (value == 'operation-not-allowed') {
      return SignUpFailure.operationNotAllowed();
    }

    if (value == 'weak-password') {
      return SignUpFailure.weakPassword();
    }

    return SignUpFailure.emailAlreadyInUser();
  }

  @override
  String toString() {
    if (this is SignUpFailureEmailAlreadyInUser) {
      return 'email-already-in-user';
    }

    if (this is SignUpFailureInvalidEmail) {
      return 'invalid-email';
    }

    if (this is SignUpFailureOperationNotAllowed) {
      return 'operation-not-allowed';
    }

    if (this is SignUpFailureWeakPassword) {
      return 'weak-password';
    }

    return 'email-already-in-user';
  }
}

class SignUpFailureEmailAlreadyInUser extends SignUpFailure {}

class SignUpFailureInvalidEmail extends SignUpFailure {}

class SignUpFailureOperationNotAllowed extends SignUpFailure {}

class SignUpFailureWeakPassword extends SignUpFailure {}
