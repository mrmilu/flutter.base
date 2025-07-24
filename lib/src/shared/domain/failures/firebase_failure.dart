abstract class FirebaseFailure {
  const FirebaseFailure();
  factory FirebaseFailure.serverError() = FirebaseFailureServerError;

  void when({
    required void Function(FirebaseFailureServerError) serverError,
  }) {
    if (this is FirebaseFailureServerError) {
      serverError.call(this as FirebaseFailureServerError);
    }

    serverError.call(this as FirebaseFailureServerError);
  }

  R map<R>({
    required R Function(FirebaseFailureServerError) serverError,
  }) {
    if (this is FirebaseFailureServerError) {
      return serverError.call(this as FirebaseFailureServerError);
    }

    return serverError.call(this as FirebaseFailureServerError);
  }

  void maybeWhen({
    void Function(FirebaseFailureServerError)? serverError,
    required void Function() orElse,
  }) {
    if (this is FirebaseFailureServerError && serverError != null) {
      serverError.call(this as FirebaseFailureServerError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(FirebaseFailureServerError)? serverError,
    required R Function() orElse,
  }) {
    if (this is FirebaseFailureServerError && serverError != null) {
      return serverError.call(this as FirebaseFailureServerError);
    }

    return orElse.call();
  }

  factory FirebaseFailure.fromString(String value) {
    if (value == 'serverError') {
      return FirebaseFailure.serverError();
    }

    return FirebaseFailure.serverError();
  }

  @override
  String toString() {
    if (this is FirebaseFailureServerError) {
      return 'serverError';
    }

    return 'serverError';
  }
}

class FirebaseFailureServerError extends FirebaseFailure {}
