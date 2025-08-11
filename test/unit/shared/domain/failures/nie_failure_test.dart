import 'package:flutter_base/src/shared/domain/failures/nie_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NieFailure', () {
    group('Enum values', () {
      test('Debería tener todos los valores esperados', () {
        // Assert
        expect(NieFailure.values.length, equals(3));
        expect(NieFailure.values, contains(NieFailure.tooLong));
        expect(NieFailure.values, contains(NieFailure.tooShort));
        expect(NieFailure.values, contains(NieFailure.invalidFormat));
      });

      test('Debería crear instancias de NieFailure correctamente', () {
        // Arrange & Act
        const tooLong = NieFailure.tooLong;
        const tooShort = NieFailure.tooShort;
        const invalidFormat = NieFailure.invalidFormat;

        // Assert
        expect(tooLong, isA<NieFailure>());
        expect(tooShort, isA<NieFailure>());
        expect(invalidFormat, isA<NieFailure>());
        expect(tooLong, equals(NieFailure.tooLong));
        expect(tooShort, equals(NieFailure.tooShort));
        expect(invalidFormat, equals(NieFailure.invalidFormat));
      });
    });

    group('map method', () {
      test('Debería mapear NieFailure.tooLong correctamente', () {
        // Arrange
        const failure = NieFailure.tooLong;

        // Act
        final result = failure.map<String>(
          tooLong: () => 'too_long_error',
          tooShort: () => 'too_short_error',
          invalidFormat: () => 'invalid_format_error',
        );

        // Assert
        expect(result, equals('too_long_error'));
      });

      test('Debería mapear NieFailure.tooShort correctamente', () {
        // Arrange
        const failure = NieFailure.tooShort;

        // Act
        final result = failure.map<String>(
          tooLong: () => 'too_long_error',
          tooShort: () => 'too_short_error',
          invalidFormat: () => 'invalid_format_error',
        );

        // Assert
        expect(result, equals('too_short_error'));
      });

      test('Debería mapear NieFailure.invalidFormat correctamente', () {
        // Arrange
        const failure = NieFailure.invalidFormat;

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
        const tooLongFailure = NieFailure.tooLong;
        const tooShortFailure = NieFailure.tooShort;
        const invalidFormatFailure = NieFailure.invalidFormat;

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
      test('Debería crear NieFailure.tooLong desde string', () {
        // Act
        final result = NieFailure.fromString('tooLong');

        // Assert
        expect(result, equals(NieFailure.tooLong));
      });

      test('Debería crear NieFailure.tooShort desde string', () {
        // Act
        final result = NieFailure.fromString('tooShort');

        // Assert
        expect(result, equals(NieFailure.tooShort));
      });

      test('Debería crear NieFailure.invalidFormat desde string', () {
        // Act
        final result = NieFailure.fromString('invalidFormat');

        // Assert
        expect(result, equals(NieFailure.invalidFormat));
      });

      test(
        'Debería devolver NieFailure.invalidFormat para string desconocido',
        () {
          // Act
          final result1 = NieFailure.fromString('unknown');
          final result2 = NieFailure.fromString('');
          final result3 = NieFailure.fromString('invalid');

          // Assert
          expect(result1, equals(NieFailure.invalidFormat));
          expect(result2, equals(NieFailure.invalidFormat));
          expect(result3, equals(NieFailure.invalidFormat));
        },
      );
    });

    group('Equality and comparison', () {
      test('Debería considerar iguales instancias del mismo valor', () {
        // Arrange
        const tooLong1 = NieFailure.tooLong;
        const tooLong2 = NieFailure.tooLong;
        const tooShort = NieFailure.tooShort;

        // Assert
        expect(tooLong1, equals(tooLong2));
        expect(tooLong1, isNot(equals(tooShort)));
        expect(tooLong1.hashCode, equals(tooLong2.hashCode));
      });

      test('Debería mantener orden consistente', () {
        // Arrange
        const values = NieFailure.values;

        // Assert
        expect(values[0], equals(NieFailure.tooLong));
        expect(values[1], equals(NieFailure.tooShort));
        expect(values[2], equals(NieFailure.invalidFormat));
      });
    });

    group('String representation', () {
      test('Debería tener representación string correcta', () {
        // Arrange
        const tooLong = NieFailure.tooLong;
        const tooShort = NieFailure.tooShort;
        const invalidFormat = NieFailure.invalidFormat;

        // Act & Assert
        expect(tooLong.toString(), equals('NieFailure.tooLong'));
        expect(tooShort.toString(), equals('NieFailure.tooShort'));
        expect(invalidFormat.toString(), equals('NieFailure.invalidFormat'));
      });

      test('Debería tener name property correcta', () {
        // Arrange
        const tooLong = NieFailure.tooLong;
        const tooShort = NieFailure.tooShort;
        const invalidFormat = NieFailure.invalidFormat;

        // Act & Assert
        expect(tooLong.name, equals('tooLong'));
        expect(tooShort.name, equals('tooShort'));
        expect(invalidFormat.name, equals('invalidFormat'));
      });
    });

    group('Type checking', () {
      test('Debería identificar correctamente los valores del enum', () {
        // Arrange
        const tooLong = NieFailure.tooLong;
        const tooShort = NieFailure.tooShort;
        const invalidFormat = NieFailure.invalidFormat;

        // Assert
        expect(tooLong == NieFailure.tooLong, isTrue);
        expect(tooLong == NieFailure.tooShort, isFalse);
        expect(tooLong == NieFailure.invalidFormat, isFalse);

        expect(tooShort == NieFailure.tooLong, isFalse);
        expect(tooShort == NieFailure.tooShort, isTrue);
        expect(tooShort == NieFailure.invalidFormat, isFalse);

        expect(invalidFormat == NieFailure.tooLong, isFalse);
        expect(invalidFormat == NieFailure.tooShort, isFalse);
        expect(invalidFormat == NieFailure.invalidFormat, isTrue);
      });
    });
  });
}
