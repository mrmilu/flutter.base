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
  });
}
