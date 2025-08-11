abstract class PhoneFailure {
  const PhoneFailure();
  factory PhoneFailure.empty() = PhoneFailureEmpty;
  factory PhoneFailure.invalid() = PhoneFailureInvalid;
  factory PhoneFailure.tooLong(int length) = PhoneFailureTooLong;

  void when({
    required void Function(PhoneFailureEmpty) empty,
    required void Function(PhoneFailureInvalid) invalid,
    required void Function(PhoneFailureTooLong) tooLong,
  }) {
    if (this is PhoneFailureEmpty) {
      empty.call(this as PhoneFailureEmpty);
      return;
    }

    if (this is PhoneFailureInvalid) {
      invalid.call(this as PhoneFailureInvalid);
      return;
    }

    if (this is PhoneFailureTooLong) {
      tooLong.call(this as PhoneFailureTooLong);
      return;
    }

    empty.call(this as PhoneFailureEmpty);
  }

  R map<R>({
    required R Function(PhoneFailureEmpty) empty,
    required R Function(PhoneFailureInvalid) invalid,
    required R Function(PhoneFailureTooLong) tooLong,
  }) {
    if (this is PhoneFailureEmpty) {
      return empty.call(this as PhoneFailureEmpty);
    }

    if (this is PhoneFailureInvalid) {
      return invalid.call(this as PhoneFailureInvalid);
    }

    if (this is PhoneFailureTooLong) {
      return tooLong.call(this as PhoneFailureTooLong);
    }

    return empty.call(this as PhoneFailureEmpty);
  }

  void maybeWhen({
    void Function(PhoneFailureEmpty)? empty,
    void Function(PhoneFailureInvalid)? invalid,
    void Function(PhoneFailureTooLong)? tooLong,
    required void Function() orElse,
  }) {
    if (this is PhoneFailureEmpty && empty != null) {
      empty.call(this as PhoneFailureEmpty);
      return;
    }

    if (this is PhoneFailureInvalid && invalid != null) {
      invalid.call(this as PhoneFailureInvalid);
      return;
    }

    if (this is PhoneFailureTooLong && tooLong != null) {
      tooLong.call(this as PhoneFailureTooLong);
      return;
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(PhoneFailureEmpty)? empty,
    R Function(PhoneFailureInvalid)? invalid,
    R Function(PhoneFailureTooLong)? tooLong,
    required R Function() orElse,
  }) {
    if (this is PhoneFailureEmpty && empty != null) {
      return empty.call(this as PhoneFailureEmpty);
    }

    if (this is PhoneFailureInvalid && invalid != null) {
      return invalid.call(this as PhoneFailureInvalid);
    }

    if (this is PhoneFailureTooLong && tooLong != null) {
      return tooLong.call(this as PhoneFailureTooLong);
    }

    return orElse.call();
  }

  factory PhoneFailure.fromString(String value) {
    if (value == 'empty') {
      return PhoneFailure.empty();
    }

    if (value == 'invalid') {
      return PhoneFailure.invalid();
    }

    if (value == 'tooLong') {
      return PhoneFailure.tooLong(0);
    }

    return PhoneFailure.empty();
  }

  @override
  String toString() {
    if (this is PhoneFailureEmpty) {
      return 'empty';
    }

    if (this is PhoneFailureInvalid) {
      return 'invalid';
    }

    if (this is PhoneFailureTooLong) {
      return 'tooLong';
    }

    return 'empty';
  }
}

class PhoneFailureEmpty extends PhoneFailure {}

class PhoneFailureInvalid extends PhoneFailure {}

class PhoneFailureTooLong extends PhoneFailure {
  final int length;

  PhoneFailureTooLong(this.length);
}
