import 'package:flutter_base/src/shared/domain/failures/iban_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IbanFailure Tests', () {
    group('Factory', () {
      test('should create IbanFailureEmpty with default values', () {
        final failure = const IbanFailure.empty();
        expect(failure.code, 'empty');
        expect(failure.maxLength, 0);
      });

      test('should create IbanFailureInvalid with default values', () {
        final failure = const IbanFailure.invalid();
        expect(failure.code, 'invalid');
        expect(failure.maxLength, 0);
      });

      test('should create IbanFailureTooLong with default values', () {
        final failure = const IbanFailure.tooLong(length: 9);
        expect(failure.code, 'tooLong');
        expect(failure.maxLength, 9);
      });

      test('should create IbanFailureTooShort with default values', () {
        final failure = const IbanFailure.tooShort(length: 3);
        expect(failure.code, 'tooShort');
        expect(failure.maxLength, 3);
      });

      test('should create IbanFailureInvalidFormat with default values', () {
        final failure = const IbanFailure.invalidFormat();
        expect(failure.code, 'invalidFormat');
        expect(failure.maxLength, 0);
      });

      test('should create IbanFailureInvalidChecksum with default values', () {
        final failure = const IbanFailure.invalidChecksum();
        expect(failure.code, 'invalidChecksum');
        expect(failure.maxLength, 0);
      });
    });
  });
}
