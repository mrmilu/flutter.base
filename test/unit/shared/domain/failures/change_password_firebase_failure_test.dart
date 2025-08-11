import 'package:flutter_base/src/shared/domain/failures/change_password_firebase_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangePasswordFirebaseFailure', () {
    group('Factory constructors', () {
      test(
        'Debería crear ChangePasswordFirebaseFailureWrongPassword correctamente',
        () {
          // Act
          final failure = ChangePasswordFirebaseFailure.wrongPassword();

          // Assert
          expect(failure, isA<ChangePasswordFirebaseFailureWrongPassword>());
          expect(
            failure.runtimeType,
            equals(ChangePasswordFirebaseFailureWrongPassword),
          );
        },
      );

      test(
        'Debería crear ChangePasswordFirebaseFailureInvalidCredential correctamente',
        () {
          // Act
          final failure = ChangePasswordFirebaseFailure.invalidCredential();

          // Assert
          expect(
            failure,
            isA<ChangePasswordFirebaseFailureInvalidCredential>(),
          );
          expect(
            failure.runtimeType,
            equals(ChangePasswordFirebaseFailureInvalidCredential),
          );
        },
      );

      test(
        'Debería crear ChangePasswordFirebaseFailureInvalidArgument correctamente',
        () {
          // Act
          final failure = ChangePasswordFirebaseFailure.invalidArgument();

          // Assert
          expect(failure, isA<ChangePasswordFirebaseFailureInvalidArgument>());
          expect(
            failure.runtimeType,
            equals(ChangePasswordFirebaseFailureInvalidArgument),
          );
        },
      );

      test(
        'Debería crear ChangePasswordFirebaseFailureTooManyRequests correctamente',
        () {
          // Act
          final failure = ChangePasswordFirebaseFailure.tooManyRequests();

          // Assert
          expect(failure, isA<ChangePasswordFirebaseFailureTooManyRequests>());
          expect(
            failure.runtimeType,
            equals(ChangePasswordFirebaseFailureTooManyRequests),
          );
        },
      );
    });

    group('when method', () {
      test(
        'Debería ejecutar callback wrongPassword para ChangePasswordFirebaseFailureWrongPassword',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.wrongPassword();
          var wrongPasswordCallbackExecuted = false;
          var invalidCredentialCallbackExecuted = false;
          var invalidArgumentCallbackExecuted = false;
          var tooManyRequestsCallbackExecuted = false;

          // Act
          failure.when(
            wrongPassword: (failure) => wrongPasswordCallbackExecuted = true,
            invalidCredential: (failure) =>
                invalidCredentialCallbackExecuted = true,
            invalidArgument: (failure) =>
                invalidArgumentCallbackExecuted = true,
            tooManyRequests: (failure) =>
                tooManyRequestsCallbackExecuted = true,
          );

          // Assert
          expect(wrongPasswordCallbackExecuted, isTrue);
          expect(invalidCredentialCallbackExecuted, isFalse);
          expect(invalidArgumentCallbackExecuted, isFalse);
          expect(tooManyRequestsCallbackExecuted, isFalse);
        },
      );

      test(
        'Debería ejecutar callback invalidCredential para ChangePasswordFirebaseFailureInvalidCredential',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.invalidCredential();
          var wrongPasswordCallbackExecuted = false;
          var invalidCredentialCallbackExecuted = false;
          var invalidArgumentCallbackExecuted = false;
          var tooManyRequestsCallbackExecuted = false;

          // Act
          failure.when(
            wrongPassword: (failure) => wrongPasswordCallbackExecuted = true,
            invalidCredential: (failure) =>
                invalidCredentialCallbackExecuted = true,
            invalidArgument: (failure) =>
                invalidArgumentCallbackExecuted = true,
            tooManyRequests: (failure) =>
                tooManyRequestsCallbackExecuted = true,
          );

          // Assert
          expect(wrongPasswordCallbackExecuted, isFalse);
          expect(invalidCredentialCallbackExecuted, isTrue);
          expect(invalidArgumentCallbackExecuted, isFalse);
          expect(tooManyRequestsCallbackExecuted, isFalse);
        },
      );

      test(
        'Debería ejecutar callback invalidArgument para ChangePasswordFirebaseFailureInvalidArgument',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.invalidArgument();
          var wrongPasswordCallbackExecuted = false;
          var invalidCredentialCallbackExecuted = false;
          var invalidArgumentCallbackExecuted = false;
          var tooManyRequestsCallbackExecuted = false;

          // Act
          failure.when(
            wrongPassword: (failure) => wrongPasswordCallbackExecuted = true,
            invalidCredential: (failure) =>
                invalidCredentialCallbackExecuted = true,
            invalidArgument: (failure) =>
                invalidArgumentCallbackExecuted = true,
            tooManyRequests: (failure) =>
                tooManyRequestsCallbackExecuted = true,
          );

          // Assert
          expect(wrongPasswordCallbackExecuted, isFalse);
          expect(invalidCredentialCallbackExecuted, isFalse);
          expect(invalidArgumentCallbackExecuted, isTrue);
          expect(tooManyRequestsCallbackExecuted, isFalse);
        },
      );

      test(
        'Debería ejecutar callback tooManyRequests para ChangePasswordFirebaseFailureTooManyRequests',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.tooManyRequests();
          var wrongPasswordCallbackExecuted = false;
          var invalidCredentialCallbackExecuted = false;
          var invalidArgumentCallbackExecuted = false;
          var tooManyRequestsCallbackExecuted = false;

          // Act
          failure.when(
            wrongPassword: (failure) => wrongPasswordCallbackExecuted = true,
            invalidCredential: (failure) =>
                invalidCredentialCallbackExecuted = true,
            invalidArgument: (failure) =>
                invalidArgumentCallbackExecuted = true,
            tooManyRequests: (failure) =>
                tooManyRequestsCallbackExecuted = true,
          );

          // Assert
          expect(wrongPasswordCallbackExecuted, isFalse);
          expect(invalidCredentialCallbackExecuted, isFalse);
          expect(invalidArgumentCallbackExecuted, isFalse);
          expect(tooManyRequestsCallbackExecuted, isTrue);
        },
      );

      test('Debería pasar la instancia correcta a los callbacks', () {
        // Arrange
        final wrongPasswordFailure =
            ChangePasswordFirebaseFailure.wrongPassword();
        final invalidCredentialFailure =
            ChangePasswordFirebaseFailure.invalidCredential();
        final invalidArgumentFailure =
            ChangePasswordFirebaseFailure.invalidArgument();
        final tooManyRequestsFailure =
            ChangePasswordFirebaseFailure.tooManyRequests();
        ChangePasswordFirebaseFailure? receivedWrongPassword;
        ChangePasswordFirebaseFailure? receivedInvalidCredential;
        ChangePasswordFirebaseFailure? receivedInvalidArgument;
        ChangePasswordFirebaseFailure? receivedTooManyRequests;

        // Act
        wrongPasswordFailure.when(
          wrongPassword: (failure) => receivedWrongPassword = failure,
          invalidCredential: (failure) => receivedInvalidCredential = failure,
          invalidArgument: (failure) => receivedInvalidArgument = failure,
          tooManyRequests: (failure) => receivedTooManyRequests = failure,
        );

        invalidCredentialFailure.when(
          wrongPassword: (failure) => receivedWrongPassword = failure,
          invalidCredential: (failure) => receivedInvalidCredential = failure,
          invalidArgument: (failure) => receivedInvalidArgument = failure,
          tooManyRequests: (failure) => receivedTooManyRequests = failure,
        );

        invalidArgumentFailure.when(
          wrongPassword: (failure) => receivedWrongPassword = failure,
          invalidCredential: (failure) => receivedInvalidCredential = failure,
          invalidArgument: (failure) => receivedInvalidArgument = failure,
          tooManyRequests: (failure) => receivedTooManyRequests = failure,
        );

        tooManyRequestsFailure.when(
          wrongPassword: (failure) => receivedWrongPassword = failure,
          invalidCredential: (failure) => receivedInvalidCredential = failure,
          invalidArgument: (failure) => receivedInvalidArgument = failure,
          tooManyRequests: (failure) => receivedTooManyRequests = failure,
        );

        // Assert
        expect(
          receivedWrongPassword,
          isA<ChangePasswordFirebaseFailureWrongPassword>(),
        );
        expect(
          receivedInvalidCredential,
          isA<ChangePasswordFirebaseFailureInvalidCredential>(),
        );
        expect(
          receivedInvalidArgument,
          isA<ChangePasswordFirebaseFailureInvalidArgument>(),
        );
        expect(
          receivedTooManyRequests,
          isA<ChangePasswordFirebaseFailureTooManyRequests>(),
        );
      });
    });

    group('map method', () {
      test(
        'Debería mapear ChangePasswordFirebaseFailureWrongPassword correctamente',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.wrongPassword();

          // Act
          final result = failure.map<String>(
            wrongPassword: (failure) => 'wrong_password_error',
            invalidCredential: (failure) => 'invalid_credential_error',
            invalidArgument: (failure) => 'invalid_argument_error',
            tooManyRequests: (failure) => 'too_many_requests_error',
          );

          // Assert
          expect(result, equals('wrong_password_error'));
        },
      );

      test(
        'Debería mapear ChangePasswordFirebaseFailureInvalidCredential correctamente',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.invalidCredential();

          // Act
          final result = failure.map<String>(
            wrongPassword: (failure) => 'wrong_password_error',
            invalidCredential: (failure) => 'invalid_credential_error',
            invalidArgument: (failure) => 'invalid_argument_error',
            tooManyRequests: (failure) => 'too_many_requests_error',
          );

          // Assert
          expect(result, equals('invalid_credential_error'));
        },
      );

      test(
        'Debería mapear ChangePasswordFirebaseFailureInvalidArgument correctamente',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.invalidArgument();

          // Act
          final result = failure.map<String>(
            wrongPassword: (failure) => 'wrong_password_error',
            invalidCredential: (failure) => 'invalid_credential_error',
            invalidArgument: (failure) => 'invalid_argument_error',
            tooManyRequests: (failure) => 'too_many_requests_error',
          );

          // Assert
          expect(result, equals('invalid_argument_error'));
        },
      );

      test(
        'Debería mapear ChangePasswordFirebaseFailureTooManyRequests correctamente',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.tooManyRequests();

          // Act
          final result = failure.map<String>(
            wrongPassword: (failure) => 'wrong_password_error',
            invalidCredential: (failure) => 'invalid_credential_error',
            invalidArgument: (failure) => 'invalid_argument_error',
            tooManyRequests: (failure) => 'too_many_requests_error',
          );

          // Assert
          expect(result, equals('too_many_requests_error'));
        },
      );

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        final wrongPasswordFailure =
            ChangePasswordFirebaseFailure.wrongPassword();
        final invalidCredentialFailure =
            ChangePasswordFirebaseFailure.invalidCredential();

        // Act
        final intResult = wrongPasswordFailure.map<int>(
          wrongPassword: (failure) => 1,
          invalidCredential: (failure) => 2,
          invalidArgument: (failure) => 3,
          tooManyRequests: (failure) => 4,
        );

        final boolResult = invalidCredentialFailure.map<bool>(
          wrongPassword: (failure) => true,
          invalidCredential: (failure) => false,
          invalidArgument: (failure) => true,
          tooManyRequests: (failure) => false,
        );

        // Assert
        expect(intResult, equals(1));
        expect(boolResult, equals(false));
      });
    });

    group('maybeWhen method', () {
      test('Debería ejecutar callback específico cuando está presente', () {
        // Arrange
        final failure = ChangePasswordFirebaseFailure.wrongPassword();
        var wrongPasswordExecuted = false;
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          wrongPassword: (failure) => wrongPasswordExecuted = true,
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(wrongPasswordExecuted, isTrue);
        expect(orElseExecuted, isFalse);
      });

      test('Debería ejecutar orElse cuando callback específico es null', () {
        // Arrange
        final failure = ChangePasswordFirebaseFailure.wrongPassword();
        var orElseExecuted = false;

        // Act
        failure.maybeWhen(
          invalidCredential: (failure) => fail('No debería ejecutarse'),
          orElse: () => orElseExecuted = true,
        );

        // Assert
        expect(orElseExecuted, isTrue);
      });

      test(
        'Debería ejecutar callback específico para ChangePasswordFirebaseFailureTooManyRequests',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.tooManyRequests();
          var tooManyRequestsExecuted = false;
          var orElseExecuted = false;

          // Act
          failure.maybeWhen(
            tooManyRequests: (failure) => tooManyRequestsExecuted = true,
            orElse: () => orElseExecuted = true,
          );

          // Assert
          expect(tooManyRequestsExecuted, isTrue);
          expect(orElseExecuted, isFalse);
        },
      );
    });

    group('toString method', () {
      test(
        'Debería devolver "wrongPassword" para ChangePasswordFirebaseFailureWrongPassword',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.wrongPassword();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('wrongPassword'));
        },
      );

      test(
        'Debería devolver "invalidCredential" para ChangePasswordFirebaseFailureInvalidCredential',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.invalidCredential();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('invalidCredential'));
        },
      );

      test(
        'Debería devolver "invalidArgument" para ChangePasswordFirebaseFailureInvalidArgument',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.invalidArgument();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('invalidArgument'));
        },
      );

      test(
        'Debería devolver "tooManyRequests" para ChangePasswordFirebaseFailureTooManyRequests',
        () {
          // Arrange
          final failure = ChangePasswordFirebaseFailure.tooManyRequests();

          // Act
          final result = failure.toString();

          // Assert
          expect(result, equals('tooManyRequests'));
        },
      );
    });

    group('Type checking', () {
      test('Debería identificar correctamente los tipos', () {
        // Arrange
        final wrongPassword = ChangePasswordFirebaseFailure.wrongPassword();
        final invalidCredential =
            ChangePasswordFirebaseFailure.invalidCredential();
        final invalidArgument = ChangePasswordFirebaseFailure.invalidArgument();
        final tooManyRequests = ChangePasswordFirebaseFailure.tooManyRequests();

        // Assert
        expect(
          wrongPassword is ChangePasswordFirebaseFailureWrongPassword,
          isTrue,
        );
        expect(
          wrongPassword is ChangePasswordFirebaseFailureInvalidCredential,
          isFalse,
        );
        expect(
          wrongPassword is ChangePasswordFirebaseFailureInvalidArgument,
          isFalse,
        );
        expect(
          wrongPassword is ChangePasswordFirebaseFailureTooManyRequests,
          isFalse,
        );

        expect(
          invalidCredential is ChangePasswordFirebaseFailureWrongPassword,
          isFalse,
        );
        expect(
          invalidCredential is ChangePasswordFirebaseFailureInvalidCredential,
          isTrue,
        );
        expect(
          invalidCredential is ChangePasswordFirebaseFailureInvalidArgument,
          isFalse,
        );
        expect(
          invalidCredential is ChangePasswordFirebaseFailureTooManyRequests,
          isFalse,
        );

        expect(
          invalidArgument is ChangePasswordFirebaseFailureWrongPassword,
          isFalse,
        );
        expect(
          invalidArgument is ChangePasswordFirebaseFailureInvalidCredential,
          isFalse,
        );
        expect(
          invalidArgument is ChangePasswordFirebaseFailureInvalidArgument,
          isTrue,
        );
        expect(
          invalidArgument is ChangePasswordFirebaseFailureTooManyRequests,
          isFalse,
        );

        expect(
          tooManyRequests is ChangePasswordFirebaseFailureWrongPassword,
          isFalse,
        );
        expect(
          tooManyRequests is ChangePasswordFirebaseFailureInvalidCredential,
          isFalse,
        );
        expect(
          tooManyRequests is ChangePasswordFirebaseFailureInvalidArgument,
          isFalse,
        );
        expect(
          tooManyRequests is ChangePasswordFirebaseFailureTooManyRequests,
          isTrue,
        );
      });
    });

    group('Equality and hashCode', () {
      test('Debería considerar iguales instancias del mismo tipo', () {
        // Arrange
        final wrongPassword1 = ChangePasswordFirebaseFailure.wrongPassword();
        final wrongPassword2 = ChangePasswordFirebaseFailure.wrongPassword();
        final invalidCredential1 =
            ChangePasswordFirebaseFailure.invalidCredential();
        final invalidCredential2 =
            ChangePasswordFirebaseFailure.invalidCredential();

        // Assert
        expect(wrongPassword1.runtimeType, equals(wrongPassword2.runtimeType));
        expect(
          invalidCredential1.runtimeType,
          equals(invalidCredential2.runtimeType),
        );
        expect(
          wrongPassword1.runtimeType,
          isNot(equals(invalidCredential1.runtimeType)),
        );
      });
    });
  });
}
