abstract class EmailFailure {
  const EmailFailure();
  factory EmailFailure.empty() = EmailFailureEmpty;
  factory EmailFailure.invalid() = EmailFailureInvalid;

  void when({
    required void Function(EmailFailureEmpty) empty,
    required void Function(EmailFailureInvalid) invalid,
  }) {
    if (this is EmailFailureEmpty) {
      empty.call(this as EmailFailureEmpty);
    }

    if (this is EmailFailureInvalid) {
      invalid.call(this as EmailFailureInvalid);
    }

    empty.call(this as EmailFailureEmpty);
  }

  R map<R>({
    required R Function(EmailFailureEmpty) empty,
    required R Function(EmailFailureInvalid) invalid,
  }) {
    if (this is EmailFailureEmpty) {
      return empty.call(this as EmailFailureEmpty);
    }

    if (this is EmailFailureInvalid) {
      return invalid.call(this as EmailFailureInvalid);
    }

    return empty.call(this as EmailFailureEmpty);
  }

  void maybeWhen({
    void Function(EmailFailureEmpty)? empty,
    void Function(EmailFailureInvalid)? invalid,
    required void Function() orElse,
  }) {
    if (this is EmailFailureEmpty && empty != null) {
      empty.call(this as EmailFailureEmpty);
    }

    if (this is EmailFailureInvalid && invalid != null) {
      invalid.call(this as EmailFailureInvalid);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(EmailFailureEmpty)? empty,
    R Function(EmailFailureInvalid)? invalid,
    required R Function() orElse,
  }) {
    if (this is EmailFailureEmpty && empty != null) {
      return empty.call(this as EmailFailureEmpty);
    }

    if (this is EmailFailureInvalid && invalid != null) {
      return invalid.call(this as EmailFailureInvalid);
    }

    return orElse.call();
  }

  factory EmailFailure.fromString(String value) {
    if (value == 'empty') {
      return EmailFailure.empty();
    }

    if (value == 'invalid') {
      return EmailFailure.invalid();
    }

    return EmailFailure.empty();
  }

  @override
  String toString() {
    if (this is EmailFailureEmpty) {
      return 'empty';
    }

    if (this is EmailFailureInvalid) {
      return 'invalid';
    }

    return 'empty';
  }
}

class EmailFailureEmpty extends EmailFailure {}

class EmailFailureInvalid extends EmailFailure {}
