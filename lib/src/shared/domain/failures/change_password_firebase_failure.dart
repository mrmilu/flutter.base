abstract class ChangePasswordFirebaseFailure {
  const ChangePasswordFirebaseFailure();
  factory ChangePasswordFirebaseFailure.wrongPassword() =
      ChangePasswordFirebaseFailureWrongPassword;
  factory ChangePasswordFirebaseFailure.invalidCredential() =
      ChangePasswordFirebaseFailureInvalidCredential;
  factory ChangePasswordFirebaseFailure.invalidArgument() =
      ChangePasswordFirebaseFailureInvalidArgument;
  factory ChangePasswordFirebaseFailure.tooManyRequests() =
      ChangePasswordFirebaseFailureTooManyRequests;

  void when({
    required void Function(ChangePasswordFirebaseFailureWrongPassword)
    wrongPassword,
    required void Function(ChangePasswordFirebaseFailureInvalidCredential)
    invalidCredential,
    required void Function(ChangePasswordFirebaseFailureInvalidArgument)
    invalidArgument,
    required void Function(ChangePasswordFirebaseFailureTooManyRequests)
    tooManyRequests,
  }) {
    if (this is ChangePasswordFirebaseFailureWrongPassword) {
      wrongPassword.call(this as ChangePasswordFirebaseFailureWrongPassword);
      return;
    }

    if (this is ChangePasswordFirebaseFailureInvalidCredential) {
      invalidCredential.call(
        this as ChangePasswordFirebaseFailureInvalidCredential,
      );
      return;
    }

    if (this is ChangePasswordFirebaseFailureInvalidArgument) {
      invalidArgument.call(
        this as ChangePasswordFirebaseFailureInvalidArgument,
      );
      return;
    }

    if (this is ChangePasswordFirebaseFailureTooManyRequests) {
      tooManyRequests.call(
        this as ChangePasswordFirebaseFailureTooManyRequests,
      );
      return;
    }

    wrongPassword.call(this as ChangePasswordFirebaseFailureWrongPassword);
  }

  R map<R>({
    required R Function(ChangePasswordFirebaseFailureWrongPassword)
    wrongPassword,
    required R Function(ChangePasswordFirebaseFailureInvalidCredential)
    invalidCredential,
    required R Function(ChangePasswordFirebaseFailureInvalidArgument)
    invalidArgument,
    required R Function(ChangePasswordFirebaseFailureTooManyRequests)
    tooManyRequests,
  }) {
    if (this is ChangePasswordFirebaseFailureWrongPassword) {
      return wrongPassword.call(
        this as ChangePasswordFirebaseFailureWrongPassword,
      );
    }

    if (this is ChangePasswordFirebaseFailureInvalidCredential) {
      return invalidCredential.call(
        this as ChangePasswordFirebaseFailureInvalidCredential,
      );
    }

    if (this is ChangePasswordFirebaseFailureInvalidArgument) {
      return invalidArgument.call(
        this as ChangePasswordFirebaseFailureInvalidArgument,
      );
    }

    if (this is ChangePasswordFirebaseFailureTooManyRequests) {
      return tooManyRequests.call(
        this as ChangePasswordFirebaseFailureTooManyRequests,
      );
    }

    return wrongPassword.call(
      this as ChangePasswordFirebaseFailureWrongPassword,
    );
  }

  void maybeWhen({
    void Function(ChangePasswordFirebaseFailureWrongPassword)? wrongPassword,
    void Function(ChangePasswordFirebaseFailureInvalidCredential)?
    invalidCredential,
    void Function(ChangePasswordFirebaseFailureInvalidArgument)?
    invalidArgument,
    void Function(ChangePasswordFirebaseFailureTooManyRequests)?
    tooManyRequests,
    required void Function() orElse,
  }) {
    if (this is ChangePasswordFirebaseFailureWrongPassword &&
        wrongPassword != null) {
      wrongPassword.call(this as ChangePasswordFirebaseFailureWrongPassword);
      return;
    }

    if (this is ChangePasswordFirebaseFailureInvalidCredential &&
        invalidCredential != null) {
      invalidCredential.call(
        this as ChangePasswordFirebaseFailureInvalidCredential,
      );
      return;
    }

    if (this is ChangePasswordFirebaseFailureInvalidArgument &&
        invalidArgument != null) {
      invalidArgument.call(
        this as ChangePasswordFirebaseFailureInvalidArgument,
      );
      return;
    }

    if (this is ChangePasswordFirebaseFailureTooManyRequests &&
        tooManyRequests != null) {
      tooManyRequests.call(
        this as ChangePasswordFirebaseFailureTooManyRequests,
      );
      return;
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(ChangePasswordFirebaseFailureWrongPassword)? wrongPassword,
    R Function(ChangePasswordFirebaseFailureInvalidCredential)?
    invalidCredential,
    R Function(ChangePasswordFirebaseFailureInvalidArgument)? invalidArgument,
    R Function(ChangePasswordFirebaseFailureTooManyRequests)? tooManyRequests,
    required R Function() orElse,
  }) {
    if (this is ChangePasswordFirebaseFailureWrongPassword &&
        wrongPassword != null) {
      return wrongPassword.call(
        this as ChangePasswordFirebaseFailureWrongPassword,
      );
    }

    if (this is ChangePasswordFirebaseFailureInvalidCredential &&
        invalidCredential != null) {
      return invalidCredential.call(
        this as ChangePasswordFirebaseFailureInvalidCredential,
      );
    }

    if (this is ChangePasswordFirebaseFailureInvalidArgument &&
        invalidArgument != null) {
      return invalidArgument.call(
        this as ChangePasswordFirebaseFailureInvalidArgument,
      );
    }

    if (this is ChangePasswordFirebaseFailureTooManyRequests &&
        tooManyRequests != null) {
      return tooManyRequests.call(
        this as ChangePasswordFirebaseFailureTooManyRequests,
      );
    }

    return orElse.call();
  }

  factory ChangePasswordFirebaseFailure.fromString(String value) {
    if (value == 'wrongPassword') {
      return ChangePasswordFirebaseFailure.wrongPassword();
    }

    if (value == 'invalidCredential') {
      return ChangePasswordFirebaseFailure.invalidCredential();
    }

    if (value == 'invalidArgument') {
      return ChangePasswordFirebaseFailure.invalidArgument();
    }

    if (value == 'tooManyRequests') {
      return ChangePasswordFirebaseFailure.tooManyRequests();
    }

    return ChangePasswordFirebaseFailure.wrongPassword();
  }

  @override
  String toString() {
    if (this is ChangePasswordFirebaseFailureWrongPassword) {
      return 'wrongPassword';
    }

    if (this is ChangePasswordFirebaseFailureInvalidCredential) {
      return 'invalidCredential';
    }

    if (this is ChangePasswordFirebaseFailureInvalidArgument) {
      return 'invalidArgument';
    }

    if (this is ChangePasswordFirebaseFailureTooManyRequests) {
      return 'tooManyRequests';
    }

    return 'wrongPassword';
  }
}

class ChangePasswordFirebaseFailureWrongPassword
    extends ChangePasswordFirebaseFailure {}

class ChangePasswordFirebaseFailureInvalidCredential
    extends ChangePasswordFirebaseFailure {}

class ChangePasswordFirebaseFailureInvalidArgument
    extends ChangePasswordFirebaseFailure {}

class ChangePasswordFirebaseFailureTooManyRequests
    extends ChangePasswordFirebaseFailure {}
