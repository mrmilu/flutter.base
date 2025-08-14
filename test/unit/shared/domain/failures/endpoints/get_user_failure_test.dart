import 'package:flutter_base/src/shared/domain/failures/endpoints/general_base_failure.dart';
import 'package:flutter_base/src/shared/domain/failures/endpoints/get_user_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GetUserFailure Tests', () {
    group('Factory Constructors', () {
      test('should create userNotFound error with default message', () {
        // Act
        final error = const GetUserFailure.userNotFound();

        // Assert - Verificar usando when()
        final message = error.when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, 'Usuario no encontrado.');
      });

      test('should create userNotFound error with custom message', () {
        // Arrange
        const customMessage =
            'El usuario especificado no existe en el sistema.';

        // Act
        final error = const GetUserFailure.userNotFound(
          msg: customMessage,
        );

        // Assert
        final message = error.when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, customMessage);
      });

      test('should create userInvalid error with default message', () {
        // Act
        final error = const GetUserFailure.userInvalid();

        // Assert
        final message = error.when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, 'Usuario inválido.');
      });

      test('should create userInvalid error with custom message', () {
        // Arrange
        const customMessage = 'Los datos del usuario no son válidos.';

        // Act
        final error = const GetUserFailure.userInvalid(
          msg: customMessage,
        );

        // Assert
        final message = error.when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, customMessage);
      });

      test('should create general error with GeneralBaseFailure', () {
        // Arrange
        final appError = const GeneralBaseFailure.unauthorized(
          message: 'Token expired',
        );

        // Act
        final error = GetUserFailure.general(appError);

        // Assert
        final retrievedAppError = error.when(
          userNotFound: (code, msg) => null,
          userInvalid: (code, msg) => null,
          general: (appError) => appError,
        );

        expect(retrievedAppError, appError);
      });
    });

    group('Pattern Matching with when()', () {
      test('should handle userNotFound with when()', () {
        // Arrange
        final error = const GetUserFailure.userNotFound(
          msg: 'Test user not found',
        );

        // Act
        final result = error.when(
          userNotFound: (code, message) => 'NOT_FOUND: $message',
          userInvalid: (code, message) => 'INVALID: $message',
          general: (appError) => 'GENERAL: ${appError.message}',
        );

        // Assert
        expect(result, 'NOT_FOUND: Test user not found');
      });

      test('should handle userInvalid with when()', () {
        // Arrange
        final error = const GetUserFailure.userInvalid(
          msg: 'Test user invalid',
        );

        // Act
        final result = error.when(
          userNotFound: (code, msg) => 'NOT_FOUND: $msg',
          userInvalid: (code, msg) => 'INVALID: $msg',
          general: (appError) => 'GENERAL: ${appError.message}',
        );

        // Assert
        expect(result, 'INVALID: Test user invalid');
      });

      test('should handle general error with when()', () {
        // Arrange
        final appError = const GeneralBaseFailure.networkError(
          message: 'Connection failed',
        );
        final error = GetUserFailure.general(appError);

        // Act
        final result = error.when(
          userNotFound: (code, message) => 'NOT_FOUND: $message',
          userInvalid: (code, message) => 'INVALID: $message',
          general: (appError) => 'GENERAL: ${appError.message}',
        );

        // Assert
        expect(result, 'GENERAL: Connection failed');
      });

      test('should handle all error types with when()', () {
        // Arrange
        final errors = [
          const GetUserFailure.userNotFound(msg: 'User not found'),
          const GetUserFailure.userInvalid(msg: 'User invalid'),
          const GetUserFailure.general(
            GeneralBaseFailure.unauthorized(message: 'Unauthorized'),
          ),
          const GetUserFailure.general(
            GeneralBaseFailure.internalError(message: 'Internal error'),
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
            userNotFound: (code, msg) => 'NOT_FOUND: $msg',
            userInvalid: (code, msg) => 'INVALID: $msg',
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
          const GetUserFailure.userNotFound(msg: 'User not found'),
          const GetUserFailure.userInvalid(msg: 'User invalid'),
          const GetUserFailure.general(
            GeneralBaseFailure.networkError(message: 'Network error'),
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
        final error1 = const GetUserFailure.userNotFound();
        final error2 = const GetUserFailure.userNotFound();

        // Assert
        expect(error1, equals(error2));
        expect(error1.hashCode, equals(error2.hashCode));
      });

      test(
        'should be equal for general errors with same GeneralBaseFailure',
        () {
          // Arrange
          final appError = const GeneralBaseFailure.unauthorized();
          final error1 = GetUserFailure.general(appError);
          final error2 = GetUserFailure.general(appError);

          // Assert
          expect(error1, equals(error2));
          expect(error1.hashCode, equals(error2.hashCode));
        },
      );

      test('should not be equal when different types', () {
        // Arrange
        final error1 = const GetUserFailure.userNotFound();
        final error2 = const GetUserFailure.userInvalid();

        // Assert
        expect(error1, isNot(equals(error2)));
      });

      test('should not be equal when same type but different messages', () {
        // Arrange
        final error1 = const GetUserFailure.userNotFound(
          msg: 'Message 1',
        );
        final error2 = const GetUserFailure.userNotFound(
          msg: 'Message 2',
        );

        // Assert
        expect(error1, isNot(equals(error2)));
      });

      test(
        'should not be equal for general errors with different GeneralBaseFailure',
        () {
          // Arrange
          final error1 = const GetUserFailure.general(
            GeneralBaseFailure.unauthorized(),
          );
          final error2 = const GetUserFailure.general(
            GeneralBaseFailure.networkError(),
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
          final error = const GetUserFailure.userNotFound();

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
          final appError = const GeneralBaseFailure.unauthorized();
          final error = GetUserFailure.general(appError);

          // Act
          final stringRepr = error.toString();

          // Assert
          expect(stringRepr, contains('general'));
        },
      );
    });

    group('General Error Integration', () {
      test('should properly wrap different types of GeneralBaseFailure', () {
        // Arrange
        final appErrors = [
          const GeneralBaseFailure.unauthorized(message: 'Auth error'),
          const GeneralBaseFailure.internalError(message: 'Server error'),
          const GeneralBaseFailure.networkError(message: 'Network error'),
          const GeneralBaseFailure.timeoutError(message: 'Timeout error'),
          const GeneralBaseFailure.invalidResponseFormat(
            message: 'Format error',
          ),
          const GeneralBaseFailure.unexpectedError(
            code: 'code_test',
            message: 'Unexpected error',
          ),
        ];

        // Act & Assert
        for (final appError in appErrors) {
          final userError = GetUserFailure.general(appError);

          // Verificar que el GeneralBaseFailure se puede extraer
          final retrievedAppError = userError.when(
            userNotFound: (code, msg) => null,
            userInvalid: (code, msg) => null,
            general: (err) => err,
          );

          expect(retrievedAppError, appError);
          expect(retrievedAppError?.message, appError.message);

          // Verify pattern matching works
          final result = userError.when(
            userNotFound: (code, msg) => 'NOT_FOUND: $msg',
            userInvalid: (code, msg) => 'INVALID: $msg',
            general: (err) => 'GENERAL: ${err.message}',
          );

          expect(result, 'GENERAL: ${appError.message}');
        }
      });

      test('should demonstrate .general usage pattern', () {
        // Arrange - Simular errores comunes en endpoints
        final networkError = const GetUserFailure.general(
          GeneralBaseFailure.networkError(),
        );
        final authError = const GetUserFailure.general(
          GeneralBaseFailure.unauthorized(),
        );
        final serverError = const GetUserFailure.general(
          GeneralBaseFailure.internalError(),
        );

        // Act & Assert - Verificar que todos se manejan consistentemente
        final errors = [networkError, authError, serverError];

        for (final error in errors) {
          final isGeneralError = error.when(
            userNotFound: (code, msg) => false,
            userInvalid: (code, msg) => false,
            general: (appError) => true,
          );

          expect(isGeneralError, true);
        }
      });
    });

    group('Edge Cases', () {
      test('should handle empty string message', () {
        // Act
        final error = const GetUserFailure.userNotFound(msg: '');

        // Assert
        final message = error.when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, '');
      });

      test('should handle special characters in message', () {
        // Arrange
        const specialMessage = 'Usuario: áéíóú ñ ¿¡ 中文 🚀 @#\$%^&*()';

        // Act
        final error = const GetUserFailure.userInvalid(
          msg: specialMessage,
        );

        // Assert
        final message = error.when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(message, specialMessage);
      });

      test('should handle nested GeneralBaseFailure with custom message', () {
        // Arrange
        const customAppMessage = 'Custom network error message';
        final appError = const GeneralBaseFailure.networkError(
          message: customAppMessage,
        );
        final error = GetUserFailure.general(appError);

        // Act & Assert
        final retrievedMessage = error.when(
          userNotFound: (code, msg) => 'NOT_FOUND: $msg',
          userInvalid: (code, msg) => 'INVALID: $msg',
          general: (appErr) => appErr.message,
        );

        expect(retrievedMessage, customAppMessage);
      });
    });

    group('Default Message Validation', () {
      test('should have correct default messages', () {
        // Test userNotFound default message
        final userNotFoundMessage = const GetUserFailure.userNotFound().when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(userNotFoundMessage, 'Usuario no encontrado.');

        // Test userInvalid default message
        final userInvalidMessage = const GetUserFailure.userInvalid().when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(userInvalidMessage, 'Usuario inválido.');
      });
    });

    group('Type Safety', () {
      test('should ensure exhaustive pattern matching', () {
        // Arrange
        final errors = [
          const GetUserFailure.userNotFound(),
          const GetUserFailure.userInvalid(),
          const GetUserFailure.general(GeneralBaseFailure.unauthorized()),
        ];

        // Act & Assert
        for (final error in errors) {
          // Este test verifica que when() requiere manejar todos los casos
          final result = error.when(
            userNotFound: (code, msg) => code,
            userInvalid: (code, msg) => code,
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

    // Tests para el getter message que falta en la cobertura
    group('Message Getter', () {
      test('should return correct message for userNotFound via getter', () {
        // Arrange
        const customMessage = 'Custom not found message';
        final error = const GetUserFailure.userNotFound(msg: customMessage);

        // Act - Usar el getter message directamente
        final message = error.message;

        // Assert
        expect(message, customMessage);
      });

      test('should return correct message for userInvalid via getter', () {
        // Arrange
        const customMessage = 'Custom invalid message';
        final error = const GetUserFailure.userInvalid(msg: customMessage);

        // Act - Usar el getter message directamente
        final message = error.message;

        // Assert
        expect(message, customMessage);
      });

      test('should return correct message for general error via getter', () {
        // Arrange
        const appErrorMessage = 'Network connection failed';
        final appError = const GeneralBaseFailure.networkError(
          message: appErrorMessage,
        );
        final error = GetUserFailure.general(appError);

        // Act - Usar el getter message directamente
        final message = error.message;

        // Assert
        expect(message, appErrorMessage);
      });

      test('should return default messages via getter', () {
        // Test default messages using getter
        expect(
          const GetUserFailure.userNotFound().message,
          'Usuario no encontrado.',
        );
        expect(const GetUserFailure.userInvalid().message, 'Usuario inválido.');
      });

      test('should execute userNotFound branch in message getter when()', () {
        // Arrange - Crear específicamente userNotFound
        const customMessage = 'Specific userNotFound message';
        final error = const GetUserFailure.userNotFound(msg: customMessage);

        // Act - Llamar al getter message que internamente usa when()
        // Esto debería ejecutar: userNotFound: (code, message) => message,
        final retrievedMessage = error.message;

        // Assert
        expect(retrievedMessage, customMessage);
        expect(error, isA<GetUserFailureUserNotFound>());
      });

      test('should execute userInvalid branch in message getter when()', () {
        // Arrange - Crear específicamente userInvalid
        const customMessage = 'Specific userInvalid message';
        final error = const GetUserFailure.userInvalid(msg: customMessage);

        // Act - Llamar al getter message que internamente usa when()
        // Esto debería ejecutar: userInvalid: (code, message) => message,
        final retrievedMessage = error.message;

        // Assert
        expect(retrievedMessage, customMessage);
        expect(error, isA<GetUserFailureUserInvalid>());
      });

      test(
        'should execute all branches of message getter when() with different instances',
        () {
          // Arrange - Crear instancias de todos los tipos
          final userNotFoundError = const GetUserFailure.userNotFound(
            msg: 'UserNotFound message test',
          );
          final userInvalidError = const GetUserFailure.userInvalid(
            msg: 'UserInvalid message test',
          );
          final generalError = const GetUserFailure.general(
            GeneralBaseFailure.networkError(message: 'General message test'),
          );

          // Act & Assert - Ejecutar el getter message en cada uno
          // Esto debería ejecutar todas las ramas del when() en el getter message

          // Test userNotFound branch
          final userNotFoundMessage = userNotFoundError.message;
          expect(userNotFoundMessage, 'UserNotFound message test');

          // Test userInvalid branch
          final userInvalidMessage = userInvalidError.message;
          expect(userInvalidMessage, 'UserInvalid message test');

          // Test general branch
          final generalMessage = generalError.message;
          expect(generalMessage, 'General message test');
        },
      );
    });

    // Tests para el getter typeError que falta en la cobertura
    group('TypeError Getter', () {
      test('should return correct typeError for userNotFound', () {
        // Arrange
        const customCode = 'custom_not_found';
        const customMessage = 'Custom not found message';
        final error = const GetUserFailure.userNotFound(
          code: customCode,
          msg: customMessage,
        );

        // Act - Usar el getter typeError
        final typeError = error.typeError;
        error.message;

        // Assert
        expect(typeError, isA<GetUserFailure>());
        expect(typeError, isA<GetUserFailureUserNotFound>());

        // Verificar que mantiene los datos
        final recreatedMessage = (typeError as GetUserFailure).when(
          userNotFound: (code, msg) => msg,
          userInvalid: (code, msg) => msg,
          general: (appError) => appError.message,
        );

        expect(recreatedMessage, customMessage);
      });

      test('should return correct typeError for userInvalid', () {
        // Arrange
        const customCode = 'custom_invalid';
        const customMessage = 'Custom invalid message';
        final error = const GetUserFailure.userInvalid(
          code: customCode,
          msg: customMessage,
        );

        // Act - Usar el getter typeError
        final typeError = error.typeError;

        // Assert
        expect(typeError, isA<GetUserFailure>());
        expect(typeError, isA<GetUserFailureUserInvalid>());
      });

      test('should return correct typeError for general error', () {
        // Arrange
        final appError = const GeneralBaseFailure.unauthorized(
          message: 'Auth failed',
        );
        final error = GetUserFailure.general(appError);

        // Act - Usar el getter typeError
        final typeError = error.typeError;

        // Assert
        expect(typeError, isA<GeneralBaseFailure>());
        expect(typeError.message, 'Auth failed');
      });
    });

    // Tests para el método fromString que falta en la cobertura
    group('FromString Method', () {
      test('should create userNotFound from string with default message', () {
        // Act
        final error = GetUserFailure.fromString('userNotFound');

        // Assert
        expect(error, isA<GetUserFailureUserNotFound>());
        expect(error.message, 'Usuario no encontrado.');
      });

      test('should create userNotFound from string with custom message', () {
        // Arrange
        const customMessage = 'Custom user not found';

        // Act
        final error = GetUserFailure.fromString('userNotFound', customMessage);

        // Assert
        expect(error, isA<GetUserFailureUserNotFound>());
        expect(error.message, customMessage);
      });

      test('should create userInvalid from string with default message', () {
        // Act
        final error = GetUserFailure.fromString('userInvalid');

        // Assert
        expect(error, isA<GetUserFailureUserInvalid>());
        expect(error.message, 'Usuario inválido.');
      });

      test('should create userInvalid from string with custom message', () {
        // Arrange
        const customMessage = 'Custom user invalid';

        // Act
        final error = GetUserFailure.fromString('userInvalid', customMessage);

        // Assert
        expect(error, isA<GetUserFailureUserInvalid>());
        expect(error.message, customMessage);
      });

      test('should create general error from unknown string code', () {
        // Arrange
        const unknownCode = 'unknownError';
        const customMessage = 'Unknown error occurred';

        // Act
        final error = GetUserFailure.fromString(unknownCode, customMessage);

        // Assert
        expect(error, isA<GetUserFailureGeneral>());

        // Verificar que se creó el GeneralBaseFailure correctamente
        final generalError = error.when(
          userNotFound: (code, msg) => null,
          userInvalid: (code, msg) => null,
          general: (appError) => appError,
        );

        expect(generalError, isNotNull);
        expect(generalError!.message, customMessage);
      });

      test(
        'should create general error from unknown string without message',
        () {
          // Act
          final error = GetUserFailure.fromString('someUnknownCode');

          // Assert
          expect(error, isA<GetUserFailureGeneral>());
        },
      );

      test('should handle empty string code', () {
        // Act
        final error = GetUserFailure.fromString('');

        // Assert
        expect(error, isA<GetUserFailureGeneral>());
      });

      test('should handle all valid codes with fromString', () {
        // Arrange
        final testCases = {
          'userNotFound': GetUserFailureUserNotFound,
          'userInvalid': GetUserFailureUserInvalid,
        };

        // Act & Assert
        testCases.forEach((code, expectedType) {
          final error = GetUserFailure.fromString(code);
          expect(error.runtimeType, expectedType);
        });
      });
    });
  });
}
