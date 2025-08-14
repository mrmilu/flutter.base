import 'package:flutter_base/src/shared/domain/failures/fullname_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FullnameFailure Tests', () {
    group('Factory', () {
      test('should create FullnameFailureEmpty with default values', () {
        final failure = const FullnameFailure.empty();
        expect(failure.code, 'empty');
        expect(failure.maxLength, 0);
      });

      test('should create FullnameFailureInvalid with default values', () {
        final failure = const FullnameFailure.invalid();
        expect(failure.code, 'invalid');
        expect(failure.maxLength, 0);
      });

      test('should create FullnameFailureTooLong with default values', () {
        final failure = const FullnameFailure.tooLong(length: 320);
        expect(failure.code, 'tooLong');
        expect(failure.maxLength, 320);
      });
    });
  });
}
