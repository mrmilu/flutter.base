import 'package:flutter_base/src/shared/domain/failures/fullname_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FullnameFailure', () {
    group('Factory constructors', () {
      test('Debería crear FullnameFailureEmpty correctamente', () {
        // Act
        final failure = FullnameFailure.empty();

        // Assert
        expect(failure, isA<FullnameFailureEmpty>());
        expect(failure.runtimeType, equals(FullnameFailureEmpty));
      });

      test('Debería crear FullnameFailureInvalid correctamente', () {
        // Act
        final failure = FullnameFailure.invalid();

        // Assert
        expect(failure, isA<FullnameFailureInvalid>());
        expect(failure.runtimeType, equals(FullnameFailureInvalid));
      });

      test(
        'Debería crear FullnameFailureTooLong correctamente con el length',
        () {
          // Arrange
          const testLength = 100;

          // Act
          final failure = FullnameFailure.tooLong(testLength);

          // Assert
          expect(failure, isA<FullnameFailureTooLong>());
          expect(failure.runtimeType, equals(FullnameFailureTooLong));
          expect(
            (failure as FullnameFailureTooLong).length,
            equals(testLength),
          );
        },
      );
    });

    group('when method', () {
      test('Debería ejecutar callback empty para FullnameFailureEmpty', () {
        // Arrange
        final failure = FullnameFailure.empty();
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

      test('Debería ejecutar callback invalid para FullnameFailureInvalid', () {
        // Arrange
        final failure = FullnameFailure.invalid();
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

      test('Debería ejecutar callback tooLong para FullnameFailureTooLong', () {
        // Arrange
        final failure = FullnameFailure.tooLong(50);
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
        final emptyFailure = FullnameFailure.empty();
        final invalidFailure = FullnameFailure.invalid();
        final tooLongFailure = FullnameFailure.tooLong(75);
        FullnameFailure? receivedEmpty;
        FullnameFailure? receivedInvalid;
        FullnameFailure? receivedTooLong;

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
        expect(receivedEmpty, isA<FullnameFailureEmpty>());
        expect(receivedInvalid, isA<FullnameFailureInvalid>());
        expect(receivedTooLong, isA<FullnameFailureTooLong>());
        expect(receivedEmpty, equals(emptyFailure));
        expect(receivedInvalid, equals(invalidFailure));
        expect(receivedTooLong, equals(tooLongFailure));
      });

      test('Debería pasar el length correcto en callback tooLong', () {
        // Arrange
        const testLength = 120;
        final failure = FullnameFailure.tooLong(testLength);
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
      test('Debería mapear FullnameFailureEmpty correctamente', () {
        // Arrange
        final failure = FullnameFailure.empty();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          tooLong: (failure) => 'too_long_error',
        );

        // Assert
        expect(result, equals('empty_error'));
      });

      test('Debería mapear FullnameFailureInvalid correctamente', () {
        // Arrange
        final failure = FullnameFailure.invalid();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          tooLong: (failure) => 'too_long_error',
        );

        // Assert
        expect(result, equals('invalid_error'));
      });

      test('Debería mapear FullnameFailureTooLong correctamente', () {
        // Arrange
        final failure = FullnameFailure.tooLong(85);

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
          tooLong: (failure) => 'too_long_error_${failure.length}',
        );

        // Assert
        expect(result, equals('too_long_error_85'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final emptyFailure = FullnameFailure.empty();
        final tooLongFailure = FullnameFailure.tooLong(60);

        // Act
        final intResult = emptyFailure.map<int>(
          empty: (failure) => 1,
          invalid: (failure) => 2,
          tooLong: (failure) => 3,
        );

        final boolResult = tooLongFailure.map<bool>(
          empty: (failure) => true,
          invalid: (failure) => false,
          tooLong: (failure) => failure.length > 50,
        );

        // Assert
        expect(intResult, equals(1));
        expect(boolResult, equals(true));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = FullnameFailure.empty();
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
        final failure = FullnameFailure.empty();
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
        final failure = FullnameFailure.tooLong(90);
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

      test(
        'Debería ejecutar callback específico para FullnameFailureTooLong',
        () {
          // Arrange
          final failure = FullnameFailure.tooLong(80);
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
          expect(receivedLength, equals(80));
        },
      );
    });

    group('toString method', () {
      test('Debería devolver "empty" para FullnameFailureEmpty', () {
        // Arrange
        final failure = FullnameFailure.empty();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('empty'));
      });

      test('Debería devolver "invalid" para FullnameFailureInvalid', () {
        // Arrange
        final failure = FullnameFailure.invalid();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('invalid'));
      });

      test('Debería devolver "tooLong" para FullnameFailureTooLong', () {
        // Arrange
        final failure = FullnameFailure.tooLong(95);

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('tooLong'));
      });
    });

    group('FullnameFailureTooLong properties', () {
      test('Debería mantener el valor de length', () {
        // Arrange
        const testLength = 150;

        // Act
        final failure = FullnameFailure.tooLong(testLength);

        // Assert
        expect((failure as FullnameFailureTooLong).length, equals(testLength));
      });

      test('Debería crear diferentes instancias con diferentes lengths', () {
        // Arrange & Act
        final failure1 = FullnameFailure.tooLong(40);
        final failure2 = FullnameFailure.tooLong(80);

        // Assert
        expect((failure1 as FullnameFailureTooLong).length, equals(40));
        expect((failure2 as FullnameFailureTooLong).length, equals(80));
        expect(failure1.length, isNot(equals(failure2.length)));
      });
    });

    group('maybeMap method', () {
      test(
        'Debería mapear FullnameFailureEmpty cuando callback está presente',
        () {
          // Arrange
          final failure = FullnameFailure.empty();

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
        'Debería mapear FullnameFailureInvalid cuando callback está presente',
        () {
          // Arrange
          final failure = FullnameFailure.invalid();

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
        'Debería mapear FullnameFailureTooLong cuando callback está presente',
        () {
          // Arrange
          final failure = FullnameFailure.tooLong(65);

          // Act
          final result = failure.maybeMap<String>(
            tooLong: (failure) => 'mapped_tooLong_${failure.length}',
            orElse: () => 'orElse_called',
          );

          // Assert
          expect(result, equals('mapped_tooLong_65'));
        },
      );

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = FullnameFailure.empty();

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
        final emptyFailure = FullnameFailure.empty();
        final tooLongFailure = FullnameFailure.tooLong(45);

        // Act
        final intResult = emptyFailure.maybeMap<int>(
          empty: (failure) => 42,
          orElse: () => 0,
        );

        final boolResult = tooLongFailure.maybeMap<bool>(
          tooLong: (failure) => failure.length > 40,
          orElse: () => false,
        );

        // Assert
        expect(intResult, equals(42));
        expect(boolResult, isTrue);
      });

      test('Debería manejar casos donde no hay callback específico', () {
        // Arrange
        final invalidFailure = FullnameFailure.invalid();

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
      test('Debería crear FullnameFailureEmpty desde string "empty"', () {
        // Act
        final failure = FullnameFailure.fromString('empty');

        // Assert
        expect(failure, isA<FullnameFailureEmpty>());
        expect(failure.toString(), equals('empty'));
      });

      test('Debería crear FullnameFailureInvalid desde string "invalid"', () {
        // Act
        final failure = FullnameFailure.fromString('invalid');

        // Assert
        expect(failure, isA<FullnameFailureInvalid>());
        expect(failure.toString(), equals('invalid'));
      });

      test('Debería crear FullnameFailureTooLong desde string "tooLong"', () {
        // Act
        final failure = FullnameFailure.fromString('tooLong');

        // Assert
        expect(failure, isA<FullnameFailureTooLong>());
        expect(failure.toString(), equals('tooLong'));
        // Default length should be 0 when not specified
        expect((failure as FullnameFailureTooLong).length, equals(0));
      });

      test('Debería crear FullnameFailureEmpty para string no reconocido', () {
        // Act
        final failure1 = FullnameFailure.fromString('unknown');
        final failure2 = FullnameFailure.fromString('');
        final failure3 = FullnameFailure.fromString('INVALID');

        // Assert
        expect(failure1, isA<FullnameFailureEmpty>());
        expect(failure2, isA<FullnameFailureEmpty>());
        expect(failure3, isA<FullnameFailureEmpty>());
      });

      test('Debería ser case-sensitive', () {
        // Act
        final failure1 = FullnameFailure.fromString('Empty');
        final failure2 = FullnameFailure.fromString('INVALID');
        final failure3 = FullnameFailure.fromString('TooLong');

        // Assert
        expect(failure1, isA<FullnameFailureEmpty>());
        expect(failure2, isA<FullnameFailureEmpty>());
        expect(failure3, isA<FullnameFailureEmpty>());
      });
    });

    group('Edge cases', () {
      test('Debería manejar FullnameFailureTooLong con length 0', () {
        // Act
        final failure = FullnameFailure.tooLong(0);

        // Assert
        expect(failure, isA<FullnameFailureTooLong>());
        expect((failure as FullnameFailureTooLong).length, equals(0));
      });

      test('Debería manejar FullnameFailureTooLong con length negativo', () {
        // Act
        final failure = FullnameFailure.tooLong(-1);

        // Assert
        expect(failure, isA<FullnameFailureTooLong>());
        expect((failure as FullnameFailureTooLong).length, equals(-1));
      });

      test('Debería manejar FullnameFailureTooLong con length muy grande', () {
        // Act
        final failure = FullnameFailure.tooLong(999999);

        // Assert
        expect(failure, isA<FullnameFailureTooLong>());
        expect((failure as FullnameFailureTooLong).length, equals(999999));
      });

      test('Debería mantener consistencia en múltiples creaciones', () {
        // Act
        final failure1 = FullnameFailure.empty();
        final failure2 = FullnameFailure.empty();
        final failure3 = FullnameFailure.invalid();
        final failure4 = FullnameFailure.invalid();

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
        final original = FullnameFailure.empty();

        // Act
        final serialized = original.toString();
        final deserialized = FullnameFailure.fromString(serialized);

        // Assert
        expect(deserialized.runtimeType, equals(original.runtimeType));
        expect(deserialized.toString(), equals(original.toString()));
      });

      test(
        'Debería mantener consistencia invalid -> toString -> fromString',
        () {
          // Arrange
          final original = FullnameFailure.invalid();

          // Act
          final serialized = original.toString();
          final deserialized = FullnameFailure.fromString(serialized);

          // Assert
          expect(deserialized.runtimeType, equals(original.runtimeType));
          expect(deserialized.toString(), equals(original.toString()));
        },
      );

      test('Debería mantener consistencia tooLong -> toString -> fromString', () {
        // Arrange
        final original = FullnameFailure.tooLong(75);

        // Act
        final serialized = original.toString();
        final deserialized = FullnameFailure.fromString(serialized);

        // Assert
        expect(deserialized.runtimeType, equals(original.runtimeType));
        expect(deserialized.toString(), equals(original.toString()));
        // Note: length information is lost in toString, so fromString creates with default length 0
        expect((deserialized as FullnameFailureTooLong).length, equals(0));
      });

      test('Debería ser idempotente para múltiples roundtrips', () {
        // Arrange
        final failures = [
          FullnameFailure.empty(),
          FullnameFailure.invalid(),
          FullnameFailure.tooLong(50),
        ];

        for (final original in failures) {
          // Act
          final firstRoundtrip = FullnameFailure.fromString(
            original.toString(),
          );
          final secondRoundtrip = FullnameFailure.fromString(
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
        final empty = FullnameFailure.empty();
        final invalid = FullnameFailure.invalid();
        final tooLong = FullnameFailure.tooLong(70);

        // Assert
        expect(empty is FullnameFailureEmpty, isTrue);
        expect(empty is FullnameFailureInvalid, isFalse);
        expect(empty is FullnameFailureTooLong, isFalse);

        expect(invalid is FullnameFailureEmpty, isFalse);
        expect(invalid is FullnameFailureInvalid, isTrue);
        expect(invalid is FullnameFailureTooLong, isFalse);

        expect(tooLong is FullnameFailureEmpty, isFalse);
        expect(tooLong is FullnameFailureInvalid, isFalse);
        expect(tooLong is FullnameFailureTooLong, isTrue);
      });
    });
  });
}
