import 'package:flutter_base/src/shared/domain/failures/nif_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NifFailure', () {
    group('Enum values', () {
      test('Debería tener todos los valores esperados', () {
        // Assert
        expect(NifFailure.values.length, equals(3));
        expect(NifFailure.values, contains(NifFailure.tooLong));
        expect(NifFailure.values, contains(NifFailure.tooShort));
        expect(NifFailure.values, contains(NifFailure.invalidFormat));
      });

      test('Debería crear instancias de NifFailure correctamente', () {
        // Arrange & Act
        const tooLong = NifFailure.tooLong;
        const tooShort = NifFailure.tooShort;
        const invalidFormat = NifFailure.invalidFormat;

        // Assert
        expect(tooLong, isA<NifFailure>());
        expect(tooShort, isA<NifFailure>());
        expect(invalidFormat, isA<NifFailure>());
        expect(tooLong, equals(NifFailure.tooLong));
        expect(tooShort, equals(NifFailure.tooShort));
        expect(invalidFormat, equals(NifFailure.invalidFormat));
      });
    });

    group('map method', () {
      test('Debería mapear NifFailure.tooLong correctamente', () {
        // Arrange
        const failure = NifFailure.tooLong;

        // Act
        final result = failure.map<String>(
          tooLong: () => 'too_long_error',
          tooShort: () => 'too_short_error',
          invalidFormat: () => 'invalid_format_error',
        );

        // Assert
        expect(result, equals('too_long_error'));
      });

      test('Debería mapear NifFailure.tooShort correctamente', () {
        // Arrange
        const failure = NifFailure.tooShort;

        // Act
        final result = failure.map<String>(
          tooLong: () => 'too_long_error',
          tooShort: () => 'too_short_error',
          invalidFormat: () => 'invalid_format_error',
        );

        // Assert
        expect(result, equals('too_short_error'));
      });

      test('Debería mapear NifFailure.invalidFormat correctamente', () {
        // Arrange
        const failure = NifFailure.invalidFormat;

        // Act
        final result = failure.map<String>(
          tooLong: () => 'too_long_error',
          tooShort: () => 'too_short_error',
          invalidFormat: () => 'invalid_format_error',
        );

        // Assert
        expect(result, equals('invalid_format_error'));
      });

      test('Debería mapear a diferentes tipos de retorno', () {
        // Arrange
        const tooLongFailure = NifFailure.tooLong;
        const tooShortFailure = NifFailure.tooShort;
        const invalidFormatFailure = NifFailure.invalidFormat;

        // Act
        final intResult1 = tooLongFailure.map<int>(
          tooLong: () => 1,
          tooShort: () => 2,
          invalidFormat: () => 3,
        );

        final intResult2 = tooShortFailure.map<int>(
          tooLong: () => 1,
          tooShort: () => 2,
          invalidFormat: () => 3,
        );

        final boolResult = invalidFormatFailure.map<bool>(
          tooLong: () => true,
          tooShort: () => false,
          invalidFormat: () => true,
        );

        // Assert
        expect(intResult1, equals(1));
        expect(intResult2, equals(2));
        expect(boolResult, equals(true));
      });
    });

    group('fromString method', () {
      test('Debería crear NifFailure.tooLong desde string', () {
        // Act
        final result = NifFailure.fromString('tooLong');

        // Assert
        expect(result, equals(NifFailure.tooLong));
      });

      test('Debería crear NifFailure.tooShort desde string', () {
        // Act
        final result = NifFailure.fromString('tooShort');

        // Assert
        expect(result, equals(NifFailure.tooShort));
      });

      test('Debería crear NifFailure.invalidFormat desde string', () {
        // Act
        final result = NifFailure.fromString('invalidFormat');

        // Assert
        expect(result, equals(NifFailure.invalidFormat));
      });

      test(
        'Debería devolver NifFailure.invalidFormat para string desconocido',
        () {
          // Act
          final result1 = NifFailure.fromString('unknown');
          final result2 = NifFailure.fromString('');
          final result3 = NifFailure.fromString('invalid');

          // Assert
          expect(result1, equals(NifFailure.invalidFormat));
          expect(result2, equals(NifFailure.invalidFormat));
          expect(result3, equals(NifFailure.invalidFormat));
        },
      );
    });

    group('Equality and comparison', () {
      test('Debería considerar iguales instancias del mismo valor', () {
        // Arrange
        const tooLong1 = NifFailure.tooLong;
        const tooLong2 = NifFailure.tooLong;
        const tooShort = NifFailure.tooShort;

        // Assert
        expect(tooLong1, equals(tooLong2));
        expect(tooLong1, isNot(equals(tooShort)));
        expect(tooLong1.hashCode, equals(tooLong2.hashCode));
      });

      test('Debería mantener orden consistente', () {
        // Arrange
        const values = NifFailure.values;

        // Assert
        expect(values[0], equals(NifFailure.tooLong));
        expect(values[1], equals(NifFailure.tooShort));
        expect(values[2], equals(NifFailure.invalidFormat));
      });
    });

    group('String representation', () {
      test('Debería tener representación string correcta', () {
        // Arrange
        const tooLong = NifFailure.tooLong;
        const tooShort = NifFailure.tooShort;
        const invalidFormat = NifFailure.invalidFormat;

        // Act & Assert
        expect(tooLong.toString(), equals('NifFailure.tooLong'));
        expect(tooShort.toString(), equals('NifFailure.tooShort'));
        expect(invalidFormat.toString(), equals('NifFailure.invalidFormat'));
      });

      test('Debería tener name property correcta', () {
        // Arrange
        const tooLong = NifFailure.tooLong;
        const tooShort = NifFailure.tooShort;
        const invalidFormat = NifFailure.invalidFormat;

        // Act & Assert
        expect(tooLong.name, equals('tooLong'));
        expect(tooShort.name, equals('tooShort'));
        expect(invalidFormat.name, equals('invalidFormat'));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los valores del enum', () {
        // Arrange
        const tooLong = NifFailure.tooLong;
        const tooShort = NifFailure.tooShort;
        const invalidFormat = NifFailure.invalidFormat;

        // Assert
        expect(tooLong == NifFailure.tooLong, isTrue);
        expect(tooLong == NifFailure.tooShort, isFalse);
        expect(tooLong == NifFailure.invalidFormat, isFalse);

        expect(tooShort == NifFailure.tooLong, isFalse);
        expect(tooShort == NifFailure.tooShort, isTrue);
        expect(tooShort == NifFailure.invalidFormat, isFalse);

        expect(invalidFormat == NifFailure.tooLong, isFalse);
        expect(invalidFormat == NifFailure.tooShort, isFalse);
        expect(invalidFormat == NifFailure.invalidFormat, isTrue);
      });
    });
  });
}
