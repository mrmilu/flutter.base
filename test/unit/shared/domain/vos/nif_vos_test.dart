import 'package:flutter_base/src/shared/domain/failures/nif_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/nif_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NifVos', () {
    group('DNIs válidos', () {
      final validDnis = [
        '12345678Z',
        '87654321X',
        '00000000T',
        '99999999R',
        '11111111H',
        '23456789D', // 23456789 % 23 = 9 -> D
        '98765432M', // 98765432 % 23 = 5 -> M
        '13579135G', // 13579135 % 23 = 4 -> G
        '24680246G', // 24680246 % 23 = 4 -> G
        '50505050V', // 50505050 % 23 = 17 -> V
      ];

      for (final dni in validDnis) {
        test('Debería aceptar DNI válido: $dni', () {
          final result = NifVos(dni);
          expect(result.isValid(), isTrue);
          result.when(
            isLeft: (failure) => fail('Debería ser válido: $dni'),
            isRight: (value) => expect(value, equals(dni)),
          );
        });
      }
    });

    group('DNIs inválidos', () {
      group('Por formato incorrecto', () {
        final invalidFormatDnis = [
          '1234567AB', // 9 caracteres, dos letras
          'A2345678Z', // 9 caracteres, letra al inicio
          '123-4567Z', // 9 caracteres, guión
          '123.4567Z', // 9 caracteres, punto
          '123 4567Z', // 9 caracteres, espacio
          '123456789', // 9 caracteres, solo números
          '12a45678Z', // 9 caracteres, letra en medio
          '12345@78Z', // 9 caracteres, símbolo en medio
          '12345 78Z', // 9 caracteres, espacio en medio
        ];

        for (final dni in invalidFormatDnis) {
          test('Debería rechazar DNI con formato inválido: "$dni"', () {
            final result = NifVos(dni);
            expect(result.isValid(), isFalse);
            result.when(
              isLeft: (failure) =>
                  expect(failure, equals(const NifFailure.invalid())),
              isRight: (_) => fail('Se esperaba un fallo, pero fue exitoso'),
            );
          });
        }
      });

      group('Por longitud incorrecta (tooShort)', () {
        final tooShortDnis = [
          '1234567a', // 8 caracteres, minúscula
          '1234567Ñ', // 8 caracteres, letra no válida
          '123456A8', // 8 caracteres, letra en posición incorrecta
          '12345678', // 8 caracteres, sin letra
          '1234567#', // 8 caracteres, símbolo
        ];

        for (final dni in tooShortDnis) {
          test('Debería rechazar DNI muy corto: "$dni"', () {
            final result = NifVos(dni);
            expect(result.isValid(), isFalse);
            result.when(
              isLeft: (failure) =>
                  expect(failure, equals(const NifFailure.tooShort(length: 9))),
              isRight: (_) => fail('Se esperaba un fallo, pero fue exitoso'),
            );
          });
        }
      });

      group('Por longitud incorrecta (tooLong)', () {
        test('Debería rechazar DNI demasiado largo', () {
          final result = NifVos('1234567890');
          expect(result.isValid(), isFalse);
          result.when(
            isLeft: (failure) =>
                expect(failure, equals(const NifFailure.tooLong(length: 9))),
            isRight: (_) => fail('Se esperaba un fallo, pero fue exitoso'),
          );
        });
      });

      group('Por letra de control incorrecta', () {
        final invalidControlLetters = [
          '12345678A', // Debería ser Z
          '87654321A', // Debería ser X
          '00000000A', // Debería ser T
          '99999999A', // Debería ser R
          '11111111A', // Debería ser H
          '23456789A', // Debería ser D
          '98765432A', // Debería ser M
          '13579135A', // Debería ser G
          '24680246A', // Debería ser G
          '50505050A', // Debería ser V
        ];

        for (final dni in invalidControlLetters) {
          test(
            'Debería rechazar DNI con letra de control incorrecta: $dni',
            () {
              final result = NifVos(dni);
              expect(result.isValid(), isFalse);
              result.when(
                isLeft: (failure) =>
                    expect(failure, equals(const NifFailure.invalid())),
                isRight: (_) => fail('Se esperaba un fallo, pero fue exitoso'),
              );
            },
          );
        }
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        final result = NifVos('  12345678Z  ');
        expect(result.isValid(), isTrue);
      });

      test('Debería calcular correctamente letras de control', () {
        final testCases = {
          '00000000': 'T', // 0 % 23 = 0 -> T
          '12345678': 'Z', // Verificar este cálculo
          '99999999': 'R', // 99999999 % 23 = 22 -> R
        };

        for (final entry in testCases.entries) {
          final dni = '${entry.key}${entry.value}';
          final result = NifVos(dni);
          expect(
            result.isValid(),
            isTrue,
            reason: 'DNI $dni debería ser válido',
          );
        }
      });

      test('Debería aceptar todas las letras válidas de la tabla DNI', () {
        const validLetters = [
          'T',
          'R',
          'W',
          'A',
          'G',
          'M',
          'Y',
          'F',
          'P',
          'D',
          'X',
          'B',
          'N',
          'J',
          'Z',
          'S',
          'Q',
          'V',
          'H',
          'L',
          'C',
          'I',
          'E',
        ];

        for (int i = 0; i < validLetters.length; i++) {
          final number = i.toString().padLeft(8, '0');
          final dni = '$number${validLetters[i]}';
          final result = NifVos(dni);
          expect(
            result.isValid(),
            isTrue,
            reason: 'DNI $dni debería ser válido',
          );
        }
      });
    });

    group('Tests de casos límite', () {
      test('Debería manejar números con ceros iniciales', () {
        final dni = '00012345V'; // 12345 % 23 = 17 -> V
        final result = NifVos(dni);
        expect(
          result.isValid(),
          isTrue,
          reason: 'DNI con ceros iniciales "$dni" debería ser válido',
        );
      });

      test('Debería manejar números máximos', () {
        final dni = '99999999R'; // 99999999 % 23 = 22 -> R
        final result = NifVos(dni);
        expect(
          result.isValid(),
          isTrue,
          reason: 'DNI con números máximos "$dni" debería ser válido',
        );
      });
    });

    group('Tests de casos de uso reales', () {
      test('Debería aceptar DNIs típicos españoles', () {
        final realDnis = [
          '30123456B', // 30123456 % 23 = 11 -> B
          '28765432E', // 28765432 % 23 = 22 -> E
          '41987654G', // 41987654 % 23 = 4 -> G
        ];

        for (final dni in realDnis) {
          final result = NifVos(dni);
          expect(
            result.isValid(),
            isTrue,
            reason: 'DNI real $dni debería ser válido',
          );
        }
      });

      test('Debería mantener el formato original', () {
        const originalDni = '12345678Z';
        final result = NifVos(originalDni);

        result.when(
          isLeft: (_) => fail('No debería fallar'),
          isRight: (value) => expect(value, equals(originalDni)),
        );
      });

      test('Debería funcionar con entrada normalizada', () {
        final result = NifVos('  12345678Z  ');

        result.when(
          isLeft: (_) => fail('No debería fallar con espacios'),
          isRight: (value) => expect(value, equals('12345678Z')),
        );
      });
    });

    group('Tests de validación de algoritmo', () {
      test('Debería validar algoritmo de cálculo completo', () {
        const letters = [
          'T',
          'R',
          'W',
          'A',
          'G',
          'M',
          'Y',
          'F',
          'P',
          'D',
          'X',
          'B',
          'N',
          'J',
          'Z',
          'S',
          'Q',
          'V',
          'H',
          'L',
          'C',
          'I',
          'E',
        ];

        for (int remainder = 0; remainder < 23; remainder++) {
          final number = remainder.toString().padLeft(8, '0');
          final expectedLetter = letters[remainder];
          final dni = '$number$expectedLetter';

          final result = NifVos(dni);
          expect(
            result.isValid(),
            isTrue,
            reason: 'DNI $dni (resto $remainder) debería ser válido',
          );
        }
      });

      test('Debería fallar validación con cálculo incorrecto', () {
        const validNumber = '12345678';
        const wrongLetter = 'A'; // Debería ser Z
        final wrongDni = '$validNumber$wrongLetter';

        final result = NifVos(wrongDni);
        expect(result.isValid(), isFalse);
        result.when(
          isLeft: (failure) =>
              expect(failure, equals(const NifFailure.invalid())),
          isRight: (_) => fail('Debería fallar con letra incorrecta'),
        );
      });
    });
  });
}
