import 'package:flutter_base/src/shared/domain/vos/title_vos.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TitleVos', () {
    group('Títulos válidos', () {
      final validTitles = [
        'Título simple',
        'Título con números 123',
        'Título con símbolos @#\$%',
        'Un título más largo para probar límites',
        'Título\ncon saltos',
        'Título con acentos: áéíóúñü',
        'Title with English',
        'Título mixto: ABC123xyz',
        'a', // Un solo carácter
        'Título con "comillas" y \'apostrofes\'',
        'Título de exactamente cincuenta caracteres aquí',
      ];

      for (final title in validTitles) {
        test('Debería aceptar título válido: "$title"', () {
          // Arrange & Act
          final titleVos = TitleVos(title);

          // Assert
          expect(titleVos.isValid(), isTrue);
          titleVos.when(
            isLeft: (failure) => fail('Debería ser válido: $title'),
            isRight: (value) => expect(value, equals(title.trim())),
          );
        });
      }
    });

    group('Títulos inválidos', () {
      group('Por estar vacíos', () {
        final emptyTitles = [
          '',
          '   ',
          '\t',
          '\n',
          '   \t  \n  ',
        ];

        for (final title in emptyTitles) {
          test('Debería rechazar título vacío: "$title"', () {
            // Arrange & Act
            final titleVos = TitleVos(title);

            // Assert
            expect(titleVos.isValid(), isFalse);
            titleVos.when(
              isLeft: (failure) => expect(failure, isA<FullnameFailureEmpty>()),
              isRight: (value) =>
                  fail('Debería retornar failure para título vacío'),
            );
          });
        }
      });

      group('Por ser demasiado largos', () {
        test('Debería rechazar título de exactamente 51 caracteres', () {
          // Arrange - Crear un título de exactamente 51 caracteres
          final longTitle = 'a' * 51;

          // Act
          final titleVos = TitleVos(longTitle);

          // Assert
          expect(titleVos.isValid(), isFalse);
          titleVos.when(
            isLeft: (failure) {
              expect(failure, isA<FullnameFailureTooLong>());
              if (failure is FullnameFailureTooLong) {
                expect(failure.length, equals(50));
              }
            },
            isRight: (value) =>
                fail('Debería retornar failure para título muy largo'),
          );
        });

        test('Debería rechazar títulos muy largos', () {
          // Arrange
          final longTitles = [
            'a' * 51, // Exactamente 51 caracteres
            'a' * 60, // 60 caracteres
            'a' * 100, // 100 caracteres
            'Título muy largo que excede el límite de cincuenta caracteres permitidos para validar correctamente',
            'Este es un título extremadamente largo que definitivamente excede el límite establecido de 50 caracteres',
          ];

          for (final title in longTitles) {
            // Act
            final titleVos = TitleVos(title);

            // Assert
            expect(
              titleVos.isValid(),
              isFalse,
              reason:
                  'Título de ${title.length} caracteres debería ser inválido',
            );
            titleVos.when(
              isLeft: (failure) =>
                  expect(failure, isA<FullnameFailureTooLong>()),
              isRight: (value) =>
                  fail('Debería retornar failure para título muy largo'),
            );
          }
        });
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final titleWithSpaces = TitleVos('  Un título con espacios  ');

        // Assert
        expect(titleWithSpaces.isValid(), isTrue);
        titleWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals('Un título con espacios')),
        );
      });

      test('Debería aceptar título de exactamente 50 caracteres', () {
        // Arrange - Crear un título de exactamente 50 caracteres
        final exactTitle = 'a' * 50;

        // Act
        final titleVos = TitleVos(exactTitle);

        // Assert
        expect(titleVos.isValid(), isTrue);
        titleVos.when(
          isLeft: (failure) =>
              fail('Título de 50 caracteres debería ser válido'),
          isRight: (value) => expect(value.length, equals(50)),
        );
      });

      test('Debería aceptar título de 1 carácter', () {
        // Arrange & Act
        final singleCharTitle = TitleVos('a');

        // Assert
        expect(singleCharTitle.isValid(), isTrue);
      });

      test('Debería aceptar todos los tipos de caracteres', () {
        // Arrange
        final specialTitles = [
          'Título con números: 123',
          'Título con símbolos: !@#\$%^&*()',
          'Título con acentos: áéíóúñü',
          'Título\ncon\nsaltos',
          'Título\tcon\ttabs',
          'Título mixto: ABC123!@# áéí',
        ];

        for (final title in specialTitles) {
          // Act
          final titleVos = TitleVos(title);

          // Assert
          expect(
            titleVos.isValid(),
            isTrue,
            reason:
                'Título con caracteres especiales debería ser válido: "$title"',
          );
        }
      });

      test('Debería preservar el contenido original', () {
        // Arrange
        final originalTitle = 'Título con MAYÚSCULAS, minúsculas, 123!';

        // Act
        final titleVos = TitleVos(originalTitle);

        // Assert
        expect(titleVos.isValid(), isTrue);
        titleVos.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals(originalTitle)),
        );
      });
    });

    group('Tests de límites específicos', () {
      test('Debería validar límites exactos de longitud', () {
        // Arrange
        final testCases = [
          {'length': 1, 'shouldBeValid': true},
          {'length': 10, 'shouldBeValid': true},
          {'length': 25, 'shouldBeValid': true},
          {'length': 49, 'shouldBeValid': true},
          {'length': 50, 'shouldBeValid': true},
          {'length': 51, 'shouldBeValid': false},
          {'length': 60, 'shouldBeValid': false},
          {'length': 100, 'shouldBeValid': false},
        ];

        for (final testCase in testCases) {
          // Act
          final title = 'a' * (testCase['length'] as int);
          final titleVos = TitleVos(title);
          final shouldBeValid = testCase['shouldBeValid'] as bool;

          // Assert
          expect(
            titleVos.isValid(),
            shouldBeValid,
            reason:
                'Título de ${testCase['length']} caracteres debería ser ${shouldBeValid ? 'válido' : 'inválido'}',
          );
        }
      });

      test('Debería manejar correctamente el límite después de trim', () {
        // Arrange - Crear título que después del trim quede exactamente en 50
        final titleWithSpaces =
            '  ${'a' * 50}  '; // 54 caracteres antes del trim

        // Act
        final titleVos = TitleVos(titleWithSpaces);

        // Assert
        expect(titleVos.isValid(), isTrue);
        titleVos.when(
          isLeft: (failure) => fail('Debería ser válido después del trim'),
          isRight: (value) => expect(value.length, equals(50)),
        );
      });

      test('Debería rechazar título que después del trim exceda el límite', () {
        // Arrange - Crear título que después del trim exceda 50
        final titleWithSpaces =
            '  ${'a' * 51}  '; // 55 caracteres antes del trim

        // Act
        final titleVos = TitleVos(titleWithSpaces);

        // Assert
        expect(titleVos.isValid(), isFalse);
        titleVos.when(
          isLeft: (failure) => expect(failure, isA<FullnameFailureTooLong>()),
          isRight: (value) => fail('Debería retornar failure después del trim'),
        );
      });
    });

    group('Tests de casos de uso reales', () {
      test('Debería aceptar títulos típicos de artículos', () {
        // Arrange
        final articleTitles = [
          'Introducción a Flutter',
          'Guía de Desarrollo Móvil',
          'Tutorial de Testing',
          'Mejores Prácticas 2024',
          'Arquitectura Clean Code',
          'Performance Optimization',
          'UI/UX Design Patterns',
          'State Management Guide',
        ];

        for (final title in articleTitles) {
          // Act
          final titleVos = TitleVos(title);

          // Assert
          expect(
            titleVos.isValid(),
            isTrue,
            reason: 'Título de artículo "$title" debería ser válido',
          );
        }
      });

      test('Debería aceptar títulos con caracteres internacionales', () {
        // Arrange
        final internationalTitles = [
          'Título en Español',
          'Title in English',
          'Titre en Français',
          'Titel auf Deutsch',
          'Titolo in Italiano',
          'Título com Acentos: ção',
          'Ñañaña Ññññ',
        ];

        for (final title in internationalTitles) {
          // Act
          final titleVos = TitleVos(title);

          // Assert
          expect(
            titleVos.isValid(),
            isTrue,
            reason: 'Título internacional "$title" debería ser válido',
          );
        }
      });

      test('Debería rechazar títulos excesivamente largos comunes', () {
        // Arrange
        final tooLongTitles = [
          'Este es un título muy largo que probablemente exceda el límite establecido de cincuenta caracteres',
          'Tutorial completo de desarrollo de aplicaciones móviles con Flutter y arquitectura limpia',
          'Guía definitiva para la implementación de testing automatizado en proyectos de gran escala',
        ];

        for (final title in tooLongTitles) {
          // Act
          final titleVos = TitleVos(title);

          // Assert
          expect(
            titleVos.isValid(),
            isFalse,
            reason:
                'Título largo "$title" debería ser inválido (${title.length} caracteres)',
          );
        }
      });
    });

    group('Tests de contenido específico', () {
      test('Debería manejar caracteres Unicode correctamente', () {
        // Arrange
        final unicodeTitles = [
          'Título con emoji: 🚀',
          'Texto japonés: こんにちは',
          'Texto árabe: مرحبا',
          'Símbolos: ∑∆∇∞',
          'Acentos: áéíóúñü',
        ];

        for (final title in unicodeTitles) {
          // Act
          final titleVos = TitleVos(title);

          // Assert
          expect(
            titleVos.isValid(),
            isTrue,
            reason: 'Título con Unicode debería ser válido: "$title"',
          );
        }
      });

      test('Debería manejar saltos de línea y tabulaciones', () {
        // Arrange
        final formattedTitles = [
          'Título\ncon salto',
          'Título\tcon tab',
          'Título\r\ncon CRLF',
          'Título\n\tmixto',
        ];

        for (final title in formattedTitles) {
          // Act
          final titleVos = TitleVos(title);

          // Assert
          expect(
            titleVos.isValid(),
            isTrue,
            reason: 'Título con formato "$title" debería ser válido',
          );
        }
      });

      test('Debería preservar espacios internos significativos', () {
        // Arrange & Act
        final titleWithInternalSpaces = TitleVos('  Título   con   espacios  ');

        // Assert
        expect(titleWithInternalSpaces.isValid(), isTrue);
        titleWithInternalSpaces.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals('Título   con   espacios')),
        );
      });
    });
  });
}
