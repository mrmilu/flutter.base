import 'package:flutter_base/src/shared/domain/failures/nie_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NieFailure Tests', () {
    group('Factory', () {
      test('should create NieFailureEmpty with default values', () {
        final failure = const NieFailure.empty();
        expect(failure.code, 'empty');
        expect(failure.maxLength, 0);
      });

      test('should create NieFailureInvalid with default values', () {
        final failure = const NieFailure.invalid();
        expect(failure.code, 'invalid');
        expect(failure.maxLength, 0);
      });

      test('should create NieFailureTooLong with default values', () {
        final failure = const NieFailure.tooLong(length: 9);
        expect(failure.code, 'tooLong');
        expect(failure.maxLength, 9);
      });

      test('should create NieFailureTooShort with default values', () {
        final failure = const NieFailure.tooShort(length: 3);
        expect(failure.code, 'tooShort');
        expect(failure.maxLength, 3);
      });
    });
  });
}
