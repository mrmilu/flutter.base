import 'package:flutter_base/src/shared/domain/failures/fullname_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/description_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DescriptionVos', () {
    group('Descripciones válidas', () {
      final validDescriptions = [
        'Esta es una descripción válida',
        'Descripción con números 123',
        'Descripción con símbolos @#\$%^&*()',
        'Una descripción muy larga pero aún dentro del límite permitido de 320 caracteres para validar que el sistema acepta correctamente textos extensos',
        'Descripción\ncon\nsaltos\nde\nlínea',
        'Descripción con caracteres especiales: áéíóúñü',
        'Texto con emojis 😀🎉🌟',
        'a', // Un solo carácter
        'Descripción con "comillas" y \'apostrofes\'',
        'Texto mixto: ABC123xyz!@#',
      ];

      for (final description in validDescriptions) {
        test(
          'Debería aceptar descripción válida: "${description.length > 50 ? '${description.substring(0, 50)}...' : description}"',
          () {
            // Arrange & Act
            final descriptionVos = DescriptionVos(description);

            // Assert
            expect(descriptionVos.isValid(), isTrue);
            descriptionVos.when(
              isLeft: (failure) => fail('Debería ser válida: $description'),
              isRight: (value) => expect(value, equals(description.trim())),
            );
          },
        );
      }
    });

    group('Descripciones inválidas', () {
      group('Por estar vacías', () {
        final emptyDescriptions = [
          '',
          '   ',
          '\t',
          '\n',
          '   \t  \n  ',
        ];

        for (final description in emptyDescriptions) {
          test('Debería rechazar descripción vacía: "$description"', () {
            // Arrange & Act
            final descriptionVos = DescriptionVos(description);

            // Assert
            expect(descriptionVos.isValid(), isFalse);
            descriptionVos.when(
              isLeft: (failure) => expect(failure, isA<FullnameFailureEmpty>()),
              isRight: (value) =>
                  fail('Debería retornar failure para descripción vacía'),
            );
          });
        }
      });

      group('Por ser demasiado largas', () {
        test('Debería rechazar descripción de exactamente 321 caracteres', () {
          // Arrange - Crear una descripción de exactamente 321 caracteres
          final longDescription = 'a' * 321;

          // Act
          final descriptionVos = DescriptionVos(longDescription);

          // Assert
          expect(descriptionVos.isValid(), isFalse);
          descriptionVos.when(
            isLeft: (failure) {
              expect(failure, isA<FullnameFailureTooLong>());
              if (failure is FullnameFailureTooLong) {
                expect(failure.length, equals(320));
              }
            },
            isRight: (value) =>
                fail('Debería retornar failure para descripción muy larga'),
          );
        });

        test('Debería rechazar descripciones muy largas', () {
          // Arrange
          final longDescriptions = [
            'a' * 321, // Exactamente 321 caracteres
            'a' * 350, // 350 caracteres
            'a' * 500, // 500 caracteres
            'a' * 1000, // 1000 caracteres
          ];

          for (final description in longDescriptions) {
            // Act
            final descriptionVos = DescriptionVos(description);

            // Assert
            expect(
              descriptionVos.isValid(),
              isFalse,
              reason:
                  'Descripción de ${description.length} caracteres debería ser inválida',
            );
            descriptionVos.when(
              isLeft: (failure) =>
                  expect(failure, isA<FullnameFailureTooLong>()),
              isRight: (value) =>
                  fail('Debería retornar failure para descripción muy larga'),
            );
          }
        });
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final descriptionWithSpaces = DescriptionVos(
          '  Una descripción con espacios  ',
        );

        // Assert
        expect(descriptionWithSpaces.isValid(), isTrue);
        descriptionWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válida'),
          isRight: (value) =>
              expect(value, equals('Una descripción con espacios')),
        );
      });

      test('Debería aceptar descripción de exactamente 320 caracteres', () {
        // Arrange - Crear una descripción de exactamente 320 caracteres
        final exactDescription = 'a' * 320;

        // Act
        final descriptionVos = DescriptionVos(exactDescription);

        // Assert
        expect(descriptionVos.isValid(), isTrue);
        descriptionVos.when(
          isLeft: (failure) =>
              fail('Descripción de 320 caracteres debería ser válida'),
          isRight: (value) => expect(value.length, equals(320)),
        );
      });

      test('Debería aceptar descripción de 1 carácter', () {
        // Arrange & Act
        final singleCharDescription = DescriptionVos('a');

        // Assert
        expect(singleCharDescription.isValid(), isTrue);
      });

      test('Debería aceptar todos los tipos de caracteres', () {
        // Arrange
        final specialDescriptions = [
          'Texto con números: 0123456789',
          'Texto con símbolos: !@#\$%^&*()_+-=[]{}|;\':",./<>?',
          'Texto con acentos: áéíóúñüÁÉÍÓÚÑÜ',
          'Texto con saltos de línea:\nSegunda línea\nTercera línea',
          'Texto con tabs:\tTabulado\t\tDoble tab',
          'Texto mixto: ABC123xyz!@# áéíóú\n\tCompleto',
        ];

        for (final description in specialDescriptions) {
          // Act
          final descriptionVos = DescriptionVos(description);

          // Assert
          expect(
            descriptionVos.isValid(),
            isTrue,
            reason:
                'Descripción con caracteres especiales debería ser válida: "$description"',
          );
        }
      });

      test('Debería manejar correctamente descripciones largas válidas', () {
        // Arrange - Crear descripción larga pero válida
        final longValidDescription =
            '''
        Esta es una descripción muy larga que incluye múltiples líneas,
        varios tipos de caracteres como números 123456789,
        símbolos especiales !@#\$%^&*(),
        caracteres con acentos áéíóúñü,
        y que está diseñada para probar que el sistema puede manejar
        correctamente descripciones extensas pero que aún están
        dentro del límite permitido de 320 caracteres establecido
        para este campo de descripción.
        '''
                .replaceAll(RegExp(r'\s+'), ' ')
                .trim();

        // Asegurar que está dentro del límite
        if (longValidDescription.length > 320) {
          final adjustedDescription = longValidDescription.substring(0, 320);

          // Act
          final descriptionVos = DescriptionVos(adjustedDescription);

          // Assert
          expect(descriptionVos.isValid(), isTrue);
        } else {
          // Act
          final descriptionVos = DescriptionVos(longValidDescription);

          // Assert
          expect(descriptionVos.isValid(), isTrue);
        }
      });
    });

    group('Tests de límites específicos', () {
      test('Debería validar límites exactos de longitud', () {
        // Arrange
        final testCases = [
          {'length': 1, 'shouldBeValid': true},
          {'length': 50, 'shouldBeValid': true},
          {'length': 100, 'shouldBeValid': true},
          {'length': 200, 'shouldBeValid': true},
          {'length': 319, 'shouldBeValid': true},
          {'length': 320, 'shouldBeValid': true},
          {'length': 321, 'shouldBeValid': false},
          {'length': 350, 'shouldBeValid': false},
          {'length': 500, 'shouldBeValid': false},
        ];

        for (final testCase in testCases) {
          // Act
          final description = 'a' * (testCase['length'] as int);
          final descriptionVos = DescriptionVos(description);
          final shouldBeValid = testCase['shouldBeValid'] as bool;

          // Assert
          expect(
            descriptionVos.isValid(),
            shouldBeValid,
            reason:
                'Descripción de ${testCase['length']} caracteres debería ser ${shouldBeValid ? 'válida' : 'inválida'}',
          );
        }
      });

      test('Debería manejar correctamente el límite después de trim', () {
        // Arrange - Crear descripción que después del trim quede exactamente en 320
        final descriptionWithSpaces =
            '  ${'a' * 320}  '; // 324 caracteres antes del trim

        // Act
        final descriptionVos = DescriptionVos(descriptionWithSpaces);

        // Assert
        expect(descriptionVos.isValid(), isTrue);
        descriptionVos.when(
          isLeft: (failure) => fail('Debería ser válida después del trim'),
          isRight: (value) => expect(value.length, equals(320)),
        );
      });

      test(
        'Debería rechazar descripción que después del trim exceda el límite',
        () {
          // Arrange - Crear descripción que después del trim exceda 320
          final descriptionWithSpaces =
              '  ${'a' * 321}  '; // 325 caracteres antes del trim

          // Act
          final descriptionVos = DescriptionVos(descriptionWithSpaces);

          // Assert
          expect(descriptionVos.isValid(), isFalse);
          descriptionVos.when(
            isLeft: (failure) => expect(failure, isA<FullnameFailureTooLong>()),
            isRight: (value) =>
                fail('Debería retornar failure después del trim'),
          );
        },
      );
    });

    group('Tests de contenido específico', () {
      test('Debería preservar el contenido original (sin modificaciones)', () {
        // Arrange
        final originalContent =
            'Descripción con MAYÚSCULAS, minúsculas, 123 números y símbolos!@#';

        // Act
        final descriptionVos = DescriptionVos(originalContent);

        // Assert
        expect(descriptionVos.isValid(), isTrue);
        descriptionVos.when(
          isLeft: (failure) => fail('Debería ser válida'),
          isRight: (value) => expect(value, equals(originalContent)),
        );
      });

      test('Debería manejar caracteres Unicode correctamente', () {
        // Arrange
        final unicodeDescriptions = [
          'Descripción con emojis: 😀🎉🌟⭐🚀',
          'Texto en japonés: こんにちは世界',
          'Texto en árabe: مرحبا بالعالم',
          'Texto en ruso: Привет мир',
          'Caracteres especiales: ñáéíóúü',
          'Símbolos matemáticos: ∑∆∇∞∈∉⊂⊃',
        ];

        for (final description in unicodeDescriptions) {
          // Act
          final descriptionVos = DescriptionVos(description);

          // Assert
          expect(
            descriptionVos.isValid(),
            isTrue,
            reason:
                'Descripción con Unicode debería ser válida: "$description"',
          );
        }
      });
    });
  });
}
