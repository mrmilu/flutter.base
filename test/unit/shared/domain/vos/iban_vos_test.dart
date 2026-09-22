import 'package:flutter_base/src/shared/domain/failures/iban_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/iban_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IbanVos', () {
    group('IBANs válidos', () {
      // Solo IBANs de exactamente 24 caracteres (sin espacios) que pasen AMBAS validaciones:
      // 1. Módulo 97 internacional
      // 2. Dígitos de control nacionales españoles
      final validIbans = [
        'ES1521000418493524919564', // España - IBAN completamente válido con checksum 15 y DC 49
        'ES9121000418450200051332', // España - Otro IBAN válido calculado
        'ES8023100001180000012345', // España - IBAN válido del Banco Santander
      ];

      for (final iban in validIbans) {
        test('Debería aceptar IBAN válido: $iban', () {
          // Arrange & Act
          final ibanVos = IbanVos(iban);

          // Assert
          expect(ibanVos.isValid(), isTrue);
          ibanVos.when(
            isLeft: (failure) => fail('Debería ser válido: $iban'),
            isRight: (value) => expect(value, equals(iban.trim())),
          );
        });
      }

      test(
        'Debería limpiar espacios en blanco del input pero fallar si no son exactamente 24 caracteres',
        () {
          // Arrange
          const ibanWithSpaces =
              'ES15 2100 0418 49 3524 9195 64'; // Con espacios son más de 24 caracteres

          // Act
          final ibanVos = IbanVos(ibanWithSpaces);

          // Assert - Debería fallar porque con espacios tiene más de 24 caracteres
          expect(ibanVos.isValid(), isFalse);
          ibanVos.when(
            isLeft: (failure) => expect(
              failure,
              equals(const IbanFailure.tooLong(length: ibanWithSpaces.length)),
            ),
            isRight: (value) => fail('No debería ser válido con espacios'),
          );
        },
      );

      test(
        'Debería aceptar IBAN sin espacios cuando son exactamente 24 caracteres',
        () {
          // Arrange
          const ibanWithoutSpaces =
              'ES1521000418493524919564'; // Sin espacios, exactamente 24 caracteres, dígitos correctos

          // Act
          final ibanVos = IbanVos(ibanWithoutSpaces);

          // Assert
          expect(ibanWithoutSpaces.length, equals(24));
          expect(ibanVos.isValid(), isTrue);
          ibanVos.when(
            isLeft: (failure) => fail('Debería ser válido sin espacios'),
            isRight: (value) => expect(value, equals(ibanWithoutSpaces)),
          );
        },
      );
    });

    group('IBANs inválidos por longitud', () {
      group('Demasiado cortos (< 24 caracteres)', () {
        final shortIbans = [
          '',
          'ES15',
          'ES1521000418493524',
          'ES152100041849352491956', // 23 caracteres
          'ES15210004184935249195', // 22 caracteres
          'ES1521000418493524919', // 21 caracteres
        ];

        for (final iban in shortIbans) {
          test(
            'Debería rechazar IBAN demasiado corto: "$iban" (${iban.length} chars)',
            () {
              // Arrange & Act
              final ibanVos = IbanVos(iban);

              // Assert
              expect(ibanVos.isValid(), isFalse);
              ibanVos.when(
                isLeft: (failure) => expect(
                  failure,
                  equals(IbanFailure.tooShort(length: iban.length)),
                ),
                isRight: (value) => fail('No debería ser válido: $iban'),
              );
            },
          );
        }
      });

      group('Demasiado largos (> 24 caracteres)', () {
        final longIbans = [
          'ES15210004184935249195641', // 25 caracteres
          'ES152100041849352491956412345', // 29 caracteres
          'ES15 2100 0418 49 3524 9195 64', // Con espacios: 31 caracteres
          'ES1521000418493524919564123', // 27 caracteres
        ];

        for (final iban in longIbans) {
          test(
            'Debería rechazar IBAN demasiado largo: "$iban" (${iban.length} chars)',
            () {
              // Arrange & Act
              final ibanVos = IbanVos(iban);

              // Assert
              expect(ibanVos.isValid(), isFalse);
              ibanVos.when(
                isLeft: (failure) => expect(
                  failure,
                  equals(IbanFailure.tooLong(length: iban.length)),
                ),
                isRight: (value) => fail('No debería ser válido: $iban'),
              );
            },
          );
        }
      });
    });

    group('IBANs inválidos por formato', () {
      final invalidFormatIbans = [
        'es1521000418493524919564', // Minúsculas en código país
        '1521000418493524919564ES', // Código país al final
        'E115210004184935249195640', // Solo una letra en código país (y demasiado largo)
        'ES1X210004184935249195640', // Letra en posición de dígito verificador (y demasiado largo)
        'ES15210004184935249195-64', // Carácter especial (y demasiado largo)
        r'E$15210004184935249195640', // Carácter especial en código país (y demasiado largo)
        '1S1521000418493524919564', // Número en código país
        'ES##21000418493524919564', // Caracteres especiales en dígitos verificadores
        'ES15@10004184935249195', // Carácter especial en el cuerpo (y demasiado corto)
        'ES152100041849352491956@', // Carácter especial al final
      ];

      for (final iban in invalidFormatIbans) {
        test('Debería rechazar IBAN con formato inválido: "$iban"', () {
          // Arrange & Act
          final ibanVos = IbanVos(iban);

          // Assert
          expect(ibanVos.isValid(), isFalse);
          ibanVos.when(
            isLeft: (failure) => {
              // Puede fallar por formato O por longitud, dependiendo del caso
              if (iban.length != 24)
                {
                  expect(
                    failure,
                    isIn([
                      IbanFailure.tooLong(length: iban.length),
                      IbanFailure.tooShort(length: iban.length),
                    ]),
                  ),
                }
              else
                {expect(failure, equals(const IbanFailure.invalidFormat()))},
            },
            isRight: (value) => fail('No debería ser válido: $iban'),
          );
        });
      }
    });

    group('IBANs inválidos por checksum', () {
      final invalidChecksumIbans = [
        'ES1421000418493524919564', // Checksum incorrecto (14 en lugar de 15)
        'ES1621000418493524919564', // Checksum incorrecto (16 en lugar de 15)
        'ES0021000418493524919564', // Checksum incorrecto (00 en lugar de 15)
        'ES9921000418493524919564', // Checksum incorrecto (99 en lugar de 15)
        'ES1234567890123456789012', // IBAN con formato correcto pero checksum inválido
        'ES0034567890123456789012', // IBAN con formato correcto pero checksum inválido
      ];

      for (final iban in invalidChecksumIbans) {
        test('Debería rechazar IBAN con checksum inválido: "$iban"', () {
          // Arrange & Act
          final ibanVos = IbanVos(iban);

          // Assert
          expect(ibanVos.isValid(), isFalse);
          ibanVos.when(
            isLeft: (failure) =>
                expect(failure, equals(const IbanFailure.invalidChecksum())),
            isRight: (value) => fail('No debería ser válido: $iban'),
          );
        });
      }
    });

    group('IBANs inválidos por dígitos de control nacionales españoles', () {
      final invalidSpanishControlDigits = [
        'ES6921000418453524919564', // El IBAN original del usuario - checksum válido pero dígitos de control nacionales incorrectos (45 en lugar de 49)
        'ES1521000418003524919564', // Dígitos de control incorrectos (00)
        'ES1521000418993524919564', // Dígitos de control incorrectos (99)
        'ES1521000418503524919564', // Dígitos de control incorrectos (50)
        'ES1521000418463524919564', // Dígitos de control incorrectos (46)
      ];

      for (final iban in invalidSpanishControlDigits) {
        test(
          'Debería rechazar IBAN español con dígitos de control nacionales incorrectos: "$iban"',
          () {
            // Arrange & Act
            final ibanVos = IbanVos(iban);

            // Assert
            expect(ibanVos.isValid(), isFalse);
            ibanVos.when(
              isLeft: (failure) =>
                  expect(failure, equals(const IbanFailure.invalidChecksum())),
              isRight: (value) => fail('No debería ser válido: $iban'),
            );
          },
        );
      }
    });

    group('Casos edge específicos', () {
      test('Debería manejar IBAN exactamente de 24 caracteres', () {
        // Arrange
        const iban =
            'ES1521000418493524919564'; // Exactamente 24 caracteres, dígitos de control correctos

        // Act
        final ibanVos = IbanVos(iban);

        // Assert
        expect(iban.length, equals(24));
        expect(ibanVos.isValid(), isTrue);
      });

      test('Debería rechazar IBAN de 23 caracteres', () {
        // Arrange
        const iban = 'ES152100041849352491956'; // 23 caracteres

        // Act
        final ibanVos = IbanVos(iban);

        // Assert
        expect(iban.length, equals(23));
        expect(ibanVos.isValid(), isFalse);
        ibanVos.when(
          isLeft: (failure) => expect(
            failure,
            equals(const IbanFailure.tooShort(length: iban.length)),
          ),
          isRight: (value) => fail('No debería ser válido'),
        );
      });

      test('Debería rechazar IBAN de 25 caracteres', () {
        // Arrange
        const iban = 'ES15210004184935249195641'; // 25 caracteres

        // Act
        final ibanVos = IbanVos(iban);

        // Assert
        expect(iban.length, equals(25));
        expect(ibanVos.isValid(), isFalse);
        ibanVos.when(
          isLeft: (failure) => expect(
            failure,
            equals(const IbanFailure.tooLong(length: iban.length)),
          ),
          isRight: (value) => fail('No debería ser válido'),
        );
      });

      test(
        'Debería rechazar múltiples espacios en blanco por ser demasiado largo',
        () {
          // Arrange
          const ibanWithMultipleSpaces =
              '   ES15  2100  0418  49  3524  9195  64   ';

          // Act
          final ibanVos = IbanVos(ibanWithMultipleSpaces);

          // Assert - Falla porque con espacios supera los 24 caracteres
          expect(ibanVos.isValid(), isFalse);
          ibanVos.when(
            isLeft: (failure) => expect(
              failure,
              equals(
                IbanFailure.tooLong(
                  length: ibanWithMultipleSpaces.trim().length,
                ),
              ),
            ),
            isRight: (value) =>
                fail('No debería ser válido con espacios múltiples'),
          );
        },
      );

      test('Debería manejar string vacío', () {
        // Arrange & Act
        final ibanVos = IbanVos('');

        // Assert
        expect(ibanVos.isValid(), isFalse);
        ibanVos.when(
          isLeft: (failure) =>
              expect(failure, equals(const IbanFailure.tooShort(length: 0))),
          isRight: (value) => fail('No debería ser válido'),
        );
      });

      test('Debería manejar solo espacios en blanco', () {
        // Arrange & Act
        final ibanVos = IbanVos('    ');

        // Act & Assert
        expect(ibanVos.isValid(), isFalse);
        ibanVos.when(
          isLeft: (failure) =>
              expect(failure, equals(const IbanFailure.tooShort(length: 0))),
          isRight: (value) => fail('No debería ser válido'),
        );
      });

      test('Debería limpiar solo espacios del principio y final con trim', () {
        // Arrange
        const ibanWithLeadingTrailingSpaces = '  ES1521000418493524919564  ';

        // Act
        final ibanVos = IbanVos(ibanWithLeadingTrailingSpaces);

        // Assert - Debería ser válido después del trim
        expect(ibanVos.isValid(), isTrue);
        ibanVos.when(
          isLeft: (failure) => fail('Debería ser válido después del trim'),
          isRight: (value) => expect(value, equals('ES1521000418493524919564')),
        );
      });
    });

    group('Algoritmo de validación checksum', () {
      test(
        'Debería validar correctamente el IBAN especificado (sin espacios)',
        () {
          // Arrange
          const iban = 'ES1521000418493524919564'; // Sin espacios

          // Act
          final ibanVos = IbanVos(iban);

          // Assert
          expect(ibanVos.isValid(), isTrue);
          ibanVos.when(
            isLeft: (failure) => fail('El IBAN específico debería ser válido'),
            isRight: (value) => expect(value, equals(iban)),
          );
        },
      );

      test(
        'Debería rechazar el IBAN especificado con espacios por ser demasiado largo',
        () {
          // Arrange
          const ibanWithSpaces =
              'ES69 2100 0418 45 3524 9195 64'; // Con espacios

          // Act
          final ibanVos = IbanVos(ibanWithSpaces);

          // Assert
          expect(ibanVos.isValid(), isFalse);
          ibanVos.when(
            isLeft: (failure) => expect(
              failure,
              equals(const IbanFailure.tooLong(length: ibanWithSpaces.length)),
            ),
            isRight: (value) => fail('Debería rechazarse por tener espacios'),
          );
        },
      );

      test('Debería validar IBANs españoles válidos', () {
        // Arrange - IBANs españoles válidos de 24 caracteres
        final spanishIbans = [
          'ES1521000418493524919564', // El IBAN completamente válido
          'ES9121000418450200051332', // Otro IBAN español válido calculado
          'ES8023100001180000012345', // IBAN válido del Banco Santander
        ];

        for (final iban in spanishIbans) {
          // Act
          final ibanVos = IbanVos(iban);

          // Assert
          expect(
            ibanVos.isValid(),
            isTrue,
            reason: 'IBAN español $iban debería ser válido',
          );
        }
      });

      test('Debería rechazar checksums incorrectos sistemáticamente', () {
        // Arrange - IBAN base válido con diferentes checksums incorrectos
        const baseIban = 'ES';
        const validRest = '21000418493524919564';
        final invalidChecksums = ['00', '01', '14', '16', '99'];

        for (final checksum in invalidChecksums) {
          // Act
          final invalidIban = baseIban + checksum + validRest;
          final ibanVos = IbanVos(invalidIban);

          // Assert
          expect(
            ibanVos.isValid(),
            isFalse,
            reason: 'Checksum $checksum debería ser inválido',
          );
          ibanVos.when(
            isLeft: (failure) =>
                expect(failure, equals(const IbanFailure.invalidChecksum())),
            isRight: (value) =>
                fail('No debería ser válido con checksum $checksum'),
          );
        }
      });
    });

    group('Integración y compatibilidad', () {
      test('Debería ser inmutable después de la creación', () {
        // Arrange
        const iban = 'ES1521000418493524919564';
        final ibanVos1 = IbanVos(iban);
        final ibanVos2 = IbanVos(iban);

        // Act & Assert
        expect(ibanVos1.isValid(), equals(ibanVos2.isValid()));

        ibanVos1.when(
          isLeft: (failure1) => ibanVos2.when(
            isLeft: (failure2) => expect(failure1, equals(failure2)),
            isRight: (value2) => fail('Deberían tener el mismo estado'),
          ),
          isRight: (value1) => ibanVos2.when(
            isLeft: (failure2) => fail('Deberían tener el mismo estado'),
            isRight: (value2) => expect(value1, equals(value2)),
          ),
        );
      });

      test('Debería manejar la creación repetida del mismo IBAN', () {
        // Arrange
        const iban = 'ES1521000418493524919564';

        // Act
        final ibanVos1 = IbanVos(iban);
        final ibanVos2 = IbanVos(iban);
        final ibanVos3 = IbanVos(iban);

        // Assert
        expect(ibanVos1.isValid(), isTrue);
        expect(ibanVos2.isValid(), isTrue);
        expect(ibanVos3.isValid(), isTrue);

        // Verificar que todos tienen el mismo valor
        ibanVos1.when(
          isLeft: (_) => fail('Debería ser válido'),
          isRight: (value1) {
            ibanVos2.when(
              isLeft: (_) => fail('Debería ser válido'),
              isRight: (value2) {
                ibanVos3.when(
                  isLeft: (_) => fail('Debería ser válido'),
                  isRight: (value3) {
                    expect(value1, equals(value2));
                    expect(value2, equals(value3));
                  },
                );
              },
            );
          },
        );
      });

      test('Debería manejar diferentes tipos de fallos correctamente', () {
        // Arrange - Diferentes tipos de IBANs inválidos
        final testCases = {
          '': const IbanFailure.tooShort(length: 0),
          'ES15210004184935249195': const IbanFailure.tooShort(length: 22),
          'ES152100041849352491956123': const IbanFailure.tooLong(length: 26),
          'es1521000418493524919564': const IbanFailure.invalidFormat(),
          'ES1421000418493524919564':
              const IbanFailure.invalidChecksum(), // checksum incorrecsto
        };

        for (final entry in testCases.entries) {
          // Act
          final ibanVos = IbanVos(entry.key);

          // Assert
          expect(
            ibanVos.isValid(),
            isFalse,
            reason: 'IBAN "${entry.key}" debería ser inválido',
          );
          ibanVos.when(
            isLeft: (failure) => expect(
              failure,
              equals(entry.value),
              reason: 'IBAN "${entry.key}" debería fallar con ${entry.value}',
            ),
            isRight: (value) =>
                fail('IBAN "${entry.key}" no debería ser válido'),
          );
        }
      });
    });
  });
}
