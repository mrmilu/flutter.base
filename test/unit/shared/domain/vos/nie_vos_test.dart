import 'package:flutter_base/src/shared/domain/failures/nie_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/nie_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NieVos', () {
    group('NIEs válidos', () {
      final validNies = [
        'X1234567L', // NIE válido con X
        'Y7654321G', // NIE válido con Y
        'Z9876543A', // NIE válido con Z
        'X0000000T', // NIE válido con números bajos
        'Y9999999G', // NIE válido con números altos
        'Z5555555W', // NIE válido con números medios
        'X1111111G', // NIE válido con números repetidos
        'Y2468024T', // NIE válido con patrón par
        'Z1357913I', // NIE válido con patrón impar
        'X8765432V', // NIE válido descendente
      ];

      for (final nie in validNies) {
        test('Debería aceptar NIE válido: $nie', () {
          // Arrange & Act
          final nieVos = NieVos(nie);

          // Assert
          expect(nieVos.isValid(), isTrue);
          nieVos.when(
            isLeft: (failure) => fail('Debería ser válido: $nie'),
            isRight: (value) => expect(value, equals(nie)),
          );
        });
      }
    });

    group('NIEs inválidos', () {
      group('Por formato incorrecto', () {
        final invalidFormatNies = [
          'A1234567L', // Primera letra no válida (no X, Y, Z)
          'X123456A7', // Letra en posición incorrecta
          'X12345678', // Sin letra final
          '12345678L', // Sin letra inicial
          'X1234567l', // Letra final en minúscula
          'x1234567L', // Letra inicial en minúscula
          'X123456AL', // Letra en medio de números
          'B1234567L', // Letra inicial inválida
          'X1234567Ñ', // Letra final con ñ
          '1X234567L', // Letra X en posición incorrecta
          'X1a34567L', // Letra minúscula en números
          'X1234567#', // Símbolo en lugar de letra
        ];

        for (final nie in invalidFormatNies) {
          test('Debería rechazar NIE con formato inválido: "$nie"', () {
            // Arrange & Act
            final nieVos = NieVos(nie);

            // Assert
            expect(nieVos.isValid(), isFalse);
            nieVos.when(
              isLeft: (failure) => expect(failure, NieFailure.invalidFormat),
              isRight: (value) =>
                  fail('Debería retornar failure para formato inválido'),
            );
          });
        }
      });

      group('Por longitud mayor a 9 caracteres', () {
        final tooLongNies = [
          'X12-34567L', // Con guión (10 caracteres)
          'X12.34567L', // Con punto (10 caracteres)
          'X12 34567L', // Con espacio (10 caracteres)
          'XX1234567L', // Dos letras iniciales (10 caracteres)
          'X1234567LL', // Dos letras finales (10 caracteres)
        ];

        for (final nie in tooLongNies) {
          test('Debería rechazar NIE demasiado largo: "$nie"', () {
            // Arrange & Act
            final nieVos = NieVos(nie);

            // Assert
            expect(nieVos.isValid(), isFalse);
            nieVos.when(
              isLeft: (failure) => expect(failure, NieFailure.tooLong),
              isRight: (value) =>
                  fail('Debería retornar failure para NIE muy largo'),
            );
          });
        }
      });

      group('Por longitud incorrecta', () {
        test('Debería rechazar NIE demasiado largo', () {
          // Arrange
          final tooLongNies = [
            'X12345678L', // 10 caracteres
            'X123456789L', // 11 caracteres
            'X1234567890L', // 12 caracteres
            'X1234567L123', // 12 caracteres con números extra
            'X1234567LABC', // 12 caracteres con letras extra
          ];

          for (final nie in tooLongNies) {
            // Act
            final nieVos = NieVos(nie);

            // Assert
            expect(nieVos.isValid(), isFalse);
            nieVos.when(
              isLeft: (failure) => expect(failure, NieFailure.tooLong),
              isRight: (value) =>
                  fail('Debería retornar failure para NIE muy largo'),
            );
          }
        });

        test('Debería rechazar NIE demasiado corto', () {
          // Arrange
          final tooShortNies = [
            '', // Vacío
            'X', // Solo letra inicial
            'X1', // 2 caracteres
            'X12', // 3 caracteres
            'X123', // 4 caracteres
            'X1234', // 5 caracteres
            'X12345', // 6 caracteres
            'X123456', // 7 caracteres
            'X1234567', // 8 caracteres (sin letra final)
          ];

          for (final nie in tooShortNies) {
            // Act
            final nieVos = NieVos(nie);

            // Assert
            expect(nieVos.isValid(), isFalse);
            nieVos.when(
              isLeft: (failure) => expect(failure, NieFailure.invalidFormat),
              isRight: (value) =>
                  fail('Debería retornar failure para NIE muy corto'),
            );
          }
        });
      });

      group('Por letra de control incorrecta', () {
        final incorrectControlLetterNies = [
          'X1234567A', // Debería ser L
          'Y7654321A', // Debería ser G
          'Z9876543Z', // Debería ser A
          'X0000000A', // Debería ser T
          'Y9999999A', // Debería ser G
          'Z5555555A', // Debería ser W
          'X1111111A', // Debería ser G
          'Y2468024A', // Debería ser T
          'Z1357913A', // Debería ser I
          'X8765432A', // Debería ser V
        ];

        for (final nie in incorrectControlLetterNies) {
          test(
            'Debería rechazar NIE con letra de control incorrecta: $nie',
            () {
              // Arrange & Act
              final nieVos = NieVos(nie);

              // Assert
              expect(nieVos.isValid(), isFalse);
              nieVos.when(
                isLeft: (failure) => expect(failure, NieFailure.invalidFormat),
                isRight: (value) => fail(
                  'Debería retornar failure para letra de control incorrecta',
                ),
              );
            },
          );
        }
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange
        final nieWithSpaces = '  X1234567L  ';

        // Act
        final nieVos = NieVos(nieWithSpaces);

        // Assert
        expect(nieVos.isValid(), isTrue);
        nieVos.when(
          isLeft: (failure) => fail('Debería ser válido después del trim'),
          isRight: (value) => expect(value, equals('X1234567L')),
        );
      });

      test('Debería validar diferentes prefijos correctamente', () {
        // Arrange
        final testCases = [
          {'prefix': 'X', 'validNie': 'X1234567L'},
          {'prefix': 'Y', 'validNie': 'Y7654321G'},
          {'prefix': 'Z', 'validNie': 'Z9876543A'},
        ];

        for (final testCase in testCases) {
          // Act
          final nieVos = NieVos(testCase['validNie'] as String);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE con prefijo ${testCase['prefix']} debería ser válido',
          );
        }
      });

      test('Debería rechazar todos los prefijos no válidos', () {
        // Arrange
        final invalidPrefixes = ['A', 'B', 'C', 'W', 'E', 'F', 'G', 'H'];

        for (final prefix in invalidPrefixes) {
          // Act
          final nieVos = NieVos('${prefix}1234567L');

          // Assert
          expect(
            nieVos.isValid(),
            isFalse,
            reason: 'NIE con prefijo $prefix debería ser inválido',
          );
        }
      });

      test('Debería calcular correctamente letras de control para X', () {
        // Arrange - Casos específicos para prefijo X (0)
        final testCases = [
          {'numbers': '0000000', 'expectedLetter': 'T'}, // 0 % 23 = 0 -> T
          {'numbers': '0000001', 'expectedLetter': 'R'}, // 1 % 23 = 1 -> R
          {'numbers': '0000022', 'expectedLetter': 'E'}, // 22 % 23 = 22 -> E
          {'numbers': '0000023', 'expectedLetter': 'T'}, // 23 % 23 = 0 -> T
        ];

        for (final testCase in testCases) {
          // Act
          final nie = 'X${testCase['numbers']}${testCase['expectedLetter']}';
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE $nie debería ser válido',
          );
        }
      });

      test('Debería calcular correctamente letras de control para Y', () {
        // Arrange - Casos específicos para prefijo Y (1)
        final testCases = [
          {
            'numbers': '0000000',
            'expectedLetter': 'Z',
          }, // 10000000 % 23 = 14 -> Z
          {
            'numbers': '0000001',
            'expectedLetter': 'S',
          }, // 10000001 % 23 = 15 -> S
          {
            'numbers': '9999999',
            'expectedLetter': 'G',
          }, // 19999999 % 23 = 4 -> G
        ];

        for (final testCase in testCases) {
          // Act
          final nie = 'Y${testCase['numbers']}${testCase['expectedLetter']}';
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE $nie debería ser válido',
          );
        }
      });

      test('Debería calcular correctamente letras de control para Z', () {
        // Arrange - Casos específicos para prefijo Z (2)
        final testCases = [
          {
            'numbers': '0000000',
            'expectedLetter': 'M',
          }, // 20000000 % 23 = 5 -> M
          {
            'numbers': '0000001',
            'expectedLetter': 'Y',
          }, // 20000001 % 23 = 6 -> Y
          {
            'numbers': '9999999',
            'expectedLetter': 'H',
          }, // 29999999 % 23 = 18 -> H
        ];

        for (final testCase in testCases) {
          // Act
          final nie = 'Z${testCase['numbers']}${testCase['expectedLetter']}';
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE $nie debería ser válido',
          );
        }
      });
    });

    group('Tests de casos límite', () {
      test('Debería manejar números con ceros iniciales', () {
        // Arrange
        final niesWithLeadingZeros = [
          'X0000001R',
          'Y0000001S',
          'Z0000001Y',
          'X0012345V',
          'Y0123456Y',
          'Z0234567H',
        ];

        for (final nie in niesWithLeadingZeros) {
          // Act
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE con ceros iniciales "$nie" debería ser válido',
          );
        }
      });

      test('Debería manejar números máximos', () {
        // Arrange
        final niesWithMaxNumbers = [
          'X9999999J',
          'Y9999999G',
          'Z9999999H',
        ];

        for (final nie in niesWithMaxNumbers) {
          // Act
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE con números máximos "$nie" debería ser válido',
          );
        }
      });

      test('Debería rechazar strings que parecen NIE pero no lo son', () {
        // Arrange
        final almostValidNies = [
          'X1234567', // Sin letra final
          '1234567L', // Sin letra inicial
          'X123456L7', // Posiciones intercambiadas
          'XY234567L', // Dos letras iniciales
          'X1234567LL', // Dos letras finales
          'X-1234567L', // Con guión
          'X+1234567L', // Con signo más
        ];

        for (final nie in almostValidNies) {
          // Act
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isFalse,
            reason: 'String que parece NIE "$nie" debería ser inválido',
          );
        }
      });
    });

    group('Tests de casos de uso reales', () {
      test('Debería aceptar NIEs típicos de extranjeros', () {
        // Arrange - NIEs reales válidos (calculados correctamente)
        final realNies = [
          'X1234567L',
          'Y7654321G',
          'Z9876543A',
          'X0987654B',
          'Y2468024T',
        ];

        for (final nie in realNies) {
          // Act
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'NIE típico "$nie" debería ser válido',
          );
        }
      });

      test('Debería mantener el formato original', () {
        // Arrange
        final originalNie = 'X1234567L';

        // Act
        final nieVos = NieVos(originalNie);

        // Assert
        expect(nieVos.isValid(), isTrue);
        nieVos.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals(originalNie)),
        );
      });

      test('Debería funcionar con entrada normalizada', () {
        // Arrange
        final nieWithExtraSpaces = '   X1234567L   ';

        // Act
        final nieVos = NieVos(nieWithExtraSpaces);

        // Assert
        expect(nieVos.isValid(), isTrue);
        nieVos.when(
          isLeft: (failure) => fail('Debería ser válido después del trim'),
          isRight: (value) => expect(value, equals('X1234567L')),
        );
      });
    });

    group('Tests de validación de algoritmo', () {
      test('Debería validar algoritmo de cálculo completo', () {
        // Arrange - Test exhaustivo del algoritmo
        final algorithmTests = [
          {'nie': 'X0000000T', 'calculation': '0 % 23 = 0 -> T'},
          {'nie': 'X0000001R', 'calculation': '1 % 23 = 1 -> R'},
          {'nie': 'Y0000000Z', 'calculation': '10000000 % 23 = 14 -> Z'},
          {'nie': 'Z0000000M', 'calculation': '20000000 % 23 = 5 -> M'},
        ];

        for (final test in algorithmTests) {
          // Act
          final nieVos = NieVos(test['nie'] as String);

          // Assert
          expect(
            nieVos.isValid(),
            isTrue,
            reason: 'Algoritmo ${test['calculation']} debería ser correcto',
          );
        }
      });

      test('Debería fallar validación con cálculo incorrecto', () {
        // Arrange - NIEs con cálculo intencionalmente incorrecto
        final incorrectCalculations = [
          'X0000000R', // Debería ser T
          'X0000001T', // Debería ser R
          'Y0000000T', // Debería ser Z
          'Z0000000T', // Debería ser M
        ];

        for (final nie in incorrectCalculations) {
          // Act
          final nieVos = NieVos(nie);

          // Assert
          expect(
            nieVos.isValid(),
            isFalse,
            reason: 'NIE con cálculo incorrecto "$nie" debería ser inválido',
          );
        }
      });
    });
  });
}
