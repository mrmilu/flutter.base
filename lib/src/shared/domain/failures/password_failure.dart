abstract class PasswordFailure {
  const PasswordFailure();
  factory PasswordFailure.minLength(int min) = PasswordFailureInvalidMinLength;
  factory PasswordFailure.includeUppercase() = PasswordFailureIncludeUppercase;
  factory PasswordFailure.includeLowercase() = PasswordFailureIncludeLowercase;
  factory PasswordFailure.includeDigit() = PasswordFailureIncludeDigit;

  void when({
    required void Function(PasswordFailureInvalidMinLength) minLength,
    required void Function(PasswordFailureIncludeUppercase) includeUppercase,
    required void Function(PasswordFailureIncludeLowercase) includeLowercase,
    required void Function(PasswordFailureIncludeDigit) includeDigit,
  }) {
    if (this is PasswordFailureInvalidMinLength) {
      minLength.call(this as PasswordFailureInvalidMinLength);
    }

    if (this is PasswordFailureIncludeUppercase) {
      includeUppercase.call(this as PasswordFailureIncludeUppercase);
    }

    if (this is PasswordFailureIncludeLowercase) {
      includeLowercase.call(this as PasswordFailureIncludeLowercase);
    }

    if (this is PasswordFailureIncludeDigit) {
      includeDigit.call(this as PasswordFailureIncludeDigit);
    }

    minLength.call(this as PasswordFailureInvalidMinLength);
  }

  R map<R>({
    required R Function(PasswordFailureInvalidMinLength) minLength,
    required R Function(PasswordFailureIncludeUppercase) includeUppercase,
    required R Function(PasswordFailureIncludeLowercase) includeLowercase,
    required R Function(PasswordFailureIncludeDigit) includeDigit,
  }) {
    if (this is PasswordFailureInvalidMinLength) {
      return minLength.call(this as PasswordFailureInvalidMinLength);
    }

    if (this is PasswordFailureIncludeUppercase) {
      return includeUppercase.call(this as PasswordFailureIncludeUppercase);
    }

    if (this is PasswordFailureIncludeLowercase) {
      return includeLowercase.call(this as PasswordFailureIncludeLowercase);
    }

    if (this is PasswordFailureIncludeDigit) {
      return includeDigit.call(this as PasswordFailureIncludeDigit);
    }

    return minLength.call(this as PasswordFailureInvalidMinLength);
  }

  void maybeWhen({
    void Function(PasswordFailureInvalidMinLength)? minLength,
    void Function(PasswordFailureIncludeUppercase)? includeUppercase,
    void Function(PasswordFailureIncludeLowercase)? includeLowercase,
    void Function(PasswordFailureIncludeDigit)? includeDigit,
    required void Function() orElse,
  }) {
    if (this is PasswordFailureInvalidMinLength && minLength != null) {
      minLength.call(this as PasswordFailureInvalidMinLength);
    }

    if (this is PasswordFailureIncludeUppercase && includeUppercase != null) {
      includeUppercase.call(this as PasswordFailureIncludeUppercase);
    }

    if (this is PasswordFailureIncludeLowercase && includeLowercase != null) {
      includeLowercase.call(this as PasswordFailureIncludeLowercase);
    }

    if (this is PasswordFailureIncludeDigit && includeDigit != null) {
      includeDigit.call(this as PasswordFailureIncludeDigit);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(PasswordFailureInvalidMinLength)? minLength,
    R Function(PasswordFailureIncludeUppercase)? includeUppercase,
    R Function(PasswordFailureIncludeLowercase)? includeLowercase,
    R Function(PasswordFailureIncludeDigit)? includeDigit,
    required R Function() orElse,
  }) {
    if (this is PasswordFailureInvalidMinLength && minLength != null) {
      return minLength.call(this as PasswordFailureInvalidMinLength);
    }

    if (this is PasswordFailureIncludeUppercase && includeUppercase != null) {
      return includeUppercase.call(this as PasswordFailureIncludeUppercase);
    }

    if (this is PasswordFailureIncludeLowercase && includeLowercase != null) {
      return includeLowercase.call(this as PasswordFailureIncludeLowercase);
    }

    if (this is PasswordFailureIncludeDigit && includeDigit != null) {
      return includeDigit.call(this as PasswordFailureIncludeDigit);
    }

    return orElse.call();
  }

  factory PasswordFailure.fromString(String value) {
    if (value == 'includeUppercase') {
      return PasswordFailure.includeUppercase();
    }

    if (value == 'includeLowercase') {
      return PasswordFailure.includeLowercase();
    }

    if (value == 'includeDigit') {
      return PasswordFailure.includeDigit();
    }

    return PasswordFailure.minLength(8);
  }

  @override
  String toString() {
    if (this is PasswordFailureInvalidMinLength) {
      return 'minLength';
    }

    if (this is PasswordFailureIncludeUppercase) {
      return 'includeUppercase';
    }

    if (this is PasswordFailureIncludeLowercase) {
      return 'includeLowercase';
    }

    if (this is PasswordFailureIncludeDigit) {
      return 'includeDigit';
    }

    return 'minLength';
  }
}

class PasswordFailureInvalidMinLength extends PasswordFailure {
  final int min;

  PasswordFailureInvalidMinLength(this.min);
}

class PasswordFailureIncludeUppercase extends PasswordFailure {}

class PasswordFailureIncludeLowercase extends PasswordFailure {}

class PasswordFailureIncludeDigit extends PasswordFailure {}
