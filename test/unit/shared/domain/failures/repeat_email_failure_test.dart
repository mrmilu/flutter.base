import 'package:flutter_base/src/shared/domain/failures/repeat_email_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RepeatEmailFailure', () {
    group('Factory constructors', () {
      test('Debería crear MismatchedEmail correctamente', () {
        // Act
        final failure = RepeatEmailFailure.mismatchedPasswords();

        // Assert
        expect(failure, isA<MismatchedEmail>());
        expect(failure.runtimeType, equals(MismatchedEmail));
      });
    });

    group('when method', () {
      test(
        'Debería ejecutar callback mismatchedPasswords para MismatchedEmail',
        () {
          // Arrange
          final failure = RepeatEmailFailure.mismatchedPasswords();
          var mismatchedPasswordsCallbackExecuted = false;

          // Act
          failure.when(
            mismatchedPasswords: (failure) =>
                mismatchedPasswordsCallbackExecuted = true,
          );

          // Assert
          expect(mismatchedPasswordsCallbackExecuted, isTrue);
        },
      );

      test('Debería pasar la instancia correcta al callback', () {
        // Arrange
        final mismatchedEmailFailure = RepeatEmailFailure.mismatchedPasswords();
        RepeatEmailFailure? receivedMismatchedEmail;

        // Act
        mismatchedEmailFailure.when(
          mismatchedPasswords: (failure) => receivedMismatchedEmail = failure,
        );

        // Assert
        expect(receivedMismatchedEmail, isA<MismatchedEmail>());
        expect(receivedMismatchedEmail, equals(mismatchedEmailFailure));
      });
    });

    group('map method', () {
      test('Debería mapear MismatchedEmail correctamente', () {
        // Arrange
        final failure = RepeatEmailFailure.mismatchedPasswords();

        // Act
        final result = failure.map<String>(
          mismatchedPasswords: (failure) => 'mismatched_email_error',
        );

        // Assert
        expect(result, equals('mismatched_email_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final mismatchedEmailFailure = RepeatEmailFailure.mismatchedPasswords();

        // Act
        final intResult = mismatchedEmailFailure.map<int>(
          mismatchedPasswords: (failure) => 1,
        );

        final boolResult = mismatchedEmailFailure.map<bool>(
          mismatchedPasswords: (failure) => true,
        );

        // Assert
        expect(intResult, equals(1));
        expect(boolResult, equals(true));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = RepeatEmailFailure.mismatchedPasswords();
        var mismatchedPasswordsExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          mismatchedPasswords: (failure) => mismatchedPasswordsExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(mismatchedPasswordsExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = RepeatEmailFailure.mismatchedPasswords();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });
    });

    group('toString method', () {
      test('Debería devolver "mismatchedPasswords" para MismatchedEmail', () {
        // Arrange
        final failure = RepeatEmailFailure.mismatchedPasswords();

        // Act
        final result = failure.toString();

        // Assert
        expect(result, equals('mismatchedPasswords'));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente el tipo', () {
        // Arrange
        final mismatchedEmail = RepeatEmailFailure.mismatchedPasswords();

        // Assert
        expect(mismatchedEmail is MismatchedEmail, isTrue);
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final mismatchedEmail1 = RepeatEmailFailure.mismatchedPasswords();
        final mismatchedEmail2 = RepeatEmailFailure.mismatchedPasswords();

        // Assert
        expect(
          mismatchedEmail1.runtimeType,
          equals(mismatchedEmail2.runtimeType),
        );
      });
    });
  });
}
