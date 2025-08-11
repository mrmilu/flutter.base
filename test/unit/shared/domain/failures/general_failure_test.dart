import 'package:flutter_base/src/shared/domain/failures/general_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneralFailure', () {
    group('Enum values', () {
      test('Debería tener todos los valores esperados', () {
        // Assert
        expect(GeneralFailure.values.length, equals(4));
        expect(GeneralFailure.values, contains(GeneralFailure.noPermission));
        expect(GeneralFailure.values, contains(GeneralFailure.internalError));
        expect(GeneralFailure.values, contains(GeneralFailure.serverError));
        expect(GeneralFailure.values, contains(GeneralFailure.unknown));
      });

      test('Debería crear instancias de GeneralFailure correctamente', () {
        // Arrange & Act
        const noPermission = GeneralFailure.noPermission;
        const internalError = GeneralFailure.internalError;
        const serverError = GeneralFailure.serverError;
        const unknown = GeneralFailure.unknown;

        // Assert
        expect(noPermission, isA<GeneralFailure>());
        expect(internalError, isA<GeneralFailure>());
        expect(serverError, isA<GeneralFailure>());
        expect(unknown, isA<GeneralFailure>());
        expect(noPermission, equals(GeneralFailure.noPermission));
        expect(internalError, equals(GeneralFailure.internalError));
        expect(serverError, equals(GeneralFailure.serverError));
        expect(unknown, equals(GeneralFailure.unknown));
      });
    });

    group('map method', () {
      test('Debería mapear GeneralFailure.noPermission correctamente', () {
        // Arrange
        const failure = GeneralFailure.noPermission;

        // Act
        final result = failure.map<String>(
          noPermission: () => 'no_permission_error',
          internalError: () => 'internal_error',
          serverError: () => 'server_error',
          unknown: () => 'unknown_error',
        );

        // Assert
        expect(result, equals('no_permission_error'));
      });

      test('Debería mapear GeneralFailure.internalError correctamente', () {
        // Arrange
        const failure = GeneralFailure.internalError;

        // Act
        final result = failure.map<String>(
          noPermission: () => 'no_permission_error',
          internalError: () => 'internal_error',
          serverError: () => 'server_error',
          unknown: () => 'unknown_error',
        );

        // Assert
        expect(result, equals('internal_error'));
      });

      test('Debería mapear GeneralFailure.serverError correctamente', () {
        // Arrange
        const failure = GeneralFailure.serverError;

        // Act
        final result = failure.map<String>(
          noPermission: () => 'no_permission_error',
          internalError: () => 'internal_error',
          serverError: () => 'server_error',
          unknown: () => 'unknown_error',
        );

        // Assert
        expect(result, equals('server_error'));
      });

      test('Debería mapear GeneralFailure.unknown correctamente', () {
        // Arrange
        const failure = GeneralFailure.unknown;

        // Act
        final result = failure.map<String>(
          noPermission: () => 'no_permission_error',
          internalError: () => 'internal_error',
          serverError: () => 'server_error',
          unknown: () => 'unknown_error',
        );

        // Assert
        expect(result, equals('unknown_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        const noPermissionFailure = GeneralFailure.noPermission;
        const internalErrorFailure = GeneralFailure.internalError;
        const serverErrorFailure = GeneralFailure.serverError;
        const unknownFailure = GeneralFailure.unknown;

        // Act
        final intResult1 = noPermissionFailure.map<int>(
          noPermission: () => 1,
          internalError: () => 2,
          serverError: () => 3,
          unknown: () => 4,
        );

        final intResult2 = internalErrorFailure.map<int>(
          noPermission: () => 1,
          internalError: () => 2,
          serverError: () => 3,
          unknown: () => 4,
        );

        final intResult3 = serverErrorFailure.map<int>(
          noPermission: () => 1,
          internalError: () => 2,
          serverError: () => 3,
          unknown: () => 4,
        );

        final boolResult = unknownFailure.map<bool>(
          noPermission: () => true,
          internalError: () => false,
          serverError: () => true,
          unknown: () => false,
        );

        // Assert
        expect(intResult1, equals(1));
        expect(intResult2, equals(2));
        expect(intResult3, equals(3));
        expect(boolResult, equals(false));
      });
    });

    group('fromString method', () {
      test('Debería crear GeneralFailure.noPermission desde string', () {
        // Act
        final result = GeneralFailure.fromString('noPermission');

        // Assert
        expect(result, equals(GeneralFailure.noPermission));
      });

      test('Debería crear GeneralFailure.internalError desde string', () {
        // Act
        final result = GeneralFailure.fromString('internalError');

        // Assert
        expect(result, equals(GeneralFailure.internalError));
      });

      test('Debería crear GeneralFailure.serverError desde string', () {
        // Act
        final result = GeneralFailure.fromString('serverError');

        // Assert
        expect(result, equals(GeneralFailure.serverError));
      });

      test('Debería crear GeneralFailure.unknown desde string', () {
        // Act
        final result = GeneralFailure.fromString('unknown');

        // Assert
        expect(result, equals(GeneralFailure.unknown));
      });

      test(
        'Debería devolver GeneralFailure.unknown para string desconocido',
        () {
          // Act
          final result1 = GeneralFailure.fromString('unknownString');
          final result2 = GeneralFailure.fromString('');
          final result3 = GeneralFailure.fromString('invalid');

          // Assert
          expect(result1, equals(GeneralFailure.unknown));
          expect(result2, equals(GeneralFailure.unknown));
          expect(result3, equals(GeneralFailure.unknown));
        },
      );
    });

    group('Equality and comparison', () {
      test('Debería considerar iguales instancias del mismo valor', () {
        // Arrange
        const noPermission1 = GeneralFailure.noPermission;
        const noPermission2 = GeneralFailure.noPermission;
        const internalError = GeneralFailure.internalError;

        // Assert
        expect(noPermission1, equals(noPermission2));
        expect(noPermission1, isNot(equals(internalError)));
        expect(noPermission1.hashCode, equals(noPermission2.hashCode));
      });

      test('Debería mantener orden consistente', () {
        // Arrange
        const values = GeneralFailure.values;

        // Assert
        expect(values[0], equals(GeneralFailure.noPermission));
        expect(values[1], equals(GeneralFailure.internalError));
        expect(values[2], equals(GeneralFailure.serverError));
        expect(values[3], equals(GeneralFailure.unknown));
      });
    });

    group('String representation', () {
      test('Debería tener representación string correcta', () {
        // Arrange
        const noPermission = GeneralFailure.noPermission;
        const internalError = GeneralFailure.internalError;
        const serverError = GeneralFailure.serverError;
        const unknown = GeneralFailure.unknown;

        // Act & Assert
        expect(noPermission.toString(), equals('GeneralFailure.noPermission'));
        expect(
          internalError.toString(),
          equals('GeneralFailure.internalError'),
        );
        expect(serverError.toString(), equals('GeneralFailure.serverError'));
        expect(unknown.toString(), equals('GeneralFailure.unknown'));
      });

      test('Debería tener name property correcta', () {
        // Arrange
        const noPermission = GeneralFailure.noPermission;
        const internalError = GeneralFailure.internalError;
        const serverError = GeneralFailure.serverError;
        const unknown = GeneralFailure.unknown;

        // Act & Assert
        expect(noPermission.name, equals('noPermission'));
        expect(internalError.name, equals('internalError'));
        expect(serverError.name, equals('serverError'));
        expect(unknown.name, equals('unknown'));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los valores del enum', () {
        // Arrange
        const noPermission = GeneralFailure.noPermission;
        const internalError = GeneralFailure.internalError;
        const serverError = GeneralFailure.serverError;
        const unknown = GeneralFailure.unknown;

        // Assert
        expect(noPermission == GeneralFailure.noPermission, isTrue);
        expect(noPermission == GeneralFailure.internalError, isFalse);
        expect(noPermission == GeneralFailure.serverError, isFalse);
        expect(noPermission == GeneralFailure.unknown, isFalse);

        expect(internalError == GeneralFailure.noPermission, isFalse);
        expect(internalError == GeneralFailure.internalError, isTrue);
        expect(internalError == GeneralFailure.serverError, isFalse);
        expect(internalError == GeneralFailure.unknown, isFalse);

        expect(serverError == GeneralFailure.noPermission, isFalse);
        expect(serverError == GeneralFailure.internalError, isFalse);
        expect(serverError == GeneralFailure.serverError, isTrue);
        expect(serverError == GeneralFailure.unknown, isFalse);

        expect(unknown == GeneralFailure.noPermission, isFalse);
        expect(unknown == GeneralFailure.internalError, isFalse);
        expect(unknown == GeneralFailure.serverError, isFalse);
        expect(unknown == GeneralFailure.unknown, isTrue);
      });
    });
  });
}
