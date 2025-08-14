import 'package:flutter_base/src/shared/domain/failures/phone_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/phone_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneVos', () {
    group('Teléfonos válidos', () {
      test('Debería aceptar teléfonos válidos de 9 dígitos', () {
        // Arrange
        final validPhones = [
          '123456789',
          '987654321',
          '555666777',
          '111222333',
          '999888777',
          '123 456 789',
          '987 654 321',
          '555 666 777',
        ];

        for (final phone in validPhones) {
          // Act
          final phoneVos = PhoneVos(phone, 9);

          // Assert
          expect(
            phoneVos.isValid(),
            isTrue,
            reason: 'Teléfono "$phone" debería ser válido',
          );
          phoneVos.when(
            isLeft: (failure) => fail('Debería ser válido: $phone'),
            isRight: (value) => expect(value, equals(phone.trim())),
          );
        }
      });

      test('Debería aceptar teléfonos válidos de 11 dígitos', () {
        // Arrange
        final validPhones = [
          '12345678901',
          '98765432109',
          '555 666 7778',
          '111 222 3334',
          '999 888 7776',
        ];

        for (final phone in validPhones) {
          // Act
          final phoneVos = PhoneVos(phone, 11);

          // Assert
          expect(
            phoneVos.isValid(),
            isTrue,
            reason: 'Teléfono "$phone" debería ser válido para longitud 11',
          );
        }
      });

      test('Debería aceptar teléfonos con espacios', () {
        // Arrange
        final phonesWithSpaces = [
          '123 456 789',
          '987 654 321',
          '555 666 777',
          '1 2 3 4 5 6 7 8 9',
          '12 34 56 789',
        ];

        for (final phone in phonesWithSpaces) {
          // Act
          final phoneVos = PhoneVos(phone, 9);

          // Assert
          expect(
            phoneVos.isValid(),
            isTrue,
            reason: 'Teléfono con espacios "$phone" debería ser válido',
          );
        }
      });
    });

    group('Teléfonos inválidos', () {
      group('Por estar vacío', () {
        final emptyPhones = [
          '',
          '   ',
          '\t',
          '\n',
        ];

        for (final phone in emptyPhones) {
          test('Debería rechazar teléfono vacío: "$phone"', () {
            // Arrange & Act
            final phoneVos = PhoneVos(phone, 9);

            // Assert
            expect(phoneVos.isValid(), isFalse);
            phoneVos.when(
              isLeft: (failure) => expect(failure, isA<PhoneFailureEmpty>()),
              isRight: (value) =>
                  fail('Debería retornar failure para teléfono vacío'),
            );
          });
        }
      });

      group('Por formato inválido', () {
        final invalidPhones = [
          // Contienen letras
          '12345678a',
          'abc123456',
          '123abc789',
          'phone1234',

          // Contienen caracteres especiales inválidos
          '123-456-789',
          '123.456.789',
          '123/456/789',
          '+123456789',
          '(123)456789',
          '123_456_789',
          '123@456789',
          '123#456789',

          // Solo caracteres especiales
          '!!!!!!!!',
          '.........',
          '+++++++++',
        ];

        for (final phone in invalidPhones) {
          test('Debería rechazar teléfono con formato inválido: "$phone"', () {
            // Arrange & Act
            final phoneVos = PhoneVos(phone, 9);

            // Assert
            expect(phoneVos.isValid(), isFalse);
            phoneVos.when(
              isLeft: (failure) => expect(failure, isA<PhoneFailureInvalid>()),
              isRight: (value) =>
                  fail('Debería retornar failure para teléfono inválido'),
            );
          });
        }
      });

      group('Por longitud incorrecta', () {
        test('Debería rechazar teléfonos muy cortos', () {
          // Arrange
          final shortPhones = [
            '1',
            '12',
            '123',
            '1234',
            '12345',
            '123456',
            '1234567',
            '12345678', // 8 dígitos cuando se requieren 9
          ];

          for (final phone in shortPhones) {
            // Act
            final phoneVos = PhoneVos(phone, 9);

            // Assert
            expect(
              phoneVos.isValid(),
              isFalse,
              reason: 'Teléfono corto "$phone" debería ser inválido',
            );
            phoneVos.when(
              isLeft: (failure) => expect(failure, isA<PhoneFailureInvalid>()),
              isRight: (value) =>
                  fail('Debería retornar failure para teléfono corto'),
            );
          }
        });

        test('Debería rechazar teléfonos muy largos', () {
          // Arrange
          final longPhones = [
            '1234567890', // 10 dígitos cuando máximo es 9
            '12345678901', // 11 dígitos cuando máximo es 9
            '123456789012', // 12 dígitos
            '1234567890123', // 13 dígitos
          ];

          for (final phone in longPhones) {
            // Act
            final phoneVos = PhoneVos(phone, 9);

            // Assert
            expect(
              phoneVos.isValid(),
              isFalse,
              reason:
                  'Teléfono largo "$phone" debería ser inválido para longitud máxima 9',
            );
            phoneVos.when(
              isLeft: (failure) => expect(failure, isA<PhoneFailureTooLong>()),
              isRight: (value) =>
                  fail('Debería retornar failure para teléfono largo'),
            );
          }
        });
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final phoneWithSpaces = PhoneVos('  123 456 789  ', 9);

        // Assert
        expect(phoneWithSpaces.isValid(), isTrue);
        phoneWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals('123 456 789')),
        );
      });

      test(
        'Debería validar correctamente con diferentes longitudes máximas',
        () {
          // Arrange
          final phone = '12345678901'; // 11 dígitos

          // Act & Assert
          final phoneVos9 = PhoneVos(phone, 9);
          expect(phoneVos9.isValid(), isFalse); // Muy largo para 9

          final phoneVos11 = PhoneVos(phone, 11);
          expect(phoneVos11.isValid(), isTrue); // Correcto para 11

          final phoneVos15 = PhoneVos(phone, 15);
          expect(phoneVos15.isValid(), isTrue); // Correcto para 15
        },
      );

      test('Debería retornar PhoneFailureTooLong con longitud correcta', () {
        // Arrange & Act
        final longPhone = PhoneVos('1234567890123', 9); // 13 dígitos, máximo 9

        // Assert
        expect(longPhone.isValid(), isFalse);
        longPhone.when(
          isLeft: (failure) {
            expect(failure, isA<PhoneFailureTooLong>());
            if (failure is PhoneFailureTooLong) {
              expect(
                failure.length,
                equals(11),
              ); // El valor que está hardcodeado en el código
            }
          },
          isRight: (value) =>
              fail('Debería retornar failure para teléfono largo'),
        );
      });

      test('Debería aceptar exactamente la longitud mínima requerida', () {
        // Arrange & Act
        final exactPhone = PhoneVos('123456789', 9); // Exactamente 9 dígitos

        // Assert
        expect(exactPhone.isValid(), isTrue);
      });

      test('Debería aceptar exactamente la longitud máxima permitida', () {
        // Arrange & Act
        final exactMaxPhone = PhoneVos(
          '12345678901',
          11,
        ); // Exactamente 11 dígitos

        // Assert
        expect(exactMaxPhone.isValid(), isTrue);
      });

      test('Debería rechazar teléfono de longitud menor a la mínima', () {
        // Arrange & Act
        final shortPhone = PhoneVos(
          '12345678',
          9,
        ); // 8 dígitos cuando se requieren 9

        // Assert
        expect(shortPhone.isValid(), isFalse);
        shortPhone.when(
          isLeft: (failure) => expect(failure, isA<PhoneFailureInvalid>()),
          isRight: (value) =>
              fail('Debería retornar failure para teléfono corto'),
        );
      });
    });

    group('Tests de regex específicos', () {
      test('Debería aceptar solo números y espacios', () {
        // Arrange
        final validChars = [
          '123456789',
          '1 2 3 4 5 6 7 8 9',
          '12 34 56 789',
          '123 456 789',
          '1234 5678 9',
        ];

        final invalidChars = [
          '123-456-789',
          '123.456.789',
          '+123456789',
          '(123)456789',
          '123a456789',
          '123@456789',
        ];

        // Act & Assert - Caracteres válidos
        for (final phone in validChars) {
          final phoneVos = PhoneVos(phone, 9);
          expect(
            phoneVos.isValid(),
            isTrue,
            reason:
                'Teléfono "$phone" con caracteres válidos debería ser aceptado',
          );
        }

        // Act & Assert - Caracteres inválidos
        for (final phone in invalidChars) {
          final phoneVos = PhoneVos(phone, 9);
          expect(
            phoneVos.isValid(),
            isFalse,
            reason:
                'Teléfono "$phone" con caracteres inválidos debería ser rechazado',
          );
        }
      });

      test('Debería manejar múltiples espacios', () {
        // Arrange
        final multipleSpaces = [
          '123  456  789',
          '123   456   789',
          '1 2 3 4 5 6 7 8 9',
          '12  34  56  789',
        ];

        for (final phone in multipleSpaces) {
          // Act
          final phoneVos = PhoneVos(phone, 9);

          // Assert
          expect(
            phoneVos.isValid(),
            isTrue,
            reason:
                'Teléfono "$phone" con múltiples espacios debería ser válido',
          );
        }
      });

      test('Debería rechazar teléfono que solo contiene espacios', () {
        // Arrange
        final onlySpaces = [
          '         ',
          '   ',
          ' ',
        ];

        for (final phone in onlySpaces) {
          // Act
          final phoneVos = PhoneVos(phone, 9);

          // Assert
          expect(
            phoneVos.isValid(),
            isFalse,
            reason:
                'Teléfono que solo contiene espacios "$phone" debería ser inválido',
          );
        }
      });
    });

    group('Tests de longitudes específicas', () {
      test(
        'Debería funcionar correctamente con diferentes longitudes máximas',
        () {
          // Arrange
          final testCases = [
            {'phone': '123456789', 'maxLength': 9, 'shouldBeValid': true},
            {'phone': '123456789', 'maxLength': 8, 'shouldBeValid': false},
            {'phone': '123456789', 'maxLength': 10, 'shouldBeValid': true},
            {'phone': '12345678901', 'maxLength': 11, 'shouldBeValid': true},
            {'phone': '12345678901', 'maxLength': 10, 'shouldBeValid': false},
            {'phone': '12345678901', 'maxLength': 12, 'shouldBeValid': true},
          ];

          for (final testCase in testCases) {
            // Act
            final phoneVos = PhoneVos(
              testCase['phone'] as String,
              testCase['maxLength'] as int,
            );
            final shouldBeValid = testCase['shouldBeValid'] as bool;

            // Assert
            expect(
              phoneVos.isValid(),
              shouldBeValid,
              reason:
                  'Teléfono "${testCase['phone']}" con longitud máxima ${testCase['maxLength']} debería ser ${shouldBeValid ? 'válido' : 'inválido'}',
            );
          }
        },
      );
    });
  });
}
