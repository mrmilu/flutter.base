import 'package:flutter_base/src/shared/domain/failures/power_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/power_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PowerVos', () {
    group('Valores de potencia válidos', () {
      test('Debería aceptar valores válidos dentro del rango', () {
        // Arrange
        final validPowers = [
          {'input': '1.5', 'min': 1.0, 'max': 10.0},
          {'input': '5.0', 'min': 1.0, 'max': 10.0},
          {'input': '10.0', 'min': 1.0, 'max': 10.0},
          {'input': '1.0', 'min': 1.0, 'max': 10.0}, // Valor mínimo exacto
          {'input': '500', 'min': 100.0, 'max': 1000.0},
          {'input': '0.5', 'min': 0.0, 'max': 1.0},
        ];

        for (final testCase in validPowers) {
          // Act
          final powerVos = PowerVos(
            testCase['input'] as String,
            min: testCase['min'] as double,
            max: testCase['max'] as double,
          );

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason:
                'Potencia "${testCase['input']}" debería ser válida entre ${testCase['min']} y ${testCase['max']}',
          );
          powerVos.when(
            isLeft: (failure) =>
                fail('Debería ser válido: ${testCase['input']}'),
            isRight: (value) => expect(value, equals(testCase['input'])),
          );
        }
      });

      test('Debería aceptar números con formato decimal usando punto', () {
        // Arrange
        final decimalPowers = [
          '1.5',
          '2.75',
          '10.999',
          '0.1',
          '3.14159',
        ];

        for (final power in decimalPowers) {
          // Act
          final powerVos = PowerVos(power, min: 0.0, max: 20.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Potencia decimal "$power" debería ser válida',
          );
        }
      });

      test('Debería aceptar números con formato decimal usando coma', () {
        // Arrange
        final commaPowers = [
          '1,5',
          '2,75',
          '10,999',
          '0,1',
          '3,14159',
        ];

        for (final power in commaPowers) {
          // Act
          final powerVos = PowerVos(power, min: 0.0, max: 20.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Potencia con coma "$power" debería ser válida',
          );
        }
      });

      test('Debería aceptar números enteros', () {
        // Arrange
        final integerPowers = [
          '1',
          '5',
          '10',
          '100',
          '1000',
        ];

        for (final power in integerPowers) {
          // Act
          final powerVos = PowerVos(power, min: 0.0, max: 2000.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Potencia entera "$power" debería ser válida',
          );
        }
      });

      test('Debería aceptar números con signo positivo válidos', () {
        // Arrange
        final signedPowers = [
          '+1.5',
          '+5.0',
          '+10.0',
        ];

        for (final power in signedPowers) {
          // Act
          final powerVos = PowerVos(power, min: 1.0, max: 10.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Potencia con signo positivo "$power" debería ser válida',
          );
        }
      });

      test('Debería aceptar números negativos válidos en rango negativo', () {
        // Arrange
        final negativePowers = [
          '-1.5',
          '-5.0',
          '-10.0',
        ];

        for (final power in negativePowers) {
          // Act
          final powerVos = PowerVos(power, min: -10.0, max: 0.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason:
                'Potencia negativa "$power" debería ser válida en rango negativo',
          );
        }
      });
    });

    group('Valores de potencia inválidos', () {
      group('Por estar vacío', () {
        final emptyInputs = [
          '',
          '   ',
          '\t',
          '\n',
        ];

        for (final input in emptyInputs) {
          test('Debería rechazar entrada vacía: "$input"', () {
            // Arrange & Act
            final powerVos = PowerVos(input, min: 1.0, max: 10.0);

            // Assert
            expect(powerVos.isValid(), isFalse);
            powerVos.when(
              isLeft: (failure) => expect(failure, isA<PowerFailureEmpty>()),
              isRight: (value) =>
                  fail('Debería retornar failure para entrada vacía'),
            );
          });
        }
      });

      group('Por formato inválido', () {
        final invalidFormats = [
          // Texto que no es número
          'abc',
          'texto',
          'kW',
          'watts',

          // Múltiples puntos/comas
          '1.2.3',
          '1,2,3',
          '1.,2',

          // Caracteres especiales
          '1.5%',
          '2kW',
          '3.0W',

          // Formatos mixtos
          '1.5,2',
          '1,5.2',

          // Solo signos
          '+',
          '-',
          '.',
          ',',
        ];

        for (final input in invalidFormats) {
          test('Debería rechazar formato inválido: "$input"', () {
            // Arrange & Act
            final powerVos = PowerVos(input, min: 1.0, max: 10.0);

            // Assert
            expect(powerVos.isValid(), isFalse);
            powerVos.when(
              isLeft: (failure) => expect(failure, isA<PowerFailureInvalid>()),
              isRight: (value) =>
                  fail('Debería retornar failure para formato inválido'),
            );
          });
        }
      });

      group('Por valor menor al mínimo', () {
        test('Debería rechazar valores menores al mínimo', () {
          // Arrange
          final testCases = [
            {'input': '0.5', 'min': 1.0, 'max': 10.0},
            {'input': '0.9', 'min': 1.0, 'max': 10.0},
            {'input': '5.0', 'min': 10.0, 'max': 20.0},
            {'input': '-1.0', 'min': 0.0, 'max': 10.0},
            {'input': '99', 'min': 100.0, 'max': 1000.0},
            {
              'input': '-2.5',
              'min': 1.0,
              'max': 10.0,
            }, // Número negativo fuera de rango
          ];

          for (final testCase in testCases) {
            // Act
            final powerVos = PowerVos(
              testCase['input'] as String,
              min: testCase['min'] as double,
              max: testCase['max'] as double,
            );

            // Assert
            expect(
              powerVos.isValid(),
              isFalse,
              reason:
                  'Potencia "${testCase['input']}" debería ser menor al mínimo ${testCase['min']}',
            );
            powerVos.when(
              isLeft: (failure) => expect(failure, isA<PowerFailureLess>()),
              isRight: (value) =>
                  fail('Debería retornar failure para valor menor'),
            );
          }
        });
      });

      group('Por valor mayor al máximo', () {
        test('Debería rechazar valores mayores al máximo', () {
          // Arrange
          final testCases = [
            {'input': '10.1', 'min': 1.0, 'max': 10.0},
            {'input': '15.0', 'min': 1.0, 'max': 10.0},
            {'input': '25.0', 'min': 10.0, 'max': 20.0},
            {'input': '1001', 'min': 100.0, 'max': 1000.0},
            {'input': '2.0', 'min': 0.0, 'max': 1.0},
          ];

          for (final testCase in testCases) {
            // Act
            final powerVos = PowerVos(
              testCase['input'] as String,
              min: testCase['min'] as double,
              max: testCase['max'] as double,
            );

            // Assert
            expect(
              powerVos.isValid(),
              isFalse,
              reason:
                  'Potencia "${testCase['input']}" debería ser mayor al máximo ${testCase['max']}',
            );
            powerVos.when(
              isLeft: (failure) => expect(failure, isA<PowerFailureMore>()),
              isRight: (value) =>
                  fail('Debería retornar failure para valor mayor'),
            );
          }
        });
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final powerWithSpaces = PowerVos('  5.5  ', min: 1.0, max: 10.0);

        // Assert
        expect(powerWithSpaces.isValid(), isTrue);
        powerWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals('5.5')),
        );
      });

      test('Debería convertir comas a puntos internamente', () {
        // Arrange & Act
        final powerWithComma = PowerVos('5,75', min: 1.0, max: 10.0);

        // Assert
        expect(powerWithComma.isValid(), isTrue);
        powerWithComma.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) =>
              expect(value, equals('5,75')), // Mantiene formato original
        );
      });

      test('Debería validar correctamente valores límite', () {
        // Arrange & Act
        final minValue = PowerVos('1.0', min: 1.0, max: 10.0);
        final maxValue = PowerVos('10.0', min: 1.0, max: 10.0);

        // Assert
        expect(minValue.isValid(), isTrue);
        expect(maxValue.isValid(), isTrue);
      });

      test('Debería fallar justo fuera de los límites', () {
        // Arrange & Act
        final justBelowMin = PowerVos('0.999', min: 1.0, max: 10.0);
        final justAboveMax = PowerVos('10.001', min: 1.0, max: 10.0);

        // Assert
        expect(justBelowMin.isValid(), isFalse);
        expect(justAboveMax.isValid(), isFalse);
      });

      test('Debería preservar el formato original del input', () {
        // Arrange
        final originalInputs = [
          '5.0',
          '5,0',
          '05.00',
          '5',
        ];

        for (final input in originalInputs) {
          // Act
          final powerVos = PowerVos(input, min: 1.0, max: 10.0);

          // Assert
          expect(powerVos.isValid(), isTrue);
          powerVos.when(
            isLeft: (failure) => fail('Debería ser válido'),
            isRight: (value) => expect(value, equals(input.trim())),
          );
        }
      });
    });

    group('Tests de casos límite específicos', () {
      test('Debería manejar cero correctamente', () {
        // Arrange & Act
        final zeroValue = PowerVos('0', min: 0.0, max: 10.0);
        final zeroDecimal = PowerVos('0.0', min: 0.0, max: 10.0);
        final zeroComma = PowerVos('0,0', min: 0.0, max: 10.0);

        // Assert
        expect(zeroValue.isValid(), isTrue);
        expect(zeroDecimal.isValid(), isTrue);
        expect(zeroComma.isValid(), isTrue);
      });

      test('Debería rechazar cero cuando está fuera del rango', () {
        // Arrange & Act
        final zeroOutOfRange = PowerVos('0', min: 1.0, max: 10.0);

        // Assert
        expect(zeroOutOfRange.isValid(), isFalse);
        zeroOutOfRange.when(
          isLeft: (failure) => expect(failure, isA<PowerFailureLess>()),
          isRight: (value) => fail('Debería fallar para cero fuera de rango'),
        );
      });

      test('Debería validar cuando min y max son iguales', () {
        // Arrange & Act
        final exactValue = PowerVos('5.0', min: 5.0, max: 5.0);
        final wrongValue = PowerVos('5.1', min: 5.0, max: 5.0);

        // Assert
        expect(exactValue.isValid(), isTrue);
        expect(wrongValue.isValid(), isFalse);
      });

      test('Debería manejar números muy pequeños', () {
        // Arrange
        final smallNumbers = [
          '0.001',
          '0.0001',
          '0.00001',
        ];

        for (final number in smallNumbers) {
          // Act
          final powerVos = PowerVos(number, min: 0.0, max: 1.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Número pequeño "$number" debería ser válido',
          );
        }
      });

      test('Debería manejar números muy grandes', () {
        // Arrange
        final largeNumbers = [
          '1000000',
          '999999.999',
          '1000000.0',
        ];

        for (final number in largeNumbers) {
          // Act
          final powerVos = PowerVos(number, min: 500000.0, max: 2000000.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Número grande "$number" debería ser válido',
          );
        }
      });

      test('Debería manejar números con muchos decimales', () {
        // Arrange
        final precisionNumbers = [
          '3.141592653589793',
          '2.718281828459045',
          '1.4142135623730951',
        ];

        for (final number in precisionNumbers) {
          // Act
          final powerVos = PowerVos(number, min: 1.0, max: 5.0);

          // Assert
          expect(
            powerVos.isValid(),
            isTrue,
            reason: 'Número de precisión "$number" debería ser válido',
          );
        }
      });

      test('Debería funcionar con diferentes rangos de valores', () {
        // Arrange & Act
        final microRange = PowerVos('0.005', min: 0.001, max: 0.01);
        final largeRange = PowerVos('50000', min: 10000.0, max: 100000.0);
        final negativeRange = PowerVos('-5.0', min: -10.0, max: 0.0);

        // Assert
        expect(microRange.isValid(), isTrue);
        expect(largeRange.isValid(), isTrue);
        expect(negativeRange.isValid(), isTrue);
      });
    });
  });
}
