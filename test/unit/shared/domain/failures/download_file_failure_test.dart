import 'package:flutter_base/src/shared/domain/failures/download_file_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DownloadFileFailure', () {
    group('Enum values', () {
      test('Debería tener todos los valores esperados', () {
        // Assert
        expect(DownloadFileFailure.values.length, equals(4));
        expect(
          DownloadFileFailure.values,
          contains(DownloadFileFailure.notFound),
        );
        expect(
          DownloadFileFailure.values,
          contains(DownloadFileFailure.noPermission),
        );
        expect(
          DownloadFileFailure.values,
          contains(DownloadFileFailure.unknown),
        );
        expect(
          DownloadFileFailure.values,
          contains(DownloadFileFailure.problemWithSaveFile),
        );
      });

      test('Debería crear instancias de DownloadFileFailure correctamente', () {
        // Arrange & Act
        const notFound = DownloadFileFailure.notFound;
        const noPermission = DownloadFileFailure.noPermission;
        const unknown = DownloadFileFailure.unknown;
        const problemWithSaveFile = DownloadFileFailure.problemWithSaveFile;

        // Assert
        expect(notFound, isA<DownloadFileFailure>());
        expect(noPermission, isA<DownloadFileFailure>());
        expect(unknown, isA<DownloadFileFailure>());
        expect(problemWithSaveFile, isA<DownloadFileFailure>());
        expect(notFound, equals(DownloadFileFailure.notFound));
        expect(noPermission, equals(DownloadFileFailure.noPermission));
        expect(unknown, equals(DownloadFileFailure.unknown));
        expect(
          problemWithSaveFile,
          equals(DownloadFileFailure.problemWithSaveFile),
        );
      });
    });

    group('map method', () {
      test('Debería mapear DownloadFileFailure.notFound correctamente', () {
        // Arrange
        const failure = DownloadFileFailure.notFound;

        // Act
        final result = failure.map<String>(
          notFound: () => 'not_found_error',
          noPermission: () => 'no_permission_error',
          unknown: () => 'unknown_error',
          problemWithSaveFile: () => 'problem_with_save_file_error',
        );

        // Assert
        expect(result, equals('not_found_error'));
      });

      test('Debería mapear DownloadFileFailure.noPermission correctamente', () {
        // Arrange
        const failure = DownloadFileFailure.noPermission;

        // Act
        final result = failure.map<String>(
          notFound: () => 'not_found_error',
          noPermission: () => 'no_permission_error',
          unknown: () => 'unknown_error',
          problemWithSaveFile: () => 'problem_with_save_file_error',
        );

        // Assert
        expect(result, equals('no_permission_error'));
      });

      test('Debería mapear DownloadFileFailure.unknown correctamente', () {
        // Arrange
        const failure = DownloadFileFailure.unknown;

        // Act
        final result = failure.map<String>(
          notFound: () => 'not_found_error',
          noPermission: () => 'no_permission_error',
          unknown: () => 'unknown_error',
          problemWithSaveFile: () => 'problem_with_save_file_error',
        );

        // Assert
        expect(result, equals('unknown_error'));
      });

      test(
        'Debería mapear DownloadFileFailure.problemWithSaveFile correctamente',
        () {
          // Arrange
          const failure = DownloadFileFailure.problemWithSaveFile;

          // Act
          final result = failure.map<String>(
            notFound: () => 'not_found_error',
            noPermission: () => 'no_permission_error',
            unknown: () => 'unknown_error',
            problemWithSaveFile: () => 'problem_with_save_file_error',
          );

          // Assert
          expect(result, equals('problem_with_save_file_error'));
        },
      );

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        const notFoundFailure = DownloadFileFailure.notFound;
        const noPermissionFailure = DownloadFileFailure.noPermission;
        const unknownFailure = DownloadFileFailure.unknown;
        const problemWithSaveFileFailure =
            DownloadFileFailure.problemWithSaveFile;

        // Act
        final intResult1 = notFoundFailure.map<int>(
          notFound: () => 404,
          noPermission: () => 403,
          unknown: () => 500,
          problemWithSaveFile: () => 501,
        );

        final intResult2 = noPermissionFailure.map<int>(
          notFound: () => 404,
          noPermission: () => 403,
          unknown: () => 500,
          problemWithSaveFile: () => 501,
        );

        final intResult3 = unknownFailure.map<int>(
          notFound: () => 404,
          noPermission: () => 403,
          unknown: () => 500,
          problemWithSaveFile: () => 501,
        );

        final boolResult = problemWithSaveFileFailure.map<bool>(
          notFound: () => false,
          noPermission: () => false,
          unknown: () => false,
          problemWithSaveFile: () => true,
        );

        // Assert
        expect(intResult1, equals(404));
        expect(intResult2, equals(403));
        expect(intResult3, equals(500));
        expect(boolResult, equals(true));
      });
    });

    group('fromString method', () {
      test('Debería crear DownloadFileFailure.notFound desde string', () {
        // Act
        final result = DownloadFileFailure.fromString('notFound');

        // Assert
        expect(result, equals(DownloadFileFailure.notFound));
      });

      test('Debería crear DownloadFileFailure.noPermission desde string', () {
        // Act
        final result = DownloadFileFailure.fromString('noPermission');

        // Assert
        expect(result, equals(DownloadFileFailure.noPermission));
      });

      test('Debería crear DownloadFileFailure.unknown desde string', () {
        // Act
        final result = DownloadFileFailure.fromString('unknown');

        // Assert
        expect(result, equals(DownloadFileFailure.unknown));
      });

      test(
        'Debería crear DownloadFileFailure.problemWithSaveFile desde string',
        () {
          // Act
          final result = DownloadFileFailure.fromString('problemWithSaveFile');

          // Assert
          expect(result, equals(DownloadFileFailure.problemWithSaveFile));
        },
      );

      test(
        'Debería devolver DownloadFileFailure.unknown para string desconocido',
        () {
          // Act
          final result1 = DownloadFileFailure.fromString('unknownString');
          final result2 = DownloadFileFailure.fromString('');
          final result3 = DownloadFileFailure.fromString('invalid');

          // Assert
          expect(result1, equals(DownloadFileFailure.unknown));
          expect(result2, equals(DownloadFileFailure.unknown));
          expect(result3, equals(DownloadFileFailure.unknown));
        },
      );
    });

    group('Equality and comparison', () {
      test('Debería considerar iguales instancias del mismo valor', () {
        // Arrange
        const notFound1 = DownloadFileFailure.notFound;
        const notFound2 = DownloadFileFailure.notFound;
        const noPermission = DownloadFileFailure.noPermission;

        // Assert
        expect(notFound1, equals(notFound2));
        expect(notFound1, isNot(equals(noPermission)));
        expect(notFound1.hashCode, equals(notFound2.hashCode));
      });

      test('Debería mantener orden consistente', () {
        // Arrange
        const values = DownloadFileFailure.values;

        // Assert
        expect(values[0], equals(DownloadFileFailure.notFound));
        expect(values[1], equals(DownloadFileFailure.noPermission));
        expect(values[2], equals(DownloadFileFailure.unknown));
        expect(values[3], equals(DownloadFileFailure.problemWithSaveFile));
      });
    });

    group('String representation', () {
      test('Debería tener representación string correcta', () {
        // Arrange
        const notFound = DownloadFileFailure.notFound;
        const noPermission = DownloadFileFailure.noPermission;
        const unknown = DownloadFileFailure.unknown;
        const problemWithSaveFile = DownloadFileFailure.problemWithSaveFile;

        // Act & Assert
        expect(notFound.toString(), equals('DownloadFileFailure.notFound'));
        expect(
          noPermission.toString(),
          equals('DownloadFileFailure.noPermission'),
        );
        expect(unknown.toString(), equals('DownloadFileFailure.unknown'));
        expect(
          problemWithSaveFile.toString(),
          equals('DownloadFileFailure.problemWithSaveFile'),
        );
      });

      test('Debería tener name property correcta', () {
        // Arrange
        const notFound = DownloadFileFailure.notFound;
        const noPermission = DownloadFileFailure.noPermission;
        const unknown = DownloadFileFailure.unknown;
        const problemWithSaveFile = DownloadFileFailure.problemWithSaveFile;

        // Act & Assert
        expect(notFound.name, equals('notFound'));
        expect(noPermission.name, equals('noPermission'));
        expect(unknown.name, equals('unknown'));
        expect(problemWithSaveFile.name, equals('problemWithSaveFile'));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los valores del enum', () {
        // Arrange
        const notFound = DownloadFileFailure.notFound;
        const noPermission = DownloadFileFailure.noPermission;
        const unknown = DownloadFileFailure.unknown;
        const problemWithSaveFile = DownloadFileFailure.problemWithSaveFile;

        // Assert
        expect(notFound == DownloadFileFailure.notFound, isTrue);
        expect(notFound == DownloadFileFailure.noPermission, isFalse);
        expect(notFound == DownloadFileFailure.unknown, isFalse);
        expect(notFound == DownloadFileFailure.problemWithSaveFile, isFalse);

        expect(noPermission == DownloadFileFailure.notFound, isFalse);
        expect(noPermission == DownloadFileFailure.noPermission, isTrue);
        expect(noPermission == DownloadFileFailure.unknown, isFalse);
        expect(
          noPermission == DownloadFileFailure.problemWithSaveFile,
          isFalse,
        );

        expect(unknown == DownloadFileFailure.notFound, isFalse);
        expect(unknown == DownloadFileFailure.noPermission, isFalse);
        expect(unknown == DownloadFileFailure.unknown, isTrue);
        expect(unknown == DownloadFileFailure.problemWithSaveFile, isFalse);

        expect(problemWithSaveFile == DownloadFileFailure.notFound, isFalse);
        expect(
          problemWithSaveFile == DownloadFileFailure.noPermission,
          isFalse,
        );
        expect(problemWithSaveFile == DownloadFileFailure.unknown, isFalse);
        expect(
          problemWithSaveFile == DownloadFileFailure.problemWithSaveFile,
          isTrue,
        );
      });
    });
  });
}
