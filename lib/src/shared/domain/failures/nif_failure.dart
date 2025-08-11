enum NifFailure {
  tooLong,
  tooShort,
  invalidFormat;

  const NifFailure();

  R map<R>({
    required R Function() tooLong,
    required R Function() tooShort,
    required R Function() invalidFormat,
  }) {
    switch (this) {
      case NifFailure.tooLong:
        return tooLong();
      case NifFailure.tooShort:
        return tooShort();
      case NifFailure.invalidFormat:
        return invalidFormat();
    }
  }

  static NifFailure fromString(String value) {
    switch (value) {
      case 'tooLong':
        return NifFailure.tooLong;
      case 'tooShort':
        return NifFailure.tooShort;
      case 'invalidFormat':
        return NifFailure.invalidFormat;
      default:
        return NifFailure.invalidFormat;
    }
  }
}
