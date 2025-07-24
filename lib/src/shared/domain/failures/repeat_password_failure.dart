class MismatchedPasswords extends RepeatPasswordFailure {}

abstract class RepeatPasswordFailure {
  const RepeatPasswordFailure();
  factory RepeatPasswordFailure.fromString(String value) {
    if (value == 'mismatchedPasswords') {
      return RepeatPasswordFailure.mismatchedPasswords();
    }

    return RepeatPasswordFailure.mismatchedPasswords();
  }

  factory RepeatPasswordFailure.mismatchedPasswords() = MismatchedPasswords;

  R map<R>({
    required R Function(MismatchedPasswords) mismatchedPasswords,
  }) {
    if (this is MismatchedPasswords) {
      return mismatchedPasswords.call(this as MismatchedPasswords);
    }

    return mismatchedPasswords.call(this as MismatchedPasswords);
  }

  R maybeMap<R>({
    R Function(MismatchedPasswords)? mismatchedPasswords,
    required R Function() orElse,
  }) {
    if (this is MismatchedPasswords && mismatchedPasswords != null) {
      return mismatchedPasswords.call(this as MismatchedPasswords);
    }

    return orElse.call();
  }

  void maybeWhen({
    void Function(MismatchedPasswords)? mismatchedPasswords,
    required void Function() orElse,
  }) {
    if (this is MismatchedPasswords && mismatchedPasswords != null) {
      mismatchedPasswords.call(this as MismatchedPasswords);
    }

    orElse.call();
  }

  @override
  String toString() {
    if (this is MismatchedPasswords) {
      return 'mismatchedPasswords';
    }

    return 'mismatchedPasswords';
  }

  void when({
    required void Function(MismatchedPasswords) mismatchedPasswords,
  }) {
    if (this is MismatchedPasswords) {
      mismatchedPasswords.call(this as MismatchedPasswords);
    }

    mismatchedPasswords.call(this as MismatchedPasswords);
  }
}
