import 'package:flutter_base/src/shared/domain/failures/repeat_password_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RepeatPasswordFailure Tests', () {
    group('Factory', () {
      test(
        'should create RepeatPasswordFailureMismatchedPasswords with default values',
        () {
          final failure = const RepeatPasswordFailure.mismatched();
          expect(failure.code, 'mismatched');
        },
      );
    });
  });
}
