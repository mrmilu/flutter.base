import 'package:flutter_base/src/shared/domain/failures/endpoints/unions/app_error.dart';
import 'package:flutter_base/src/shared/domain/failures/endpoints/unions/user_endpoint_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEndpointError Tests', () {
    group('Factory Constructors', () {
      test('should create userNotFound error with default message', () {
        // Act
        final error = const UserEndpointError.userNotFound();

        // Assert - Verificar usando when()
        final message = error.when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, 'Usuario no encontrado.');
      });

      test('should create userNotFound error with custom message', () {
        // Arrange
        const customMessage =
            'El usuario especificado no existe en el sistema.';

        // Act
        final error = const UserEndpointError.userNotFound(
          message: customMessage,
        );

        // Assert
        final message = error.when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, customMessage);
      });

      test('should create userInvalid error with default message', () {
        // Act
        final error = const UserEndpointError.userInvalid();

        // Assert
        final message = error.when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, 'Usuario inválido.');
      });

      test('should create userInvalid error with custom message', () {
        // Arrange
        const customMessage = 'Los datos del usuario no son válidos.';

        // Act
        final error = const UserEndpointError.userInvalid(
          message: customMessage,
        );

        // Assert
        final message = error.when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, customMessage);
      });

      test('should create general error with AppBaseError', () {
        // Arrange
        final appError = const AppBaseError.unauthorized(
          message: 'Token expired',
        );

        // Act
        final error = UserEndpointError.general(appError);

        // Assert
        final retrievedAppError = error.when(
          userNotFound: (msg) => null,
          userInvalid: (msg) => null,
          general: (appError) => appError,
        );

        expect(retrievedAppError, appError);
      });
    });

    group('Pattern Matching with when()', () {
      test('should handle userNotFound with when()', () {
        // Arrange
        final error = const UserEndpointError.userNotFound(
          message: 'Test user not found',
        );

        // Act
        final result = error.when(
          userNotFound: (message) => 'NOT_FOUND: $message',
          userInvalid: (message) => 'INVALID: $message',
          general: (appError) => 'GENERAL: ${appError.message}',
        );

        // Assert
        expect(result, 'NOT_FOUND: Test user not found');
      });

      test('should handle userInvalid with when()', () {
        // Arrange
        final error = const UserEndpointError.userInvalid(
          message: 'Test user invalid',
        );

        // Act
        final result = error.when(
          userNotFound: (message) => 'NOT_FOUND: $message',
          userInvalid: (message) => 'INVALID: $message',
          general: (appError) => 'GENERAL: ${appError.message}',
        );

        // Assert
        expect(result, 'INVALID: Test user invalid');
      });

      test('should handle general error with when()', () {
        // Arrange
        final appError = const AppBaseError.networkError(
          message: 'Connection failed',
        );
        final error = UserEndpointError.general(appError);

        // Act
        final result = error.when(
          userNotFound: (message) => 'NOT_FOUND: $message',
          userInvalid: (message) => 'INVALID: $message',
          general: (appError) => 'GENERAL: ${appError.message}',
        );

        // Assert
        expect(result, 'GENERAL: Connection failed');
      });

      test('should handle all error types with when()', () {
        // Arrange
        final errors = [
          const UserEndpointError.userNotFound(message: 'User not found'),
          const UserEndpointError.userInvalid(message: 'User invalid'),
          const UserEndpointError.general(
            AppBaseError.unauthorized(message: 'Unauthorized'),
          ),
          const UserEndpointError.general(
            AppBaseError.internalError(message: 'Internal error'),
          ),
        ];

        final expectedResults = [
          'NOT_FOUND: User not found',
          'INVALID: User invalid',
          'GENERAL: Unauthorized',
          'GENERAL: Internal error',
        ];

        // Act & Assert
        for (int i = 0; i < errors.length; i++) {
          final result = errors[i].when(
            userNotFound: (msg) => 'NOT_FOUND: $msg',
            userInvalid: (msg) => 'INVALID: $msg',
            general: (appError) => 'GENERAL: ${appError.message}',
          );

          expect(result, expectedResults[i]);
        }
      });
    });

    group('Pattern Matching with map()', () {
      test('should handle all cases with map()', () {
        // Arrange
        final errors = [
          const UserEndpointError.userNotFound(message: 'User not found'),
          const UserEndpointError.userInvalid(message: 'User invalid'),
          const UserEndpointError.general(
            AppBaseError.networkError(message: 'Network error'),
          ),
        ];

        // Act & Assert
        for (final error in errors) {
          final result = error.map(
            userNotFound: (e) => 'NOT_FOUND: ${e.message}',
            userInvalid: (e) => 'INVALID: ${e.message}',
            general: (e) => 'GENERAL: ${e.error.message}',
          );

          expect(result, isA<String>());
          expect(result, isNotEmpty);
        }
      });
    });

    group('Equality', () {
      test('should be equal when same type and message', () {
        // Arrange
        final error1 = const UserEndpointError.userNotFound();
        final error2 = const UserEndpointError.userNotFound();

        // Assert
        expect(error1, equals(error2));
        expect(error1.hashCode, equals(error2.hashCode));
      });

      test('should be equal for general errors with same AppBaseError', () {
        // Arrange
        final appError = const AppBaseError.unauthorized();
        final error1 = UserEndpointError.general(appError);
        final error2 = UserEndpointError.general(appError);

        // Assert
        expect(error1, equals(error2));
        expect(error1.hashCode, equals(error2.hashCode));
      });

      test('should not be equal when different types', () {
        // Arrange
        final error1 = const UserEndpointError.userNotFound();
        final error2 = const UserEndpointError.userInvalid();

        // Assert
        expect(error1, isNot(equals(error2)));
      });

      test('should not be equal when same type but different messages', () {
        // Arrange
        final error1 = const UserEndpointError.userNotFound(
          message: 'Message 1',
        );
        final error2 = const UserEndpointError.userNotFound(
          message: 'Message 2',
        );

        // Assert
        expect(error1, isNot(equals(error2)));
      });

      test(
        'should not be equal for general errors with different AppBaseError',
        () {
          // Arrange
          final error1 = const UserEndpointError.general(
            AppBaseError.unauthorized(),
          );
          final error2 = const UserEndpointError.general(
            AppBaseError.networkError(),
          );

          // Assert
          expect(error1, isNot(equals(error2)));
        },
      );
    });

    group('toString() Method', () {
      test(
        'should return meaningful string representation for userNotFound',
        () {
          // Arrange
          final error = const UserEndpointError.userNotFound();

          // Act
          final stringRepr = error.toString();

          // Assert
          expect(stringRepr, contains('userNotFound'));
        },
      );

      test(
        'should return meaningful string representation for general error',
        () {
          // Arrange
          final appError = const AppBaseError.unauthorized();
          final error = UserEndpointError.general(appError);

          // Act
          final stringRepr = error.toString();

          // Assert
          expect(stringRepr, contains('general'));
        },
      );
    });

    group('General Error Integration', () {
      test('should properly wrap different types of AppBaseError', () {
        // Arrange
        final appErrors = [
          const AppBaseError.unauthorized(message: 'Auth error'),
          const AppBaseError.internalError(message: 'Server error'),
          const AppBaseError.networkError(message: 'Network error'),
          const AppBaseError.timeoutError(message: 'Timeout error'),
          const AppBaseError.invalidResponseFormat(message: 'Format error'),
          const AppBaseError.unexpectedError(message: 'Unexpected error'),
        ];

        // Act & Assert
        for (final appError in appErrors) {
          final userError = UserEndpointError.general(appError);

          // Verificar que el AppBaseError se puede extraer
          final retrievedAppError = userError.when(
            userNotFound: (msg) => null,
            userInvalid: (msg) => null,
            general: (err) => err,
          );

          expect(retrievedAppError, appError);
          expect(retrievedAppError?.message, appError.message);

          // Verify pattern matching works
          final result = userError.when(
            userNotFound: (msg) => 'NOT_FOUND',
            userInvalid: (msg) => 'INVALID',
            general: (err) => 'GENERAL: ${err.message}',
          );

          expect(result, 'GENERAL: ${appError.message}');
        }
      });

      test('should demonstrate .general usage pattern', () {
        // Arrange - Simular errores comunes en endpoints
        final networkError = const UserEndpointError.general(
          AppBaseError.networkError(),
        );
        final authError = const UserEndpointError.general(
          AppBaseError.unauthorized(),
        );
        final serverError = const UserEndpointError.general(
          AppBaseError.internalError(),
        );

        // Act & Assert - Verificar que todos se manejan consistentemente
        final errors = [networkError, authError, serverError];

        for (final error in errors) {
          final isGeneralError = error.when(
            userNotFound: (msg) => false,
            userInvalid: (msg) => false,
            general: (appError) => true,
          );

          expect(isGeneralError, true);
        }
      });
    });

    group('Edge Cases', () {
      test('should handle empty string message', () {
        // Act
        final error = const UserEndpointError.userNotFound(message: '');

        // Assert
        final message = error.when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, '');
      });

      test('should handle special characters in message', () {
        // Arrange
        const specialMessage = 'Usuario: áéíóú ñ ¿¡ 中文 🚀 @#\$%^&*()';

        // Act
        final error = const UserEndpointError.userInvalid(
          message: specialMessage,
        );

        // Assert
        final message = error.when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, specialMessage);
      });

      test('should handle nested AppBaseError with custom message', () {
        // Arrange
        const customAppMessage = 'Custom network error message';
        final appError = const AppBaseError.networkError(
          message: customAppMessage,
        );
        final error = UserEndpointError.general(appError);

        // Act & Assert
        final retrievedMessage = error.when(
          userNotFound: (msg) => 'NOT_FOUND',
          userInvalid: (msg) => 'INVALID',
          general: (appErr) => appErr.message,
        );

        expect(retrievedMessage, customAppMessage);
      });
    });

    group('Default Message Validation', () {
      test('should have correct default messages', () {
        // Test userNotFound default message
        final userNotFoundMessage = const UserEndpointError.userNotFound().when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(userNotFoundMessage, 'Usuario no encontrado.');

        // Test userInvalid default message
        final userInvalidMessage = const UserEndpointError.userInvalid().when(
          userNotFound: (msg) => msg,
          userInvalid: (msg) => msg,
          general: (appError) => appError.message,
        );

        expect(userInvalidMessage, 'Usuario inválido.');
      });
    });

    group('Type Safety', () {
      test('should ensure exhaustive pattern matching', () {
        // Arrange
        final errors = [
          const UserEndpointError.userNotFound(),
          const UserEndpointError.userInvalid(),
          const UserEndpointError.general(AppBaseError.unauthorized()),
        ];

        // Act & Assert
        for (final error in errors) {
          // Este test verifica que when() requiere manejar todos los casos
          final result = error.when(
            userNotFound: (msg) => 'userNotFound',
            userInvalid: (msg) => 'userInvalid',
            general: (appError) => 'general',
          );

          expect(result, isA<String>());
          expect(
            ['userNotFound', 'userInvalid', 'general'].contains(result),
            true,
          );
        }
      });
    });
  });
}
