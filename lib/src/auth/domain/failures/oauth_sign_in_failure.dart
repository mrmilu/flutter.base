abstract class OAuthSignInFailure {
  const OAuthSignInFailure();
  factory OAuthSignInFailure.accountExistsWithDifferentCredential() =
      OAuthSignInFailureAccountExistsWithDifferentCredential;
  factory OAuthSignInFailure.invalidCredential() =
      OAuthSignInFailureInvalidCredential;
  factory OAuthSignInFailure.serverError() = OAuthSignInFailureServerError;
  factory OAuthSignInFailure.cancel() = OAuthSignInFailureCancel;

  void when({
    required void Function(
      OAuthSignInFailureAccountExistsWithDifferentCredential,
    )
    accountExistsWithDifferentCredential,
    required void Function(OAuthSignInFailureInvalidCredential)
    invalidCredential,
    required void Function(OAuthSignInFailureServerError) serverError,
    required void Function(OAuthSignInFailureCancel) cancel,
  }) {
    if (this is OAuthSignInFailureAccountExistsWithDifferentCredential) {
      accountExistsWithDifferentCredential.call(
        this as OAuthSignInFailureAccountExistsWithDifferentCredential,
      );
    }

    if (this is OAuthSignInFailureInvalidCredential) {
      invalidCredential.call(this as OAuthSignInFailureInvalidCredential);
    }

    if (this is OAuthSignInFailureServerError) {
      serverError.call(this as OAuthSignInFailureServerError);
    }

    if (this is OAuthSignInFailureCancel) {
      cancel.call(this as OAuthSignInFailureCancel);
    }

    accountExistsWithDifferentCredential.call(
      this as OAuthSignInFailureAccountExistsWithDifferentCredential,
    );
  }

  R map<R>({
    required R Function(OAuthSignInFailureAccountExistsWithDifferentCredential)
    accountExistsWithDifferentCredential,
    required R Function(OAuthSignInFailureInvalidCredential) invalidCredential,
    required R Function(OAuthSignInFailureServerError) serverError,
    required R Function(OAuthSignInFailureCancel) cancel,
  }) {
    if (this is OAuthSignInFailureAccountExistsWithDifferentCredential) {
      return accountExistsWithDifferentCredential.call(
        this as OAuthSignInFailureAccountExistsWithDifferentCredential,
      );
    }

    if (this is OAuthSignInFailureInvalidCredential) {
      return invalidCredential.call(
        this as OAuthSignInFailureInvalidCredential,
      );
    }

    if (this is OAuthSignInFailureServerError) {
      return serverError.call(this as OAuthSignInFailureServerError);
    }

    if (this is OAuthSignInFailureCancel) {
      return cancel.call(this as OAuthSignInFailureCancel);
    }

    return accountExistsWithDifferentCredential.call(
      this as OAuthSignInFailureAccountExistsWithDifferentCredential,
    );
  }

  void maybeWhen({
    void Function(OAuthSignInFailureAccountExistsWithDifferentCredential)?
    accountExistsWithDifferentCredential,
    void Function(OAuthSignInFailureInvalidCredential)? invalidCredential,
    void Function(OAuthSignInFailureServerError)? serverError,
    void Function(OAuthSignInFailureCancel)? cancel,
    required void Function() orElse,
  }) {
    if (this is OAuthSignInFailureAccountExistsWithDifferentCredential &&
        accountExistsWithDifferentCredential != null) {
      accountExistsWithDifferentCredential.call(
        this as OAuthSignInFailureAccountExistsWithDifferentCredential,
      );
    }

    if (this is OAuthSignInFailureInvalidCredential &&
        invalidCredential != null) {
      invalidCredential.call(this as OAuthSignInFailureInvalidCredential);
    }

    if (this is OAuthSignInFailureServerError && serverError != null) {
      serverError.call(this as OAuthSignInFailureServerError);
    }

    if (this is OAuthSignInFailureCancel && cancel != null) {
      cancel.call(this as OAuthSignInFailureCancel);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(OAuthSignInFailureAccountExistsWithDifferentCredential)?
    accountExistsWithDifferentCredential,
    R Function(OAuthSignInFailureInvalidCredential)? invalidCredential,
    R Function(OAuthSignInFailureServerError)? serverError,
    R Function(OAuthSignInFailureCancel)? cancel,
    required R Function() orElse,
  }) {
    if (this is OAuthSignInFailureAccountExistsWithDifferentCredential &&
        accountExistsWithDifferentCredential != null) {
      return accountExistsWithDifferentCredential.call(
        this as OAuthSignInFailureAccountExistsWithDifferentCredential,
      );
    }

    if (this is OAuthSignInFailureInvalidCredential &&
        invalidCredential != null) {
      return invalidCredential.call(
        this as OAuthSignInFailureInvalidCredential,
      );
    }

    if (this is OAuthSignInFailureServerError && serverError != null) {
      return serverError.call(this as OAuthSignInFailureServerError);
    }

    if (this is OAuthSignInFailureCancel && cancel != null) {
      return cancel.call(this as OAuthSignInFailureCancel);
    }

    return orElse.call();
  }

  factory OAuthSignInFailure.fromString(String value) {
    if (value == 'accountExistsWithDifferentCredential') {
      return OAuthSignInFailure.accountExistsWithDifferentCredential();
    }

    if (value == 'invalidCredential') {
      return OAuthSignInFailure.invalidCredential();
    }

    if (value == 'serverError') {
      return OAuthSignInFailure.serverError();
    }

    if (value == 'cancel') {
      return OAuthSignInFailure.cancel();
    }

    return OAuthSignInFailure.accountExistsWithDifferentCredential();
  }

  @override
  String toString() {
    if (this is OAuthSignInFailureAccountExistsWithDifferentCredential) {
      return 'accountExistsWithDifferentCredential';
    }

    if (this is OAuthSignInFailureInvalidCredential) {
      return 'invalidCredential';
    }

    if (this is OAuthSignInFailureServerError) {
      return 'serverError';
    }

    if (this is OAuthSignInFailureCancel) {
      return 'cancel';
    }

    return 'accountExistsWithDifferentCredential';
  }
}

class OAuthSignInFailureAccountExistsWithDifferentCredential
    extends OAuthSignInFailure {}

class OAuthSignInFailureInvalidCredential extends OAuthSignInFailure {}

class OAuthSignInFailureServerError extends OAuthSignInFailure {}

class OAuthSignInFailureCancel extends OAuthSignInFailure {}
