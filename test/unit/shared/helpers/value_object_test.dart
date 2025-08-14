import 'package:flutter_base/src/shared/helpers/either.dart';
import 'package:flutter_base/src/shared/helpers/value_object.dart';
import 'package:flutter_test/flutter_test.dart';

// Implementaciones concretas para testing
class TestValidValueObject extends ValueObject<String, int> {
  final int _value;

  const TestValidValueObject(this._value);

  @override
  Either<String, int> get value => Either.right(_value);
}

class TestInvalidValueObject extends ValueObject<String, int> {
  final String _error;

  const TestInvalidValueObject(this._error);

  @override
  Either<String, int> get value => Either.left(_error);
}

void main() {
  group('ValueObject', () {
    group('Valid ValueObject', () {
      late TestValidValueObject validValueObject;

      setUp(() {
        validValueObject = const TestValidValueObject(42);
      });

      test('should return true for isValid when value is right', () {
        expect(validValueObject.isValid(), true);
      });

      test('should return false for isInvalid when value is right', () {
        expect(validValueObject.isInvalid(), false);
      });

      test('should return value with getOrCrash when value is right', () {
        expect(validValueObject.getOrCrash(), 42);
      });

      test('should return value with getOrElse when value is right', () {
        expect(validValueObject.getOrElse(0), 42);
      });

      test('should call isRight function in when method', () {
        String? calledFunction;
        int? receivedValue;

        validValueObject.when(
          isLeft: (error) => calledFunction = 'left: $error',
          isRight: (value) {
            calledFunction = 'right';
            receivedValue = value;
          },
        );

        expect(calledFunction, 'right');
        expect(receivedValue, 42);
      });

      test('should call isRight function in map method', () {
        final result = validValueObject.map<String>(
          isLeft: (error) => 'error: $error',
          isRight: (value) => 'success: $value',
        );

        expect(result, 'success: 42');
      });
    });

    group('Invalid ValueObject', () {
      late TestInvalidValueObject invalidValueObject;

      setUp(() {
        invalidValueObject = const TestInvalidValueObject('validation error');
      });

      test('should return false for isValid when value is left', () {
        expect(invalidValueObject.isValid(), false);
      });

      test('should return true for isInvalid when value is left', () {
        expect(invalidValueObject.isInvalid(), true);
      });

      test(
        'should throw UnexpectedValueError with getOrCrash when value is left',
        () {
          expect(
            () => invalidValueObject.getOrCrash(),
            throwsA(isA<UnexpectedValueError<String>>()),
          );

          try {
            invalidValueObject.getOrCrash();
          } catch (e) {
            expect(e, isA<UnexpectedValueError<String>>());
            final error = e as UnexpectedValueError<String>;
            expect(error.valueFailure, 'validation error');
          }
        },
      );

      test('should return orElse value with getOrElse when value is left', () {
        expect(invalidValueObject.getOrElse(99), 99);
      });

      test('should call isLeft function in when method', () {
        String? calledFunction;
        String? receivedError;

        invalidValueObject.when(
          isLeft: (error) {
            calledFunction = 'left';
            receivedError = error;
          },
          isRight: (value) => calledFunction = 'right: $value',
        );

        expect(calledFunction, 'left');
        expect(receivedError, 'validation error');
      });

      test('should call isLeft function in map method', () {
        final result = invalidValueObject.map<String>(
          isLeft: (error) => 'error: $error',
          isRight: (value) => 'success: $value',
        );

        expect(result, 'error: validation error');
      });
    });

    group('Equality and hashCode', () {
      test('should return true for identical instances', () {
        const valueObject = TestValidValueObject(42);

        expect(valueObject == valueObject, true);
      });

      test('should return true for equal ValueObjects with same value', () {
        const valueObject1 = TestValidValueObject(42);
        const valueObject2 = TestValidValueObject(42);

        expect(valueObject1 == valueObject2, true);
      });

      test('should return false for ValueObjects with different values', () {
        const valueObject1 = TestValidValueObject(42);
        const valueObject2 = TestValidValueObject(24);

        expect(valueObject1 == valueObject2, false);
      });

      test('should return false for valid vs invalid ValueObjects', () {
        const validValueObject = TestValidValueObject(42);
        const invalidValueObject = TestInvalidValueObject('error');

        expect(validValueObject == invalidValueObject, false);
      });

      test('should return false when comparing with different type', () {
        const valueObject = TestValidValueObject(42);

        expect(valueObject.value.right.runtimeType == String, false);
      });

      test('should return same hashCode for equal ValueObjects', () {
        const valueObject1 = TestValidValueObject(42);
        const valueObject2 = TestValidValueObject(42);

        expect(valueObject1.hashCode, valueObject2.hashCode);
      });

      test('should return different hashCode for different ValueObjects', () {
        const valueObject1 = TestValidValueObject(42);
        const valueObject2 = TestValidValueObject(24);

        expect(valueObject1.hashCode, isNot(valueObject2.hashCode));
      });
    });

    group('toString method', () {
      test(
        'should return correct string representation for valid ValueObject',
        () {
          const valueObject = TestValidValueObject(42);

          expect(
            valueObject.toString(),
            'Value(Either(left: null, right: 42))',
          );
        },
      );

      test(
        'should return correct string representation for invalid ValueObject',
        () {
          const valueObject = TestInvalidValueObject('error');

          expect(
            valueObject.toString(),
            'Value(Either(left: error, right: null))',
          );
        },
      );
    });
  });

  group('UnexpectedValueError', () {
    test('should store valueFailure correctly', () {
      const failure = 'test failure';
      final error = UnexpectedValueError(failure);

      expect(error.valueFailure, failure);
    });

    test('should return correct toString representation', () {
      const failure = 'test failure';
      final error = UnexpectedValueError(failure);

      final errorString = error.toString();

      expect(
        errorString,
        contains(
          'Encountered a ValueFailure at an unrecoverable point. Terminating.',
        ),
      );
      expect(errorString, contains('Failure was: test failure'));
    });

    test('should handle complex failure objects in toString', () {
      final complexFailure = {'code': 500, 'message': 'Server error'};
      final error = UnexpectedValueError(complexFailure);

      final errorString = error.toString();

      expect(
        errorString,
        contains(
          'Encountered a ValueFailure at an unrecoverable point. Terminating.',
        ),
      );
      expect(
        errorString,
        contains('Failure was: {code: 500, message: Server error}'),
      );
    });

    test('should handle null failure in toString', () {
      final error = UnexpectedValueError(null);

      final errorString = error.toString();

      expect(
        errorString,
        contains(
          'Encountered a ValueFailure at an unrecoverable point. Terminating.',
        ),
      );
      expect(errorString, contains('Failure was: null'));
    });
  });
}
