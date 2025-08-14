import 'package:flutter_base/src/shared/domain/failures/power_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PowerFailure Tests', () {
    group('Factory', () {
      test('should create PowerFailureEmpty with default values', () {
        final failure = const PowerFailure.empty();
        expect(failure.code, 'empty');
      });

      test('should create PowerFailureInvalid with default values', () {
        final failure = const PowerFailure.invalid();
        expect(failure.code, 'invalid');
      });

      test('should create PowerFailureLess with default values', () {
        final failure = const PowerFailure.less();
        expect(failure.code, 'less');
      });

      test('should create PowerFailureMore with default values', () {
        final failure = const PowerFailure.more();
        expect(failure.code, 'more');
      });
    });
  });
}
