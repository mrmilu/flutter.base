import 'package:flutter_base/src/shared/domain/failures/password_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasswordFailure Tests', () {
    group('Factory', () {
      test('should create PasswordFailureEmpty with default values', () {
        final failure = const PasswordFailure.empty();
        expect(failure.code, 'empty');
        expect(failure.maxLength, 0);
      });

      test('should create PasswordFailureInvalid with default values', () {
        final failure = const PasswordFailure.minLength(length: 8);
        expect(failure.code, 'minLength');
        expect(failure.maxLength, 8);
      });

      test(
        'should create PasswordFailureIncludeUppercase with default values',
        () {
          final failure = const PasswordFailure.includeUppercase();
          expect(failure.code, 'includeUppercase');
          expect(failure.maxLength, 0);
        },
      );

      test(
        'should create PasswordFailureIncludeLowercase with default values',
        () {
          final failure = const PasswordFailure.includeLowercase();
          expect(failure.code, 'includeLowercase');
          expect(failure.maxLength, 0);
        },
      );
      test('should create PasswordFailureIncludeDigit with default values', () {
        final failure = const PasswordFailure.includeDigit();
        expect(failure.code, 'includeDigit');
        expect(failure.maxLength, 0);
      });
    });
  });
}
