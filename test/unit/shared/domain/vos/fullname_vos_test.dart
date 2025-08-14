import 'package:flutter_base/src/shared/domain/failures/fullname_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/fullname_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FullnameVos', () {
    group('Nombres válidos', () {
      final validNames = [
        'Juan',
        'María Elena',
        'José Luis',
        'Ana Sofía',
        'Pedro José María',
        'Carmen Teresa',
        'Ángel',
        'José',
        'María José González',
        'Peña',
        'Núñez',
        'José Ángel',
        'María Ángeles',
        'Sofía Elena Cristina',
      ];

      for (final name in validNames) {
        test('Debería aceptar nombre válido: "$name"', () {
          // Arrange & Act
          final fullnameVos = FullnameVos(name);

          // Assert
          expect(fullnameVos.isValid(), isTrue);
          fullnameVos.when(
            isLeft: (failure) => fail('Debería ser válido: $name'),
            isRight: (value) => expect(value, equals(name.trim())),
          );
        });
      }
    });

    group('Nombres inválidos', () {
      final invalidNames = [
        // Nombres vacíos
        '',
        '   ',

        // Nombres muy cortos (menos de 2 caracteres)
        'A',
        'J',

        // Nombres con números
        'Juan123',
        'María1',
        'José2024',

        // Nombres con caracteres especiales inválidos
        'Juan@',
        'María#Elena',
        'José-Luis',
        'Ana_Sofía',
        'Pedro & María',
        'Juan/Carlos',

        // Más de 4 palabras
        'Juan Carlos Pedro José María',
        'Ana Sofía Elena María Carmen',

        // Nombres demasiado largos (más de 30 caracteres)
        'Juan Carlos Pedro José María Elena',
        'María Elena Sofía Carmen Teresa Ana',
      ];

      for (final name in invalidNames) {
        test('Debería rechazar nombre inválido: "$name"', () {
          // Arrange & Act
          final fullnameVos = FullnameVos(name);

          // Assert
          expect(fullnameVos.isValid(), isFalse);
          expect(fullnameVos.isInvalid(), isTrue);
        });
      }
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final nameWithSpaces = FullnameVos('  María Elena  ');

        // Assert
        expect(nameWithSpaces.isValid(), isTrue);
        nameWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals('María Elena')),
        );
      });

      test('Debería retornar FullnameFailure.empty para nombre vacío', () {
        // Arrange & Act
        final emptyName = FullnameVos('');

        // Assert
        expect(emptyName.isValid(), isFalse);
        emptyName.when(
          isLeft: (failure) => expect(failure, isA<FullnameFailureEmpty>()),
          isRight: (value) =>
              fail('Debería retornar failure para nombre vacío'),
        );
      });

      test(
        'Debería retornar FullnameFailure.invalid para formato incorrecto',
        () {
          // Arrange & Act
          final invalidName = FullnameVos('Juan123');

          // Assert
          expect(invalidName.isValid(), isFalse);
          invalidName.when(
            isLeft: (failure) => expect(failure, isA<FullnameFailureInvalid>()),
            isRight: (value) =>
                fail('Debería retornar failure para nombre inválido'),
          );
        },
      );

      test(
        'Debería retornar FullnameFailure.tooLong para nombres muy largos',
        () {
          // Arrange & Act
          final longName = FullnameVos('Francisco Carlos Alberto Magdelena');

          // Assert
          expect(longName.isValid(), isFalse);
          longName.when(
            isLeft: (failure) {
              expect(failure, isA<FullnameFailureTooLong>());
              if (failure is FullnameFailureTooLong) {
                expect(failure.length, equals(30));
              }
            },
            isRight: (value) =>
                fail('Debería retornar failure para nombre muy largo'),
          );
        },
      );

      test('Debería aceptar caracteres especiales españoles', () {
        // Arrange
        final spanishNames = [
          'Ángel',
          'José',
          'María',
          'Peña',
          'Núñez',
          'Iñaki',
          'Begoña',
        ];

        for (final name in spanishNames) {
          // Act
          final fullnameVos = FullnameVos(name);

          // Assert
          expect(
            fullnameVos.isValid(),
            isTrue,
            reason:
                'Nombre con caracteres españoles "$name" debería ser válido',
          );
        }
      });

      test('Debería rechazar nombres con un solo carácter', () {
        // Arrange
        final singleCharNames = ['A', 'B', 'X', 'Ñ'];

        for (final name in singleCharNames) {
          // Act
          final fullnameVos = FullnameVos(name);

          // Assert
          expect(
            fullnameVos.isValid(),
            isFalse,
            reason: 'Nombre de un carácter "$name" debería ser inválido',
          );
        }
      });

      test('Debería limitar a máximo 4 palabras', () {
        // Arrange
        final tooManyWords = [
          'Ana María José Carmen Elena',
          'Juan Carlos Pedro José María',
          'Sofía Elena Carmen Teresa Ana María',
        ];

        for (final name in tooManyWords) {
          // Act
          final fullnameVos = FullnameVos(name);

          // Assert
          expect(
            fullnameVos.isValid(),
            isFalse,
            reason: 'Nombre con muchas palabras "$name" debería ser inválido',
          );
        }
      });

      test('Debería aceptar hasta 4 palabras', () {
        // Arrange
        final fourWords = [
          'Ana María José Carmen',
          'Juan Carlos Pedro José',
          'Sofía Elena Carmen Teresa',
        ];

        for (final name in fourWords) {
          // Act
          final fullnameVos = FullnameVos(name);

          // Assert
          expect(
            fullnameVos.isValid(),
            isTrue,
            reason: 'Nombre con 4 palabras "$name" debería ser válido',
          );
        }
      });
    });

    group('Tests de regex específicos', () {
      test('Debería exigir al menos 2 caracteres por palabra', () {
        // Arrange
        final validTwoChar = ['Jo Ana', 'Ma Carmen', 'Lu Pedro'];
        final invalidShort = ['J Ana', 'Ma C', 'A Pedro'];

        // Act & Assert - Casos válidos
        for (final name in validTwoChar) {
          final fullnameVos = FullnameVos(name);
          expect(
            fullnameVos.isValid(),
            isTrue,
            reason:
                'Nombre "$name" con palabras de 2+ caracteres debería ser válido',
          );
        }

        // Act & Assert - Casos inválidos
        for (final name in invalidShort) {
          final fullnameVos = FullnameVos(name);
          expect(
            fullnameVos.isValid(),
            isFalse,
            reason: 'Nombre "$name" con palabras cortas debería ser inválido',
          );
        }
      });

      test('Debería respetar límite de 30 caracteres', () {
        // Arrange
        final exactlyThirty = 'María Elena Carmen José';
        final overThirty = 'Alberto Claudia Carmen Magdalena';

        // Act & Assert
        final validName = FullnameVos(exactlyThirty);
        expect(validName.isValid(), isTrue);

        final invalidName = FullnameVos(overThirty);
        expect(invalidName.isValid(), isFalse);
      });
    });
  });
}
