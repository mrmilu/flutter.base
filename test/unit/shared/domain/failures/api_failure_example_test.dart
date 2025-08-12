import 'package:flutter_base/src/shared/domain/failures/api_failure_example.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiFailure', () {
    group('fromCode factory', () {
      test('Debería crear ApiFailureUnauthorized desde código AUTH_001', () {
        // Act
        final failure = ApiFailure.fromCode('AUTH_001');

        // Assert
        expect(failure, isA<ApiFailureUnauthorized>());
        expect(failure.code, equals('AUTH_001'));
        expect(
          failure.message,
          equals('No autorizado para realizar esta acción'),
        );
      });

      test(
        'Debería crear ApiFailureUnauthorized desde código UNAUTHORIZED',
        () {
          // Act
          final failure = ApiFailure.fromCode('UNAUTHORIZED');

          // Assert
          expect(failure, isA<ApiFailureUnauthorized>());
          expect(failure.code, equals('AUTH_001'));
        },
      );

      test('Debería crear ApiFailureUnknown para código no reconocido', () {
        // Act
        final failure = ApiFailure.fromCode('CUSTOM_ERROR_123');

        // Assert
        expect(failure, isA<ApiFailureUnknown>());
        expect((failure as ApiFailureUnknown).code, equals('CUSTOM_ERROR_123'));
        expect(failure.message, equals('Error desconocido: CUSTOM_ERROR_123'));
      });

      test('Debería usar mensaje personalizado cuando se proporciona', () {
        // Act
        final failure = ApiFailure.fromCode(
          'AUTH_001',
          message: 'Mensaje personalizado desde API',
        );

        // Assert
        expect(failure, isA<ApiFailureUnauthorized>());
        expect(failure.message, equals('Mensaje personalizado desde API'));
        expect(
          failure.defaultMessage,
          equals('No autorizado para realizar esta acción'),
        );
      });
    });

    group('fromJson factory', () {
      test('Debería crear failure desde JSON con code y message', () {
        // Arrange
        final json = {
          'code': 'SERVER_001',
          'message': 'Error específico del servidor',
        };

        // Act
        final failure = ApiFailure.fromJson(json);

        // Assert
        expect(failure, isA<ApiFailureServerError>());
        expect(failure.code, equals('SERVER_001'));
        expect(failure.message, equals('Error específico del servidor'));
      });

      test(
        'Debería crear failure desde JSON con error_code y error_message',
        () {
          // Arrange
          final json = {
            'error_code': 'VALIDATION_001',
            'error_message': 'Datos inválidos proporcionados',
          };

          // Act
          final failure = ApiFailure.fromJson(json);

          // Assert
          expect(failure, isA<ApiFailureValidation>());
          expect(failure.code, equals('VALIDATION_001'));
          expect(failure.message, equals('Datos inválidos proporcionados'));
        },
      );

      test('Debería crear ApiFailureUnknown para JSON sin code', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final failure = ApiFailure.fromJson(json);

        // Assert
        expect(failure, isA<ApiFailureUnknown>());
        expect((failure as ApiFailureUnknown).code, equals('UNKNOWN'));
      });
    });

    group('Pattern matching exhaustivo', () {
      test('Debería manejar todos los casos en switch', () {
        // Arrange
        final failures = [
          ApiFailure.fromCode('AUTH_001'),
          ApiFailure.fromCode('AUTH_002'),
          ApiFailure.fromCode('AUTH_003'),
          ApiFailure.fromCode('VALIDATION_001'),
          ApiFailure.fromCode('VALIDATION_002'),
          ApiFailure.fromCode('SERVER_001'),
          ApiFailure.fromCode('SERVER_002'),
          ApiFailure.fromCode('NETWORK_001'),
          ApiFailure.fromCode('NETWORK_002'),
          ApiFailure.fromCode('RATE_LIMIT'),
          ApiFailure.fromCode('UNKNOWN_CODE'),
        ];

        // Act & Assert
        for (final failure in failures) {
          final result = switch (failure) {
            ApiFailureUnauthorized() => 'unauthorized',
            ApiFailureInvalidToken() => 'invalid_token',
            ApiFailureTokenExpired() => 'token_expired',
            ApiFailureValidation() => 'validation',
            ApiFailureRequiredField() => 'required_field',
            ApiFailureServerError() => 'server_error',
            ApiFailureServiceUnavailable() => 'service_unavailable',
            ApiFailureNetworkTimeout() => 'network_timeout',
            ApiFailureNoInternet() => 'no_internet',
            ApiFailureRateLimit() => 'rate_limit',
            ApiFailureUnknown() => 'unknown',
          };

          expect(result, isA<String>());
        }
      });
    });

    group('Mensajes', () {
      test('Debería usar mensaje por defecto cuando no hay customMessage', () {
        // Act
        final failure = ApiFailure.fromCode('AUTH_001');

        // Assert
        expect(failure.customMessage, isNull);
        expect(
          failure.message,
          equals('No autorizado para realizar esta acción'),
        );
        expect(
          failure.defaultMessage,
          equals('No autorizado para realizar esta acción'),
        );
      });

      test('Debería usar customMessage cuando está disponible', () {
        // Act
        final failure = ApiFailure.fromCode(
          'AUTH_001',
          message: 'Mensaje personalizado',
        );

        // Assert
        expect(failure.customMessage, equals('Mensaje personalizado'));
        expect(failure.message, equals('Mensaje personalizado'));
        expect(
          failure.defaultMessage,
          equals('No autorizado para realizar esta acción'),
        );
      });
    });

    group('Códigos', () {
      test('Debería mapear correctamente todos los códigos', () {
        // Arrange
        final testCases = {
          'AUTH_001': ApiFailureUnauthorized,
          'AUTH_002': ApiFailureInvalidToken,
          'AUTH_003': ApiFailureTokenExpired,
          'VALIDATION_001': ApiFailureValidation,
          'VALIDATION_002': ApiFailureRequiredField,
          'SERVER_001': ApiFailureServerError,
          'SERVER_002': ApiFailureServiceUnavailable,
          'NETWORK_001': ApiFailureNetworkTimeout,
          'NETWORK_002': ApiFailureNoInternet,
          'RATE_LIMIT': ApiFailureRateLimit,
        };

        // Act & Assert
        testCases.forEach((code, expectedType) {
          final failure = ApiFailure.fromCode(code);
          expect(failure.runtimeType, equals(expectedType));
          expect(failure.code, equals(code));
        });
      });

      test('Debería manejar códigos alternativos', () {
        // Arrange
        final alternativeCodes = {
          'UNAUTHORIZED': ApiFailureUnauthorized,
          'INVALID_TOKEN': ApiFailureInvalidToken,
          'TOKEN_EXPIRED': ApiFailureTokenExpired,
          'INVALID_DATA': ApiFailureValidation,
          'REQUIRED_FIELD': ApiFailureRequiredField,
        };

        // Act & Assert
        alternativeCodes.forEach((code, expectedType) {
          final failure = ApiFailure.fromCode(code);
          expect(failure.runtimeType, equals(expectedType));
        });
      });

      test('Debería retornar código personalizado para ApiFailureUnknown', () {
        // Arrange
        const customCode = 'CUSTOM_ERROR_123';
        final failure = ApiFailure.fromCode(customCode);

        // Act - Esto específicamente testa la línea: ApiFailureUnknown(code: final code) => code,
        final resultCode = failure.code;

        // Assert
        expect(failure, isA<ApiFailureUnknown>());
        expect(resultCode, equals(customCode));
        expect((failure as ApiFailureUnknown).code, equals(customCode));
      });

      test(
        'Debería ejecutar getter code para ApiFailureUnknown mediante polimorfismo',
        () {
          // Arrange
          const customCode = 'POLYMORPHIC_TEST_456';

          // Crear como ApiFailure (polimorfismo) no como ApiFailureUnknown directamente
          final ApiFailure failure = ApiFailure.fromCode(customCode);

          // Act - Esto fuerza el uso del getter code del switch en la clase base
          final String resultCode = failure.code; // Acceso polimórfico

          // Assert
          expect(failure, isA<ApiFailureUnknown>());
          expect(resultCode, equals(customCode));

          // Verificar que el switch pattern matching funciona correctamente
          final codeFromSwitch = switch (failure) {
            ApiFailureUnknown(code: final code) => code,
            _ => 'not_unknown',
          };
          expect(codeFromSwitch, equals(customCode));
        },
      );

      test(
        'Debería cubrir línea específica del switch para ApiFailureUnknown.code',
        () {
          // Arrange
          const testCode = 'COVERAGE_TEST_789';

          // Crear directamente una instancia de ApiFailureUnknown
          const failure = ApiFailureUnknown(newCode: testCode);

          // Act - Llamar al getter code que contiene el switch
          final resultCode = failure.code;

          // Assert - Verificar que la línea específica del switch se ejecuta
          expect(resultCode, equals(testCode));

          // Verificar también que funciona a través de polimorfismo
          const ApiFailure polymorphicFailure = failure;
          expect(polymorphicFailure.code, equals(testCode));
        },
      );

      test('Debería probar exhaustivamente la línea específica del switch', () {
        // Test múltiples códigos para ApiFailureUnknown para asegurar cobertura
        final testCodes = ['CODE_1', 'CODE_2', 'SPECIAL_ERROR', ''];

        for (final testCode in testCodes) {
          // Arrange
          final failure = ApiFailure.fromCode(testCode);

          // Act - Ejecutar el getter code del switch múltiples veces
          final code1 = failure.code;

          // Assert
          expect(code1, equals(testCode));

          // También probar con el defaultMessage que usa el código
          final message = failure.defaultMessage;
          expect(message, equals('Error desconocido: $testCode'));
        }
      });

      test('Debería cubrir específicamente la línea con sintaxis codeDos', () {
        // Arrange - Crear una instancia específica para la nueva sintaxis
        const testCode = 'SYNTAX_TEST_CODEODOS';
        const failure = ApiFailureUnknown(newCode: testCode);

        // Act - Ejecutar el getter que usa la sintaxis: ApiFailureUnknown(code: String codeDos) => codeDos,
        final resultCode = failure.code;

        // Assert
        expect(resultCode, equals(testCode));

        // Verificar mediante pattern matching que funciona la nueva sintaxis
        final extractedCode = switch (failure) {
          ApiFailureUnknown(code: String codeDos) => codeDos,
        };
        expect(extractedCode, equals(testCode));

        // Verificar polimorfismo
        const ApiFailure polymorphic = failure;
        expect(polymorphic.code, equals(testCode));
      });
    });

    group('Serialización', () {
      test('Debería serializar a JSON correctamente', () {
        // Arrange
        final failure = ApiFailure.fromCode(
          'AUTH_001',
          message: 'Mensaje personalizado',
        );

        // Act
        final json = failure.toJson();

        // Assert
        expect(json, {
          'code': 'AUTH_001',
          'message': 'Mensaje personalizado',
          'type': 'ApiFailureUnauthorized',
        });
      });

      test(
        'Debería usar mensaje por defecto en JSON si no hay customMessage',
        () {
          // Arrange
          final failure = ApiFailure.fromCode('SERVER_001');

          // Act
          final json = failure.toJson();

          // Assert
          expect(json, {
            'code': 'SERVER_001',
            'message': 'Error interno del servidor',
            'type': 'ApiFailureServerError',
          });
        },
      );
    });

    group('toString', () {
      test('Debería tener representación string correcta', () {
        // Arrange
        final failure = ApiFailure.fromCode(
          'AUTH_001',
          message: 'Test message',
        );

        // Act
        final result = failure.toString();

        // Assert
        expect(
          result,
          equals('ApiFailure(code: AUTH_001, message: Test message)'),
        );
      });
    });

    group('Casos edge', () {
      test('Debería manejar ApiFailureUnknown con código personalizado', () {
        // Act
        final failure = ApiFailure.fromCode('CUSTOM_API_ERROR_999');

        // Assert
        expect(failure, isA<ApiFailureUnknown>());
        expect(
          (failure as ApiFailureUnknown).code,
          equals('CUSTOM_API_ERROR_999'),
        );
        expect(
          failure.message,
          equals('Error desconocido: CUSTOM_API_ERROR_999'),
        );
      });

      test('Debería manejar JSON vacío', () {
        // Act
        final failure = ApiFailure.fromJson({});

        // Assert
        expect(failure, isA<ApiFailureUnknown>());
        expect((failure as ApiFailureUnknown).code, equals('UNKNOWN'));
      });

      test('Debería manejar mensaje null en customMessage', () {
        // Act
        final failure = ApiFailure.fromCode('AUTH_001', message: null);

        // Assert
        expect(failure.customMessage, isNull);
        expect(
          failure.message,
          equals('No autorizado para realizar esta acción'),
        );
      });
    });

    group('Equality y hashCode', () {
      test(
        'Debería considerar iguales instancias del mismo tipo sin datos',
        () {
          // Arrange
          final failure1 = ApiFailure.fromCode('AUTH_001');
          final failure2 = ApiFailure.fromCode('AUTH_001');

          // Assert
          expect(failure1.runtimeType, equals(failure2.runtimeType));
          expect(failure1.code, equals(failure2.code));
        },
      );

      test(
        'Debería considerar diferentes instancias con diferentes mensajes',
        () {
          // Arrange
          final failure1 = ApiFailure.fromCode(
            'AUTH_001',
            message: 'Mensaje 1',
          );
          final failure2 = ApiFailure.fromCode(
            'AUTH_001',
            message: 'Mensaje 2',
          );

          // Assert
          expect(failure1.runtimeType, equals(failure2.runtimeType));
          expect(failure1.message, isNot(equals(failure2.message)));
        },
      );
    });
  });
}
