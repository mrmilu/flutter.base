abstract class SignInFailure {
  const SignInFailure();
  factory SignInFailure.nonExistentUserWithEmailAndPassword() =
      NonExistentUserAndPassword;
  factory SignInFailure.serverError() = ServerError;
  factory SignInFailure.fromString(String value) {
    if (value == 'nonExistentUserWithEmailAndPassword') {
      return SignInFailure.nonExistentUserWithEmailAndPassword();
    }

    if (value == 'serverError') {
      return SignInFailure.serverError();
    }

    return SignInFailure.nonExistentUserWithEmailAndPassword();
  }

  void when({
    required void Function(NonExistentUserAndPassword)
    nonExistentUserWithEmailAndPassword,
    required void Function(ServerError) serverError,
  }) {
    if (this is NonExistentUserAndPassword) {
      nonExistentUserWithEmailAndPassword.call(
        this as NonExistentUserAndPassword,
      );
    }

    if (this is ServerError) {
      serverError.call(this as ServerError);
    }

    nonExistentUserWithEmailAndPassword.call(
      this as NonExistentUserAndPassword,
    );
  }

  R map<R>({
    required R Function(NonExistentUserAndPassword)
    nonExistentUserWithEmailAndPassword,
    required R Function(ServerError) serverError,
  }) {
    if (this is NonExistentUserAndPassword) {
      return nonExistentUserWithEmailAndPassword.call(
        this as NonExistentUserAndPassword,
      );
    }

    if (this is ServerError) {
      return serverError.call(this as ServerError);
    }

    return nonExistentUserWithEmailAndPassword.call(
      this as NonExistentUserAndPassword,
    );
  }

  void maybeWhen({
    void Function(NonExistentUserAndPassword)?
    nonExistentUserWithEmailAndPassword,
    void Function(ServerError)? serverError,
    required void Function() orElse,
  }) {
    if (this is NonExistentUserAndPassword &&
        nonExistentUserWithEmailAndPassword != null) {
      nonExistentUserWithEmailAndPassword.call(
        this as NonExistentUserAndPassword,
      );
    }

    if (this is ServerError && serverError != null) {
      serverError.call(this as ServerError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(NonExistentUserAndPassword)? nonExistentUserWithEmailAndPassword,
    R Function(ServerError)? serverError,
    required R Function() orElse,
  }) {
    if (this is NonExistentUserAndPassword &&
        nonExistentUserWithEmailAndPassword != null) {
      return nonExistentUserWithEmailAndPassword.call(
        this as NonExistentUserAndPassword,
      );
    }

    if (this is ServerError && serverError != null) {
      return serverError.call(this as ServerError);
    }

    return orElse.call();
  }

  @override
  String toString() {
    if (this is NonExistentUserAndPassword) {
      return 'nonExistentUserWithEmailAndPassword';
    }

    if (this is ServerError) {
      return 'serverError';
    }

    return 'nonExistentUserWithEmailAndPassword';
  }
}

class NonExistentUserAndPassword extends SignInFailure {}

class ServerError extends SignInFailure {}
