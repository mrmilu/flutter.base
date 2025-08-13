import 'package:flutter_base/src/shared/domain/failures/change_password_firebase_failure.dart';
import 'package:flutter_base/src/shared/domain/failures/general_base_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChangePasswordFirebaseFailure Tests', () {
    group('Get Message', () {
      test('should return correct message for wrongPassword', () {
        final failure = const ChangePasswordFirebaseFailure.wrongPassword();
        expect(failure.message, 'Contraseña incorrecta.');
      });

      test('should return correct message for invalidCredential', () {
        final failure = const ChangePasswordFirebaseFailure.invalidCredential();
        expect(failure.message, 'Credenciales inválidas.');
      });

      test('should return correct message for invalidArgument', () {
        final failure = const ChangePasswordFirebaseFailure.invalidArgument();
        expect(failure.message, 'Argumento inválido.');
      });

      test('should return correct message for tooManyRequests', () {
        final failure = const ChangePasswordFirebaseFailure.tooManyRequests();
        expect(failure.message, 'Demasiadas solicitudes. Intenta más tarde.');
      });

      test('should return message from GeneralBaseFailure', () {
        final generalFailure = const GeneralBaseFailure.networkError();
        final failure = ChangePasswordFirebaseFailure.general(generalFailure);
        expect(failure.message, generalFailure.message);
      });
    });

    group('Get TypeError', () {
      test('should return correct typeError for wrongPassword', () {
        final failure = const ChangePasswordFirebaseFailure.wrongPassword();
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureWrongPassword>(),
        );
      });

      test('should return correct typeError for invalidCredential', () {
        final failure = const ChangePasswordFirebaseFailure.invalidCredential();
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureInvalidCredential>(),
        );
      });

      test('should return correct typeError for invalidArgument', () {
        final failure = const ChangePasswordFirebaseFailure.invalidArgument();
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureInvalidArgument>(),
        );
      });

      test('should return correct typeError for tooManyRequests', () {
        final failure = const ChangePasswordFirebaseFailure.tooManyRequests();
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureTooManyRequests>(),
        );
      });

      test('should return GeneralBaseFailure for unknown error', () {
        final failure = ChangePasswordFirebaseFailure.fromString('unknown');
        expect(failure.typeError, isA<GeneralBaseFailure>());
      });
    });

    group('FromString', () {
      test('should return wrongPassword failure from string', () {
        final failure = ChangePasswordFirebaseFailure.fromString(
          'wrongPassword',
        );
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureWrongPassword>(),
        );
      });

      test('should return invalidCredential failure from string', () {
        final failure = ChangePasswordFirebaseFailure.fromString(
          'invalidCredential',
        );
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureInvalidCredential>(),
        );
      });

      test('should return invalidArgument failure from string', () {
        final failure = ChangePasswordFirebaseFailure.fromString(
          'invalidArgument',
        );
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureInvalidArgument>(),
        );
      });

      test('should return tooManyRequests failure from string', () {
        final failure = ChangePasswordFirebaseFailure.fromString(
          'tooManyRequests',
        );
        expect(
          failure.typeError,
          isA<ChangePasswordFirebaseFailureTooManyRequests>(),
        );
      });

      test('should return GeneralBaseFailure for unknown error code', () {
        final failure = ChangePasswordFirebaseFailure.fromString('unknown');
        expect(failure.typeError, isA<GeneralBaseFailure>());
      });
    });
  });
}
