import 'package:flutter_base/src/shared/domain/failures/email_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailFailure Tests', () {
    group('Factory', () {
      test('should create EmailFailureEmpty with default values', () {
        final failure = const EmailFailure.empty();
        expect(failure.code, 'empty');
      });

      test('should create EmailFailureInvalid with default values', () {
        final failure = const EmailFailure.invalid();
        expect(failure.code, 'invalid');
      });
    });
  });
}
