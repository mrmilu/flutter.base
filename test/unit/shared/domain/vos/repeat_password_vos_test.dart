import 'package:flutter_base/src/shared/domain/failures/repeat_password_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/repeat_password_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RepeatPasswordVos', () {
    group('Contraseñas que coinciden', () {
      final matchingPasswordPairs = [
        {'password': 'Password123!', 'repeat': 'Password123!'},
        {'password': 'mySecret456@', 'repeat': 'mySecret456@'},
        {'password': 'StrongPass789#', 'repeat': 'StrongPass789#'},
        {'password': '123456', 'repeat': '123456'},
        {'password': 'simple', 'repeat': 'simple'},
        {'password': '', 'repeat': ''}, // Contraseñas vacías pero coincidentes
        {'password': 'a', 'repeat': 'a'}, // Un solo carácter
        {'password': '   spaces   ', 'repeat': '   spaces   '}, // Con espacios
        {'password': 'WithÑÚMñbers123!@#', 'repeat': 'WithÑÚMñbers123!@#'},
        {
          'password': 'Very Long Password That Still Matches Exactly The Same',
          'repeat': 'Very Long Password That Still Matches Exactly The Same',
        },
      ];

      for (final pair in matchingPasswordPairs) {
        test(
          'Debería aceptar contraseñas coincidentes: "${pair['password']}"',
          () {
            // Arrange & Act
            final repeatPasswordVos = RepeatPasswordVos(
              password: pair['password']!,
              passToMatchWith: pair['repeat']!,
            );

            // Assert
            expect(repeatPasswordVos.isValid(), isTrue);
            repeatPasswordVos.when(
              isLeft: (failure) =>
                  fail('Debería ser válida: ${pair['password']}'),
              isRight: (value) => expect(value, equals(pair['password'])),
            );
          },
        );
      }
    });

    group('Contraseñas que no coinciden', () {
      final mismatchingPasswordPairs = [
        {'password': 'Password123!', 'repeat': 'Password124!'},
        {'password': 'mySecret456@', 'repeat': 'mySecret456#'},
        {
          'password': 'StrongPass789',
          'repeat': 'strongpass789',
        }, // Diferencia en mayúsculas
        {
          'password': 'Password',
          'repeat': 'password',
        }, // Diferencia en mayúsculas
        {'password': 'test123', 'repeat': 'test124'},
        {'password': 'password', 'repeat': 'Password'}, // Mayúscula inicial
        {'password': 'hello', 'repeat': 'helo'}, // Falta una letra
        {'password': 'test', 'repeat': 'test '}, // Espacio extra
        {'password': ' test', 'repeat': 'test'}, // Espacio inicial
        {'password': 'test', 'repeat': ''}, // Una vacía
        {'password': '', 'repeat': 'test'}, // Una vacía
        {'password': 'ABC123', 'repeat': 'abc123'}, // Diferencia en caso
        {'password': 'symbol!', 'repeat': 'symbol@'}, // Diferente símbolo
        {
          'password': 'long password here',
          'repeat': 'long password there',
        }, // Diferencia al final
      ];

      for (final pair in mismatchingPasswordPairs) {
        test(
          'Debería rechazar contraseñas que no coinciden: "${pair['password']}" vs "${pair['repeat']}"',
          () {
            // Arrange & Act
            final repeatPasswordVos = RepeatPasswordVos(
              password: pair['password']!,
              passToMatchWith: pair['repeat']!,
            );

            // Assert
            expect(repeatPasswordVos.isValid(), isFalse);
            expect(repeatPasswordVos.isInvalid(), isTrue);
            repeatPasswordVos.when(
              isLeft: (failure) =>
                  expect(failure, isA<RepeatPasswordFailureMismatched>()),
              isRight: (value) =>
                  fail('Debería retornar failure para contraseñas diferentes'),
            );
          },
        );
      }
    });

    group('Casos específicos de validación', () {
      test('Debería ser sensible a mayúsculas y minúsculas', () {
        // Arrange & Act
        final differentCaseVos = RepeatPasswordVos(
          password: 'Password',
          passToMatchWith: 'password',
        );

        // Assert
        expect(differentCaseVos.isValid(), isFalse);
        differentCaseVos.when(
          isLeft: (failure) =>
              expect(failure, isA<RepeatPasswordFailureMismatched>()),
          isRight: (value) => fail('Debería ser sensible a mayúsculas'),
        );
      });

      test('Debería ser sensible a espacios', () {
        // Arrange & Act - Espacio al final
        final trailingSpaceVos = RepeatPasswordVos(
          password: 'password',
          passToMatchWith: 'password ',
        );

        // Assert
        expect(trailingSpaceVos.isValid(), isFalse);

        // Arrange & Act - Espacio al inicio
        final leadingSpaceVos = RepeatPasswordVos(
          password: 'password',
          passToMatchWith: ' password',
        );

        // Assert
        expect(leadingSpaceVos.isValid(), isFalse);
      });

      test('Debería validar contraseñas vacías coincidentes', () {
        // Arrange & Act
        final emptyPasswordsVos = RepeatPasswordVos(
          password: '',
          passToMatchWith: '',
        );

        // Assert
        expect(emptyPasswordsVos.isValid(), isTrue);
        emptyPasswordsVos.when(
          isLeft: (failure) =>
              fail('Contraseñas vacías coincidentes deberían ser válidas'),
          isRight: (value) => expect(value, equals('')),
        );
      });

      test('Debería rechazar una contraseña vacía y otra no', () {
        // Arrange & Act - Primera vacía
        final firstEmptyVos = RepeatPasswordVos(
          password: '',
          passToMatchWith: 'password',
        );

        // Assert
        expect(firstEmptyVos.isValid(), isFalse);

        // Arrange & Act - Segunda vacía
        final secondEmptyVos = RepeatPasswordVos(
          password: 'password',
          passToMatchWith: '',
        );

        // Assert
        expect(secondEmptyVos.isValid(), isFalse);
      });

      test('Debería validar caracteres especiales idénticos', () {
        // Arrange
        final specialCharsPasswords = [
          'pass!@#\$%^&*()',
          'símbolos: áéíóúñü',
          'unicode: 🔒🔑',
          'tabs:\t\taquí',
          'saltos:\n\naquí',
          'mixed: ABC123!@# éñü',
        ];

        for (final password in specialCharsPasswords) {
          // Act
          final repeatPasswordVos = RepeatPasswordVos(
            password: password,
            passToMatchWith: password,
          );

          // Assert
          expect(
            repeatPasswordVos.isValid(),
            isTrue,
            reason:
                'Contraseña con caracteres especiales debería validar correctamente: "$password"',
          );
        }
      });

      test('Debería detectar diferencias mínimas en caracteres especiales', () {
        // Arrange
        final almostMatchingPairs = [
          {'password': 'pass!', 'repeat': 'pass@'},
          {'password': 'test#123', 'repeat': 'test\$123'},
          {'password': 'símbol@', 'repeat': 'symbol@'}, // Diferencia en tilde
          {'password': 'test\t', 'repeat': 'test '}, // Tab vs espacio
          {
            'password': 'line\n',
            'repeat': 'line\r',
          }, // Diferentes saltos de línea
        ];

        for (final pair in almostMatchingPairs) {
          // Act
          final repeatPasswordVos = RepeatPasswordVos(
            password: pair['password']!,
            passToMatchWith: pair['repeat']!,
          );

          // Assert
          expect(
            repeatPasswordVos.isValid(),
            isFalse,
            reason:
                'Debería detectar diferencia entre "${pair['password']}" y "${pair['repeat']}"',
          );
        }
      });
    });

    group('Tests de longitud y complejidad', () {
      test('Debería validar contraseñas muy largas coincidentes', () {
        // Arrange
        final longPassword =
            'Esta es una contraseña muy larga que incluye múltiples palabras, números 123456789, símbolos !@#\$%^&*(), y caracteres especiales áéíóúñü para probar que el sistema puede manejar contraseñas extensas correctamente sin problemas de rendimiento o validación';

        // Act
        final repeatPasswordVos = RepeatPasswordVos(
          password: longPassword,
          passToMatchWith: longPassword,
        );

        // Assert
        expect(repeatPasswordVos.isValid(), isTrue);
        repeatPasswordVos.when(
          isLeft: (failure) =>
              fail('Contraseña larga coincidente debería ser válida'),
          isRight: (value) => expect(value, equals(longPassword)),
        );
      });

      test('Debería detectar diferencias en contraseñas muy largas', () {
        // Arrange
        final longPassword1 =
            'Esta es una contraseña muy larga que incluye múltiples palabras y caracteres especiales para probar la validación del sistema con textos extensos y complejos que podrían causar problemas';
        final longPassword2 =
            'Esta es una contraseña muy larga que incluye múltiples palabras y caracteres especiales para probar la validación del sistema con textos extensos y complejos que podrían causar problemaz'; // Cambio en la última letra

        // Act
        final repeatPasswordVos = RepeatPasswordVos(
          password: longPassword1,
          passToMatchWith: longPassword2,
        );

        // Assert
        expect(repeatPasswordVos.isValid(), isFalse);
        repeatPasswordVos.when(
          isLeft: (failure) =>
              expect(failure, isA<RepeatPasswordFailureMismatched>()),
          isRight: (value) =>
              fail('Debería detectar diferencia en contraseñas largas'),
        );
      });

      test('Debería validar contraseñas de un solo carácter', () {
        // Arrange
        final singleCharPasswords = ['a', 'A', '1', '!', ' ', '\t', '\n'];

        for (final password in singleCharPasswords) {
          // Act
          final repeatPasswordVos = RepeatPasswordVos(
            password: password,
            passToMatchWith: password,
          );

          // Assert
          expect(
            repeatPasswordVos.isValid(),
            isTrue,
            reason:
                'Contraseña de un carácter "$password" debería validar correctamente',
          );
        }
      });
    });

    group('Tests de casos extremos', () {
      test('Debería manejar caracteres Unicode complejos', () {
        // Arrange
        final unicodePasswords = [
          '🔒🔑🛡️🔐', // Emojis de seguridad
          'こんにちは世界', // Japonés
          'مرحبا بالعالم', // Árabe
          'Привет мир', // Ruso
          '∑∆∇∞∈∉⊂⊃', // Símbolos matemáticos
          '½¼¾²³¹', // Fracciones y superíndices
        ];

        for (final password in unicodePasswords) {
          // Act
          final repeatPasswordVos = RepeatPasswordVos(
            password: password,
            passToMatchWith: password,
          );

          // Assert
          expect(
            repeatPasswordVos.isValid(),
            isTrue,
            reason:
                'Contraseña Unicode "$password" debería validar correctamente',
          );
        }
      });

      test('Debería detectar diferencias en caracteres Unicode similares', () {
        // Arrange - Caracteres que se ven similares pero son diferentes
        final similarUnicodePairs = [
          {'password': 'café', 'repeat': 'cafe'}, // Con y sin tilde
          {'password': 'naïve', 'repeat': 'naive'}, // Con y sin diéresis
          {'password': 'résumé', 'repeat': 'resume'}, // Con y sin acentos
          {'password': 'Москва', 'repeat': 'Moscow'}, // Cirílico vs latino
        ];

        for (final pair in similarUnicodePairs) {
          // Act
          final repeatPasswordVos = RepeatPasswordVos(
            password: pair['password']!,
            passToMatchWith: pair['repeat']!,
          );

          // Assert
          expect(
            repeatPasswordVos.isValid(),
            isFalse,
            reason:
                'Debería detectar diferencia entre "${pair['password']}" y "${pair['repeat']}"',
          );
        }
      });

      test('Debería preservar el valor exacto de la contraseña', () {
        // Arrange
        final originalPassword = 'Complex@Password123!éñü\t\n';

        // Act
        final repeatPasswordVos = RepeatPasswordVos(
          password: originalPassword,
          passToMatchWith: originalPassword,
        );

        // Assert
        expect(repeatPasswordVos.isValid(), isTrue);
        repeatPasswordVos.when(
          isLeft: (failure) => fail('Debería ser válida'),
          isRight: (value) => expect(value, equals(originalPassword)),
        );
      });

      test('Debería validar la comparación exacta sin normalización', () {
        // Arrange - Asegurar que no hay normalización Unicode
        final password1 = 'café'; // é como un solo carácter
        final password2 = 'cafe\u0301'; // e + combinando acute accent

        // Act
        final repeatPasswordVos = RepeatPasswordVos(
          password: password1,
          passToMatchWith: password2,
        );

        // Assert - Si los strings son diferentes a nivel de bytes, deberían fallar
        if (password1 != password2) {
          expect(repeatPasswordVos.isValid(), isFalse);
        } else {
          expect(repeatPasswordVos.isValid(), isTrue);
        }
      });
    });

    group('Tests de integración con PasswordVos', () {
      test(
        'Debería funcionar en conjunto con validación de contraseña fuerte',
        () {
          // Arrange - Contraseña que cumple criterios de PasswordVos
          final strongPassword = 'StrongPassword123!';

          // Act
          final repeatPasswordVos = RepeatPasswordVos(
            password: strongPassword,
            passToMatchWith: strongPassword,
          );

          // Assert
          expect(repeatPasswordVos.isValid(), isTrue);
          repeatPasswordVos.when(
            isLeft: (failure) =>
                fail('Contraseña fuerte coincidente debería ser válida'),
            isRight: (value) => expect(value, equals(strongPassword)),
          );
        },
      );

      test('Debería rechazar contraseña fuerte que no coincide', () {
        // Arrange - Contraseñas fuertes pero diferentes
        final strongPassword1 = 'StrongPassword123!';
        final strongPassword2 = 'StrongPassword124!';

        // Act
        final repeatPasswordVos = RepeatPasswordVos(
          password: strongPassword1,
          passToMatchWith: strongPassword2,
        );

        // Assert
        expect(repeatPasswordVos.isValid(), isFalse);
        repeatPasswordVos.when(
          isLeft: (failure) =>
              expect(failure, isA<RepeatPasswordFailureMismatched>()),
          isRight: (value) =>
              fail('Contraseñas fuertes diferentes deberían fallar'),
        );
      });
    });
  });
}
