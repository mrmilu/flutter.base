import 'package:flutter_base/src/shared/domain/failures/nif_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NifFailure Tests', () {
    group('Factory', () {
      test('should create NifFailureEmpty with default values', () {
        final failure = const NifFailure.empty();
        expect(failure.code, 'empty');
        expect(failure.maxLength, 0);
      });

      test('should create NifFailureInvalid with default values', () {
        final failure = const NifFailure.invalid();
        expect(failure.code, 'invalid');
        expect(failure.maxLength, 0);
      });

      test('should create NifFailureTooLong with default values', () {
        final failure = const NifFailure.tooLong(length: 9);
        expect(failure.code, 'tooLong');
        expect(failure.maxLength, 9);
      });

      test('should create NifFailureTooShort with default values', () {
        final failure = const NifFailure.tooShort(length: 3);
        expect(failure.code, 'tooShort');
        expect(failure.maxLength, 3);
      });
    });
  });
}
