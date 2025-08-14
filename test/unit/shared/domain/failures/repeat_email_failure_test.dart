import 'package:flutter_base/src/shared/domain/failures/repeat_email_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RepeatEmailFailure Tests', () {
    group('Factory', () {
      test(
        'should create RepeatEmailFailureMismatchedPasswords with default values',
        () {
          final failure = const RepeatEmailFailure.mismatched();
          expect(failure.code, 'mismatched');
        },
      );
    });
  });
}
