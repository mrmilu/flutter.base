import 'package:flutter_base/src/shared/domain/failures/email_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailFailure', () {
    group('Factory constructors', () {
      test('Debería crear EmailFailureEmpty correctamente', () {
        // Act
        final failure = EmailFailure.empty();

        // Assert
        expect(failure, isA<EmailFailureEmpty>());
        expect(failure.runtimeType, equals(EmailFailureEmpty));
      });

      test('Debería crear EmailFailureInvalid correctamente', () {
        // Act
        final failure = EmailFailure.invalid();

        // Assert
        expect(failure, isA<EmailFailureInvalid>());
        expect(failure.runtimeType, equals(EmailFailureInvalid));
      });
    });

    group('when method', () {
      test('Debería ejecutar callback empty para EmailFailureEmpty', () {
        // Arrange
        final failure = EmailFailure.empty();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isTrue);
        expect(invalidCallbackExecuted, isFalse);
      });

      test('Debería ejecutar callback invalid para EmailFailureInvalid', () {
        // Arrange
        final failure = EmailFailure.invalid();
        var emptyCallbackExecuted = false;
        var invalidCallbackExecuted = false;

        // Act
        failure.when(
          empty: (failure) => emptyCallbackExecuted = true,
          invalid: (failure) => invalidCallbackExecuted = true,
        );

        // Assert
        expect(emptyCallbackExecuted, isFalse);
        expect(invalidCallbackExecuted, isTrue);
      });

      test('Debería pasar la instancia correcta a los callbacks', () {
        // Arrange
        final emptyFailure = EmailFailure.empty();
        final invalidFailure = EmailFailure.invalid();
        EmailFailure? receivedEmpty;
        EmailFailure? receivedInvalid;

        // Act
        emptyFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
        );

        invalidFailure.when(
          empty: (failure) => receivedEmpty = failure,
          invalid: (failure) => receivedInvalid = failure,
        );

        // Assert
        expect(receivedEmpty, isA<EmailFailureEmpty>());
        expect(receivedInvalid, isA<EmailFailureInvalid>());
        expect(receivedEmpty, equals(emptyFailure));
        expect(receivedInvalid, equals(invalidFailure));
      });
    });

    group('map method', () {
      test('Debería mapear EmailFailureEmpty correctamente', () {
        // Arrange
        final failure = EmailFailure.empty();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
        );

        // Assert
        expect(result, equals('empty_error'));
      });

      test('Debería mapear EmailFailureInvalid correctamente', () {
        // Arrange
        final failure = EmailFailure.invalid();

        // Act
        final result = failure.map<String>(
          empty: (failure) => 'empty_error',
          invalid: (failure) => 'invalid_error',
        );

        // Assert
        expect(result, equals('invalid_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final emptyFailure = EmailFailure.empty();
        final invalidFailure = EmailFailure.invalid();

        // Act
        final intResult = emptyFailure.map<int>(
          empty: (failure) => 1,
          invalid: (failure) => 2,
        );

        final boolResult = invalidFailure.map<bool>(
          empty: (failure) => true,
          invalid: (failure) => false,
        );

        // Assert
        expect(intResult, equals(1));
        expect(boolResult, equals(false));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = EmailFailure.empty();
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
        final failure = EmailFailure.empty();
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
        final failure = EmailFailure.invalid();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          empty: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final empty1 = EmailFailure.empty();
        final empty2 = EmailFailure.empty();
        final invalid1 = EmailFailure.invalid();
        final invalid2 = EmailFailure.invalid();

        // Assert
        expect(empty1.runtimeType, equals(empty2.runtimeType));
        expect(invalid1.runtimeType, equals(invalid2.runtimeType));
        expect(empty1.runtimeType, isNot(equals(invalid1.runtimeType)));
      });
    });

    group('maybeMap method', () {
      test('Debería mapear cuando el callback específico está presente', () {
        // Arrange
        final emptyFailure = EmailFailure.empty();
        final invalidFailure = EmailFailure.invalid();

        // Act
        final emptyResult = emptyFailure.maybeMap<String>(
          empty: (failure) => 'empty_mapped',
          orElse: () => 'default',
        );

        final invalidResult = invalidFailure.maybeMap<String>(
          invalid: (failure) => 'invalid_mapped',
          orElse: () => 'default',
        );

        // Assert
        expect(emptyResult, equals('empty_mapped'));
        expect(invalidResult, equals('invalid_mapped'));
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final emptyFailure = EmailFailure.empty();
        final invalidFailure = EmailFailure.invalid();

        // Act
        final emptyResult = emptyFailure.maybeMap<String>(
          invalid: (failure) => 'should_not_execute',
          orElse: () => 'default_empty',
        );

        final invalidResult = invalidFailure.maybeMap<String>(
          empty: (failure) => 'should_not_execute',
          orElse: () => 'default_invalid',
        );

        // Assert
        expect(emptyResult, equals('default_empty'));
        expect(invalidResult, equals('default_invalid'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final failure = EmailFailure.empty();

        // Act
        final intResult = failure.maybeMap<int>(
          empty: (failure) => 42,
          orElse: () => 0,
        );

        final boolResult = failure.maybeMap<bool>(
          invalid: (failure) => false,
          orElse: () => true,
        );

        // Assert
        expect(intResult, equals(42));
        expect(boolResult, equals(true));
      });
    });

    group('fromString factory method', () {
      test('Debería crear EmailFailureEmpty desde string "empty"', () {
        // Act
        final failure = EmailFailure.fromString('empty');

        // Assert
        expect(failure, isA<EmailFailureEmpty>());
        expect(failure.runtimeType, equals(EmailFailureEmpty));
      });

      test('Debería crear EmailFailureInvalid desde string "invalid"', () {
        // Act
        final failure = EmailFailure.fromString('invalid');

        // Assert
        expect(failure, isA<EmailFailureInvalid>());
        expect(failure.runtimeType, equals(EmailFailureInvalid));
      });

      test('Debería crear EmailFailureEmpty para string desconocido', () {
        // Arrange
        const unknownStrings = [
          'unknown',
          'test',
          '',
          'other',
          'EMPTY',
          'INVALID',
        ];

        for (final unknownString in unknownStrings) {
          // Act
          final failure = EmailFailure.fromString(unknownString);

          // Assert
          expect(
            failure,
            isA<EmailFailureEmpty>(),
            reason:
                'String "$unknownString" debería crear EmailFailureEmpty por defecto',
          );
        }
      });
    });

    group('toString method', () {
      test('Debería retornar "empty" para EmailFailureEmpty', () {
        // Arrange
        final failure = EmailFailure.empty();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('empty'));
      });

      test('Debería retornar "invalid" para EmailFailureInvalid', () {
        // Arrange
        final failure = EmailFailure.invalid();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('invalid'));
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final empty1 = EmailFailure.empty();
        final empty2 = EmailFailure.empty();
        final invalid1 = EmailFailure.invalid();
        final invalid2 = EmailFailure.invalid();

        // Assert
        expect(empty1.runtimeType, equals(empty2.runtimeType));
        expect(invalid1.runtimeType, equals(invalid2.runtimeType));
        expect(empty1.runtimeType, isNot(equals(invalid1.runtimeType)));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los tipos', () {
        // Arrange
        final empty = EmailFailure.empty();
        final invalid = EmailFailure.invalid();

        // Assert
        expect(empty is EmailFailureEmpty, isTrue);
        expect(empty is EmailFailureInvalid, isFalse);
        expect(invalid is EmailFailureInvalid, isTrue);
        expect(invalid is EmailFailureEmpty, isFalse);
      });
    });

    group('Edge cases and default behaviors', () {
      test(
        'Debería mantener comportamiento consistente con múltiples llamadas',
        () {
          // Arrange
          final failure = EmailFailure.empty();

          // Act & Assert - múltiples llamadas al mismo método deberían ser consistentes
          expect(failure.toString(), equals('empty'));
          expect(failure.toString(), equals('empty'));

          var counter = 0;
          failure.when(
            empty: (_) => counter++,
            invalid: (_) => counter += 10,
          );
          failure.when(
            empty: (_) => counter++,
            invalid: (_) => counter += 10,
          );

          expect(
            counter,
            equals(2),
          ); // Debería haberse ejecutado 2 veces el callback empty
        },
      );

      test(
        'Debería funcionar correctamente con fromString y toString roundtrip',
        () {
          // Arrange & Act
          final emptyFromString = EmailFailure.fromString('empty');
          final invalidFromString = EmailFailure.fromString('invalid');

          final emptyToString = emptyFromString.toString();
          final invalidToString = invalidFromString.toString();

          final emptyRoundtrip = EmailFailure.fromString(emptyToString);
          final invalidRoundtrip = EmailFailure.fromString(invalidToString);

          // Assert
          expect(
            emptyFromString.runtimeType,
            equals(emptyRoundtrip.runtimeType),
          );
          expect(
            invalidFromString.runtimeType,
            equals(invalidRoundtrip.runtimeType),
          );
          expect(emptyToString, equals('empty'));
          expect(invalidToString, equals('invalid'));
        },
      );
    });
  });
}
