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

    group('maybeMap method', () {
      test(
        'Debería mapear PhoneFailureEmpty cuando callback está presente',
        () {
          // Arrange
          final failure = PhoneFailure.empty();

          // Act
          final result = failure.maybeMap<String>(
            empty: (failure) => 'mapped_empty',
            orElse: () => 'orElse_called',
          );

          // Assert
          expect(result, equals('mapped_empty'));
        },
      );

      test(
        'Debería mapear PhoneFailureInvalid cuando callback está presente',
        () {
          // Arrange
          final failure = PhoneFailure.invalid();

          // Act
          final result = failure.maybeMap<String>(
            invalid: (failure) => 'mapped_invalid',
            orElse: () => 'orElse_called',
          );

          // Assert
          expect(result, equals('mapped_invalid'));
        },
      );

      test(
        'Debería mapear PhoneFailureTooLong cuando callback está presente',
        () {
          // Arrange
          final failure = PhoneFailure.tooLong(12);

          // Act
          final result = failure.maybeMap<String>(
            tooLong: (failure) => 'mapped_tooLong_${failure.length}',
            orElse: () => 'orElse_called',
          );

          // Assert
          expect(result, equals('mapped_tooLong_12'));
        },
      );

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = PhoneFailure.empty();

        // Act
        final result = failure.maybeMap<String>(
          invalid: (failure) => 'invalid_mapped',
          tooLong: (failure) => 'tooLong_mapped',
          orElse: () => 'orElse_executed',
        );

        // Assert
        expect(result, equals('orElse_executed'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final emptyFailure = PhoneFailure.empty();
        final tooLongFailure = PhoneFailure.tooLong(8);

        // Act
        final intResult = emptyFailure.maybeMap<int>(
          empty: (failure) => 42,
          orElse: () => 0,
        );

        final boolResult = tooLongFailure.maybeMap<bool>(
          tooLong: (failure) => failure.length > 5,
          orElse: () => false,
        );

        // Assert
        expect(intResult, equals(42));
        expect(boolResult, isTrue);
      });

      test('Debería manejar casos donde no hay callback específico', () {
        // Arrange
        final invalidFailure = PhoneFailure.invalid();

        // Act
        final result = invalidFailure.maybeMap<String>(
          empty: (failure) => 'empty_mapped',
          tooLong: (failure) => 'tooLong_mapped',
          orElse: () => 'default_value',
        );

        // Assert
        expect(result, equals('default_value'));
      });
    });

    group('fromString method', () {
      test('Debería crear PhoneFailureEmpty desde string "empty"', () {
        // Act
        final failure = PhoneFailure.fromString('empty');

        // Assert
        expect(failure, isA<PhoneFailureEmpty>());
        expect(failure.toString(), equals('empty'));
      });

      test('Debería crear PhoneFailureInvalid desde string "invalid"', () {
        // Act
        final failure = PhoneFailure.fromString('invalid');

        // Assert
        expect(failure, isA<PhoneFailureInvalid>());
        expect(failure.toString(), equals('invalid'));
      });

      test('Debería crear PhoneFailureTooLong desde string "tooLong"', () {
        // Act
        final failure = PhoneFailure.fromString('tooLong');

        // Assert
        expect(failure, isA<PhoneFailureTooLong>());
        expect(failure.toString(), equals('tooLong'));
        // Default length should be 0 when not specified
        expect((failure as PhoneFailureTooLong).length, equals(0));
      });

      test('Debería crear PhoneFailureEmpty para string no reconocido', () {
        // Act
        final failure1 = PhoneFailure.fromString('unknown');
        final failure2 = PhoneFailure.fromString('');
        final failure3 = PhoneFailure.fromString('INVALID');

        // Assert
        expect(failure1, isA<PhoneFailureEmpty>());
        expect(failure2, isA<PhoneFailureEmpty>());
        expect(failure3, isA<PhoneFailureEmpty>());
      });

      test('Debería ser case-sensitive', () {
        // Act
        final failure1 = PhoneFailure.fromString('Empty');
        final failure2 = PhoneFailure.fromString('INVALID');
        final failure3 = PhoneFailure.fromString('TooLong');

        // Assert
        expect(failure1, isA<PhoneFailureEmpty>());
        expect(failure2, isA<PhoneFailureEmpty>());
        expect(failure3, isA<PhoneFailureEmpty>());
      });
    });

    group('Edge cases', () {
      test('Debería manejar PhoneFailureTooLong con length 0', () {
        // Act
        final failure = PhoneFailure.tooLong(0);

        // Assert
        expect(failure, isA<PhoneFailureTooLong>());
        expect((failure as PhoneFailureTooLong).length, equals(0));
      });

      test('Debería manejar PhoneFailureTooLong con length negativo', () {
        // Act
        final failure = PhoneFailure.tooLong(-1);

        // Assert
        expect(failure, isA<PhoneFailureTooLong>());
        expect((failure as PhoneFailureTooLong).length, equals(-1));
      });

      test('Debería manejar PhoneFailureTooLong con length muy grande', () {
        // Act
        final failure = PhoneFailure.tooLong(999999);

        // Assert
        expect(failure, isA<PhoneFailureTooLong>());
        expect((failure as PhoneFailureTooLong).length, equals(999999));
      });

      test('Debería mantener consistencia en múltiples creaciones', () {
        // Act
        final failure1 = PhoneFailure.empty();
        final failure2 = PhoneFailure.empty();
        final failure3 = PhoneFailure.invalid();
        final failure4 = PhoneFailure.invalid();

        // Assert
        expect(failure1.runtimeType, equals(failure2.runtimeType));
        expect(failure3.runtimeType, equals(failure4.runtimeType));
        expect(failure1.toString(), equals(failure2.toString()));
        expect(failure3.toString(), equals(failure4.toString()));
      });
    });

    group('Roundtrip serialization', () {
      test('Debería mantener consistencia empty -> toString -> fromString', () {
        // Arrange
        final original = PhoneFailure.empty();

        // Act
        final serialized = original.toString();
        final deserialized = PhoneFailure.fromString(serialized);

        // Assert
        expect(deserialized.runtimeType, equals(original.runtimeType));
        expect(deserialized.toString(), equals(original.toString()));
      });

      test(
        'Debería mantener consistencia invalid -> toString -> fromString',
        () {
          // Arrange
          final original = PhoneFailure.invalid();

          // Act
          final serialized = original.toString();
          final deserialized = PhoneFailure.fromString(serialized);

          // Assert
          expect(deserialized.runtimeType, equals(original.runtimeType));
          expect(deserialized.toString(), equals(original.toString()));
        },
      );

      test('Debería mantener consistencia tooLong -> toString -> fromString', () {
        // Arrange
        final original = PhoneFailure.tooLong(12);

        // Act
        final serialized = original.toString();
        final deserialized = PhoneFailure.fromString(serialized);

        // Assert
        expect(deserialized.runtimeType, equals(original.runtimeType));
        expect(deserialized.toString(), equals(original.toString()));
        // Note: length information is lost in toString, so fromString creates with default length 0
        expect((deserialized as PhoneFailureTooLong).length, equals(0));
      });

      test('Debería ser idempotente para múltiples roundtrips', () {
        // Arrange
        final failures = [
          PhoneFailure.empty(),
          PhoneFailure.invalid(),
          PhoneFailure.tooLong(15),
        ];

        for (final original in failures) {
          // Act
          final firstRoundtrip = PhoneFailure.fromString(original.toString());
          final secondRoundtrip = PhoneFailure.fromString(
            firstRoundtrip.toString(),
          );

          // Assert
          expect(
            firstRoundtrip.runtimeType,
            equals(secondRoundtrip.runtimeType),
          );
          expect(firstRoundtrip.toString(), equals(secondRoundtrip.toString()));
        }
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
