import 'package:flutter_base/src/shared/domain/failures/repeat_password_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RepeatPasswordFailure', () {
    group('Factory constructors', () {
      test('Debería crear MismatchedPasswords correctamente', () {
        // Act
        final failure = RepeatPasswordFailure.mismatchedPasswords();

        // Assert
        expect(failure, isA<MismatchedPasswords>());
        expect(failure.runtimeType, equals(MismatchedPasswords));
      });
    });

    group('fromString method', () {
      test(
        'Debería crear MismatchedPasswords desde string "mismatchedPasswords"',
        () {
          // Act
          final result = RepeatPasswordFailure.fromString(
            'mismatchedPasswords',
          );

          // Assert
          expect(result, isA<MismatchedPasswords>());
        },
      );

      test('Debería devolver MismatchedPasswords para string desconocido', () {
        // Act
        final result1 = RepeatPasswordFailure.fromString('unknown');
        final result2 = RepeatPasswordFailure.fromString('');
        final result3 = RepeatPasswordFailure.fromString('invalid');

        // Assert
        expect(result1, isA<MismatchedPasswords>());
        expect(result2, isA<MismatchedPasswords>());
        expect(result3, isA<MismatchedPasswords>());
      });
    });

    group('when method', () {
      test(
        'Debería ejecutar callback mismatchedPasswords para MismatchedPasswords',
        () {
          // Arrange
          final failure = RepeatPasswordFailure.mismatchedPasswords();
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
        final mismatchedPasswordsFailure =
            RepeatPasswordFailure.mismatchedPasswords();
        RepeatPasswordFailure? receivedMismatchedPasswords;

        // Act
        mismatchedPasswordsFailure.when(
          mismatchedPasswords: (failure) =>
              receivedMismatchedPasswords = failure,
        );

        // Assert
        expect(receivedMismatchedPasswords, isA<MismatchedPasswords>());
        expect(receivedMismatchedPasswords, equals(mismatchedPasswordsFailure));
      });
    });

    group('map method', () {
      test('Debería mapear MismatchedPasswords correctamente', () {
        // Arrange
        final failure = RepeatPasswordFailure.mismatchedPasswords();

        // Act
        final result = failure.map<String>(
          mismatchedPasswords: (failure) => 'mismatched_passwords_error',
        );

        // Assert
        expect(result, equals('mismatched_passwords_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final mismatchedPasswordsFailure =
            RepeatPasswordFailure.mismatchedPasswords();

        // Act
        final intResult = mismatchedPasswordsFailure.map<int>(
          mismatchedPasswords: (failure) => 1,
        );

        final boolResult = mismatchedPasswordsFailure.map<bool>(
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
        final failure = RepeatPasswordFailure.mismatchedPasswords();
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
        final failure = RepeatPasswordFailure.mismatchedPasswords();
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
      test(
        'Debería devolver "mismatchedPasswords" para MismatchedPasswords',
        () {
          // Arrange
          final failure = RepeatPasswordFailure.mismatchedPasswords();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('mismatchedPasswords'));
        },
      );
    });

    group('Type checking', () {
      test('Debería identificar correctamente el tipo', () {
        // Arrange
        final mismatchedPasswords = RepeatPasswordFailure.mismatchedPasswords();

        // Assert
        expect(mismatchedPasswords is MismatchedPasswords, isTrue);
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final mismatchedPasswords1 =
            RepeatPasswordFailure.mismatchedPasswords();
        final mismatchedPasswords2 =
            RepeatPasswordFailure.mismatchedPasswords();

        // Assert
        expect(
          mismatchedPasswords1.runtimeType,
          equals(mismatchedPasswords2.runtimeType),
        );
      });
    });
  });
}
