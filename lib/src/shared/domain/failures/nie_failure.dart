import 'package:flutter/material.dart';

import '../../../shared/helpers/extensions.dart';

enum NieFailure {
  tooLong,
  tooShort,
  invalidFormat;

  const NieFailure();

  R map<R>({
    required R Function() tooLong,
    required R Function() tooShort,
    required R Function() invalidFormat,
  }) {
    switch (this) {
      case NieFailure.tooLong:
        return tooLong();
      case NieFailure.tooShort:
        return tooShort();
      case NieFailure.invalidFormat:
        return invalidFormat();
    }
  }

  static NieFailure fromString(String value) {
    switch (value) {
      case 'tooLong':
        return NieFailure.tooLong;
      case 'tooShort':
        return NieFailure.tooShort;
      case 'invalidFormat':
        return NieFailure.invalidFormat;
      default:
        return NieFailure.invalidFormat;
    }
  }

  String toTranslate(BuildContext context) {
    switch (this) {
      case NieFailure.tooLong:
        return context.l10n.tooLong;
      case NieFailure.tooShort:
        return context.l10n.tooShort;
      case NieFailure.invalidFormat:
        return context.l10n.nieInvalid;
    }
  }
}
