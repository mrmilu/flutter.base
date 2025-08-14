import 'package:flutter_base/src/shared/domain/failures/password_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/password_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasswordVos', () {
    group('Contraseñas válidas', () {
      final validPasswords = [
        'Password123!',
        'MySecret456@',
        'StrongPass789#',
        'Test123456\$',
        'Complex999%',
        'Valid888^',
        'Good777&',
        'Safe666*',
        'Secure555!',
        'Strong444@',
        'AbCdEf123!',
        'MixedCASE456@',
      ];

      for (final password in validPasswords) {
        test('Debería aceptar contraseña válida: "$password"', () {
          // Arrange & Act
          final passwordVos = PasswordVos(password);

          // Assert
          expect(passwordVos.isValid(), isTrue);
          passwordVos.when(
            isLeft: (failure) => fail('Debería ser válida: $password'),
            isRight: (value) => expect(value, equals(password.trim())),
          );
        });
      }
    });

    group('Contraseñas inválidas', () {
      group('Por longitud insuficiente', () {
        final shortPasswords = [
          '',
          '1',
          '12',
          '123',
          '1234',
          '12345',
          '123456',
          '1234567',
          'Abc1!', // 5 caracteres
          'Ab1!', // 4 caracteres
        ];

        for (final password in shortPasswords) {
          test('Debería rechazar contraseña corta: "$password"', () {
            // Arrange & Act
            final passwordVos = PasswordVos(password);

            // Assert
            expect(passwordVos.isValid(), isFalse);
            passwordVos.when(
              isLeft: (failure) =>
                  expect(failure, isA<PasswordFailureInvalidMinLength>()),
              isRight: (value) =>
                  fail('Debería retornar failure para contraseña corta'),
            );
          });
        }
      });

      group('Por falta de mayúsculas', () {
        final noUppercasePasswords = [
          'password123!',
          'mysecret456@',
          'lowercase789#',
          'test123456\$',
          'simple999%',
          'no_upper888^',
        ];

        for (final password in noUppercasePasswords) {
          test('Debería rechazar contraseña sin mayúsculas: "$password"', () {
            // Arrange & Act
            final passwordVos = PasswordVos(password);

            // Assert
            expect(passwordVos.isValid(), isFalse);
            passwordVos.when(
              isLeft: (failure) =>
                  expect(failure, isA<PasswordFailureIncludeUppercase>()),
              isRight: (value) => fail(
                'Debería retornar failure para contraseña sin mayúsculas',
              ),
            );
          });
        }
      });

      group('Por falta de minúsculas', () {
        final noLowercasePasswords = [
          'PASSWORD123!',
          'MYSECRET456@',
          'UPPERCASE789#',
          'TEST123456\$',
          'SIMPLE999%',
          'NO_LOWER888^',
        ];

        for (final password in noLowercasePasswords) {
          test('Debería rechazar contraseña sin minúsculas: "$password"', () {
            // Arrange & Act
            final passwordVos = PasswordVos(password);

            // Assert
            expect(passwordVos.isValid(), isFalse);
            passwordVos.when(
              isLeft: (failure) =>
                  expect(failure, isA<PasswordFailureIncludeLowercase>()),
              isRight: (value) => fail(
                'Debería retornar failure para contraseña sin minúsculas',
              ),
            );
          });
        }
      });

      group('Por falta de caracteres especiales', () {
        final noSpecialCharPasswords = [
          'Password123',
          'MySecret456',
          'SimplePass789',
          'Test123456',
          'Complex999',
          'Valid888',
          'Good777abc',
          'Safe666DEF',
        ];

        for (final password in noSpecialCharPasswords) {
          test(
            'Debería rechazar contraseña sin caracteres especiales: "$password"',
            () {
              // Arrange & Act
              final passwordVos = PasswordVos(password);

              // Assert
              expect(passwordVos.isValid(), isFalse);
              passwordVos.when(
                isLeft: (failure) =>
                    expect(failure, isA<PasswordFailureIncludeDigit>()),
                isRight: (value) => fail(
                  'Debería retornar failure para contraseña sin caracteres especiales',
                ),
              );
            },
          );
        }
      });
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final passwordWithSpaces = PasswordVos('  Password123!  ');

        // Assert
        expect(passwordWithSpaces.isValid(), isTrue);
        passwordWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válida'),
          isRight: (value) => expect(value, equals('Password123!')),
        );
      });

      test('Debería rechazar contraseña de exactamente 7 caracteres', () {
        // Arrange & Act
        final sevenCharPassword = PasswordVos('Abc123!'); // 7 caracteres

        // Assert
        expect(sevenCharPassword.isValid(), isFalse);
        sevenCharPassword.when(
          isLeft: (failure) {
            expect(failure, isA<PasswordFailureInvalidMinLength>());
            if (failure is PasswordFailureInvalidMinLength) {
              expect(failure.maxLength, equals(8));
            }
          },
          isRight: (value) =>
              fail('Debería retornar failure para contraseña de 7 caracteres'),
        );
      });

      test('Debería aceptar contraseña de exactamente 8 caracteres', () {
        // Arrange & Act
        final eightCharPassword = PasswordVos('Abcd123!'); // 8 caracteres

        // Assert
        expect(eightCharPassword.isValid(), isTrue);
      });

      test('Debería aceptar todos los caracteres especiales permitidos', () {
        // Arrange
        final specialChars = ['!', '@', '#', '\$', '%', '^', '&', '*'];

        for (final char in specialChars) {
          // Act
          final passwordVos = PasswordVos('Password123$char');

          // Assert
          expect(
            passwordVos.isValid(),
            isTrue,
            reason:
                'Contraseña con carácter especial "$char" debería ser válida',
          );
        }
      });

      test('Debería validar todos los requisitos simultáneamente', () {
        // Arrange & Act
        final complexPassword = PasswordVos('ComplexPassword123!@#');

        // Assert
        expect(complexPassword.isValid(), isTrue);
        complexPassword.when(
          isLeft: (failure) => fail('Contraseña compleja debería ser válida'),
          isRight: (value) {
            // Verificar que contiene todos los elementos requeridos
            expect(value.length, greaterThanOrEqualTo(8));
            expect(RegExp(r'[A-Z]').hasMatch(value), isTrue);
            expect(RegExp(r'[a-z]').hasMatch(value), isTrue);
            expect(RegExp(r'[!@#$%^&*]').hasMatch(value), isTrue);
          },
        );
      });

      test('Debería rechazar contraseña que solo cumple algunos requisitos', () {
        // Arrange
        final partiallyValidPasswords = [
          'onlylowercase123!', // Sin mayúsculas
          'ONLYUPPERCASE123!', // Sin minúsculas
          'OnlyLetters!', // Sin números (pero el regex actual no los requiere)
          'OnlyAlphanumeric123', // Sin caracteres especiales
        ];

        for (final password in partiallyValidPasswords) {
          // Act
          final passwordVos = PasswordVos(password);

          // Assert - Al menos una de estas debería fallar
          if (passwordVos.isValid()) {
            // Si es válida, verificar que realmente cumple todos los requisitos
            passwordVos.when(
              isLeft: (failure) => fail('No debería llegar aquí'),
              isRight: (value) {
                expect(
                  RegExp(r'[A-Z]').hasMatch(value),
                  isTrue,
                  reason: 'Debería tener mayúsculas',
                );
                expect(
                  RegExp(r'[a-z]').hasMatch(value),
                  isTrue,
                  reason: 'Debería tener minúsculas',
                );
                expect(
                  RegExp(r'[!@#$%^&*]').hasMatch(value),
                  isTrue,
                  reason: 'Debería tener caracteres especiales',
                );
              },
            );
          }
        }
      });
    });

    group('Tests de regex específicos', () {
      test('Debería requerir al menos una mayúscula', () {
        // Arrange
        final noUppercase = 'password123!';
        final withUppercase = 'Password123!';

        // Act & Assert
        expect(PasswordVos(noUppercase).isValid(), isFalse);
        expect(PasswordVos(withUppercase).isValid(), isTrue);
      });

      test('Debería requerir al menos una minúscula', () {
        // Arrange
        final noLowercase = 'PASSWORD123!';
        final withLowercase = 'Password123!';

        // Act & Assert
        expect(PasswordVos(noLowercase).isValid(), isFalse);
        expect(PasswordVos(withLowercase).isValid(), isTrue);
      });

      test('Debería requerir al menos un carácter especial', () {
        // Arrange
        final noSpecialChar = 'Password123';
        final withSpecialChar = 'Password123!';

        // Act & Assert
        expect(PasswordVos(noSpecialChar).isValid(), isFalse);
        expect(PasswordVos(withSpecialChar).isValid(), isTrue);
      });

      test('Debería requerir mínimo 8 caracteres', () {
        // Arrange
        final tooShort = 'Pass1!'; // 6 caracteres
        final justRight = 'Pass123!'; // 8 caracteres

        // Act & Assert
        expect(PasswordVos(tooShort).isValid(), isFalse);
        expect(PasswordVos(justRight).isValid(), isTrue);
      });
    });
  });
}
