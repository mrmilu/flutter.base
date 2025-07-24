abstract class FullnameFailure {
  const FullnameFailure();
  factory FullnameFailure.empty() = FullnameFailureEmpty;
  factory FullnameFailure.invalid() = FullnameFailureInvalid;
  factory FullnameFailure.tooLong(int length) = FullnameFailureTooLong;

  void when({
    required void Function(FullnameFailureEmpty) empty,
    required void Function(FullnameFailureInvalid) invalid,
    required void Function(FullnameFailureTooLong) tooLong,
  }) {
    if (this is FullnameFailureEmpty) {
      empty.call(this as FullnameFailureEmpty);
    }

    if (this is FullnameFailureInvalid) {
      invalid.call(this as FullnameFailureInvalid);
    }

    if (this is FullnameFailureTooLong) {
      tooLong.call(this as FullnameFailureTooLong);
    }

    empty.call(this as FullnameFailureEmpty);
  }

  R map<R>({
    required R Function(FullnameFailureEmpty) empty,
    required R Function(FullnameFailureInvalid) invalid,
    required R Function(FullnameFailureTooLong) tooLong,
  }) {
    if (this is FullnameFailureEmpty) {
      return empty.call(this as FullnameFailureEmpty);
    }

    if (this is FullnameFailureInvalid) {
      return invalid.call(this as FullnameFailureInvalid);
    }

    if (this is FullnameFailureTooLong) {
      return tooLong.call(this as FullnameFailureTooLong);
    }

    return empty.call(this as FullnameFailureEmpty);
  }

  void maybeWhen({
    void Function(FullnameFailureEmpty)? empty,
    void Function(FullnameFailureInvalid)? invalid,
    void Function(FullnameFailureTooLong)? tooLong,
    required void Function() orElse,
  }) {
    if (this is FullnameFailureEmpty && empty != null) {
      empty.call(this as FullnameFailureEmpty);
    }

    if (this is FullnameFailureInvalid && invalid != null) {
      invalid.call(this as FullnameFailureInvalid);
    }

    if (this is FullnameFailureTooLong && tooLong != null) {
      tooLong.call(this as FullnameFailureTooLong);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(FullnameFailureEmpty)? empty,
    R Function(FullnameFailureInvalid)? invalid,
    R Function(FullnameFailureTooLong)? tooLong,
    required R Function() orElse,
  }) {
    if (this is FullnameFailureEmpty && empty != null) {
      return empty.call(this as FullnameFailureEmpty);
    }

    if (this is FullnameFailureInvalid && invalid != null) {
      return invalid.call(this as FullnameFailureInvalid);
    }

    if (this is FullnameFailureTooLong && tooLong != null) {
      return tooLong.call(this as FullnameFailureTooLong);
    }

    return orElse.call();
  }

  factory FullnameFailure.fromString(String value) {
    if (value == 'empty') {
      return FullnameFailure.empty();
    }

    if (value == 'invalid') {
      return FullnameFailure.invalid();
    }

    return FullnameFailure.empty();
  }

  @override
  String toString() {
    if (this is FullnameFailureEmpty) {
      return 'empty';
    }

    if (this is FullnameFailureInvalid) {
      return 'invalid';
    }

    if (this is FullnameFailureTooLong) {
      return 'tooLong';
    }

    return 'empty';
  }
}

class FullnameFailureEmpty extends FullnameFailure {}

class FullnameFailureInvalid extends FullnameFailure {}

class FullnameFailureTooLong extends FullnameFailure {
  final int length;

  FullnameFailureTooLong(this.length);
}
