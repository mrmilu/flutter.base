abstract class RepeatEmailFailure {
  const RepeatEmailFailure();
  factory RepeatEmailFailure.mismatchedPasswords() = MismatchedEmail;

  void when({
    required void Function(MismatchedEmail) mismatchedPasswords,
  }) {
    if (this is MismatchedEmail) {
      mismatchedPasswords.call(this as MismatchedEmail);
    }

    mismatchedPasswords.call(this as MismatchedEmail);
  }

  R map<R>({
    required R Function(MismatchedEmail) mismatchedPasswords,
  }) {
    if (this is MismatchedEmail) {
      return mismatchedPasswords.call(this as MismatchedEmail);
    }

    return mismatchedPasswords.call(this as MismatchedEmail);
  }

  void maybeWhen({
    void Function(MismatchedEmail)? mismatchedPasswords,
    required void Function() orElse,
  }) {
    if (this is MismatchedEmail && mismatchedPasswords != null) {
      mismatchedPasswords.call(this as MismatchedEmail);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(MismatchedEmail)? mismatchedPasswords,
    required R Function() orElse,
  }) {
    if (this is MismatchedEmail && mismatchedPasswords != null) {
      return mismatchedPasswords.call(this as MismatchedEmail);
    }

    return orElse.call();
  }

  factory RepeatEmailFailure.fromString(String value) {
    if (value == 'mismatchedPasswords') {
      return RepeatEmailFailure.mismatchedPasswords();
    }

    return RepeatEmailFailure.mismatchedPasswords();
  }

  @override
  String toString() {
    if (this is MismatchedEmail) {
      return 'mismatchedPasswords';
    }

    return 'mismatchedPasswords';
  }
}

class MismatchedEmail extends RepeatEmailFailure {}
