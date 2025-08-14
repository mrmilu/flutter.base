import 'package:flutter_base/src/shared/domain/failures/phone_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneFailure Tests', () {
    group('Factory', () {
      test('should create PhoneFailureEmpty with default values', () {
        final failure = const PhoneFailure.empty();
        expect(failure.code, 'empty');
        expect(failure.maxLength, 0);
      });

      test('should create PhoneFailureInvalid with default values', () {
        final failure = const PhoneFailure.invalid();
        expect(failure.code, 'invalid');
        expect(failure.maxLength, 0);
      });

      test('should create PhoneFailureTooLong with default values', () {
        final failure = const PhoneFailure.tooLong(length: 9);
        expect(failure.code, 'tooLong');
        expect(failure.maxLength, 9);
      });
    });
  });
}
