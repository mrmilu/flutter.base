import 'package:flutter_base/src/shared/domain/failures/phone_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneFailure', () {
    group('Factory constructors', () {
      test('Debería crear PhoneFailureEmpty correctamente', () {
        // Act
        final failure = PhoneFailure.empty();

        // Assert
        expect(failure, isA<PhoneFailureEmpty>());
        expect(failure.runtimeType, equals(PhoneFailureEmpty));
      });

      test('Debería crear PhoneFailureInvalid correctamente', () {
        // Act
        final failure = PhoneFailure.invalid();

        // Assert
        expect(failure, isA<PhoneFailureInvalid>());
        expect(failure.runtimeType, equals(PhoneFailureInvalid));
      });

      test('Debería crear PhoneFailureTooLong correctamente con el length', () {
        // Arrange
        const testLength = 15;

        // Act
        final failure = PhoneFailure.tooLong(testLength);

        // Assert
        expect(failure, isA<PhoneFailureTooLong>());
        expect(failure.runtimeType, equals(PhoneFailureTooLong));
        expect((failure as PhoneFailureTooLong).length, equals(testLength));
      });
    });

    group('when method', () {
      test('Debería ejecutar callback empty para PhoneFailureEmpty', () {
        // Arrange
        final failure = PhoneFailure.empty();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var tooLongCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          tooLong: (failure) => tooLongCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isTrue);
        expect(invalidCallbackExecuted, isFalse);
        expect(tooLongCallbackExecuted, isFalse);
      });

      test('Debería ejecutar callback invalid para PhoneFailureInvalid', () {
        // Arrange
        final failure = PhoneFailure.invalid();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var tooLongCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          tooLong: (failure) => tooLongCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isFalse);
        expect(invalidCallbackExecuted, isTrue);
        expect(tooLongCallbackExecuted, isFalse);
      });

      test('Debería ejecutar callback tooLong para PhoneFailureTooLong', () {
        // Arrange
        final failure = PhoneFailure.tooLong(20);
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;
        var tooLongCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
          tooLong: (failure) => tooLongCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isFalse);
        expect(invalidCallbackExecuted, isFalse);
        expect(tooLongCallbackExecuted, isTrue);
      });

      test('Debería pasar la instancia correcta a los callbacks', () {
        // Arrange
        final emptyFailure = PhoneFailure.empty();
        final invalidFailure = PhoneFailure.invalid();
        final tooLongFailure = PhoneFailure.tooLong(15);
        PhoneFailure? receivedEmpty;
        PhoneFailure? receivedInvalid;
        PhoneFailure? receivedTooLong;

        // Act
        emptyFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          tooLong: (failure) => receivedTooLong = failure,
        );

        invalidFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          tooLong: (failure) => receivedTooLong = failure,
        );

        tooLongFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
          tooLong: (failure) => receivedTooLong = failure,
        );

        // Assert
        expect(receivedEmpty, isA<PhoneFailureEmpty>());
        expect(receivedInvalid, isA<PhoneFailureInvalid>());
        expect(receivedTooLong, isA<PhoneFailureTooLong>());
        expect(receivedEmpty, equals(emptyFailure));
        expect(receivedInvalid, equals(invalidFailure));
        expect(receivedTooLong, equals(tooLongFailure));
      });

      test('Debería pasar el length correcto en callback tooLong', () {
        // Arrange
        const testLength = 25;
        final failure = PhoneFailure.tooLong(testLength);
        int? receivedLength;

        // Act
        failure.when(
          empty: (failure) => fail('No debería ejecutarse'),
          invalid: (failure) => fail('No debería ejecutarse'),
          tooLong: (failure) => receivedLength = failure.length,
        );

        // Assert
        expect(receivedLength, equals(testLength));
      });
    });

    group('map method', () {
      test('Debería mapear PhoneFailureEmpty correctamente', () {
        // Arrange
        final failure = PhoneFailure.empty();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          tooLong: (failure) => 'too_long_error',
        );

        // Assert
        expect(result, equals('empty_error'));
      });

      test('Debería mapear PhoneFailureInvalid correctamente', () {
        // Arrange
        final failure = PhoneFailure.invalid();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          tooLong: (failure) => 'too_long_error',
        );

        // Assert
        expect(result, equals('invalid_error'));
      });

      test('Debería mapear PhoneFailureTooLong correctamente', () {
        // Arrange
        final failure = PhoneFailure.tooLong(20);

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          tooLong: (failure) => 'too_long_error_${failure.length}',
        );

        // Assert
        expect(result, equals('too_long_error_20'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final emptyFailure = PhoneFailure.empty();
        final tooLongFailure = PhoneFailure.tooLong(10);

        // Act
        final intResult = emptyFailure.map<int>(
          empty: (failure) => 1,
          invalid: (failure) => 2,
          tooLong: (failure) => 3,
        );

        final boolResult = tooLongFailure.map<bool>(
          empty: (failure) => true,
          invalid: (failure) => false,
          tooLong: (failure) => failure.length > 5,
        );

        // Assert
        expect(intResult, equals(1));
        expect(boolResult, equals(true));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = PhoneFailure.empty();
        var emptyExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          empty: (failure) => emptyExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(emptyExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = PhoneFailure.empty();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          invalid: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });

      test('Debería ejecutar orElse cuando no hay callback matching', () {
        // Arrange
        final failure = PhoneFailure.tooLong(15);
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          empty: (failure) => fail('No debería ejecutarse'),
          invalid: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });

      test('Debería ejecutar callback específico para PhoneFailureTooLong', () {
        // Arrange
        final failure = PhoneFailure.tooLong(12);
        var tooLongExecuted = false;
        var orElseExecuted = false;
        int? receivedLength;

        // Act
        failure.maybeWhen(
          tooLong: (failure) {
            tooLongExecuted = true;
            receivedLength = failure.length;
          },
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(tooLongExecuted, isTrue);
        expect(orElseExecuted, isFalse);
        expect(receivedLength, equals(12));
      });
    });

    group('toString method', () {
      test('Debería devolver "empty" para PhoneFailureEmpty', () {
        // Arrange
        final failure = PhoneFailure.empty();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('empty'));
      });

      test('Debería devolver "invalid" para PhoneFailureInvalid', () {
        // Arrange
        final failure = PhoneFailure.invalid();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('invalid'));
      });

      test('Debería devolver "tooLong" para PhoneFailureTooLong', () {
        // Arrange
        final failure = PhoneFailure.tooLong(20);

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('tooLong'));
      });
    });

    group('PhoneFailureTooLong properties', () {
      test('Debería mantener el valor de length', () {
        // Arrange
        const testLength = 30;

        // Act
        final failure = PhoneFailure.tooLong(testLength);

        // Assert
        expect((failure as PhoneFailureTooLong).length, equals(testLength));
      });

      test('Debería crear diferentes instancias con diferentes lengths', () {
        // Arrange & Act
        final failure1 = PhoneFailure.tooLong(10);
        final failure2 = PhoneFailure.tooLong(20);

        // Assert
        expect((failure1 as PhoneFailureTooLong).length, equals(10));
        expect((failure2 as PhoneFailureTooLong).length, equals(20));
        expect(failure1.length, isNot(equals(failure2.length)));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los tipos', () {
        // Arrange
        final empty = PhoneFailure.empty();
        final invalid = PhoneFailure.invalid();
        final tooLong = PhoneFailure.tooLong(15);

        // Assert
        expect(empty is PhoneFailureEmpty, isTrue);
        expect(empty is PhoneFailureInvalid, isFalse);
        expect(empty is PhoneFailureTooLong, isFalse);

        expect(invalid is PhoneFailureEmpty, isFalse);
        expect(invalid is PhoneFailureInvalid, isTrue);
        expect(invalid is PhoneFailureTooLong, isFalse);

        expect(tooLong is PhoneFailureEmpty, isFalse);
        expect(tooLong is PhoneFailureInvalid, isFalse);
        expect(tooLong is PhoneFailureTooLong, isTrue);
      });
    });
  });
}
