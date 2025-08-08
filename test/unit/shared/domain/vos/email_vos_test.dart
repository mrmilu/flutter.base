import 'package:flutter_base/src/shared/domain/failures/email_failure.dart';
import 'package:flutter_base/src/shared/domain/vos/email_vos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailVos', () {
    group('Emails válidos', () {
      final validEmails = [
        'test@example.com',
        'user.name@domain.co.uk',
        'first.last@subdomain.example.com',
        'user+tag@example.org',
        'test_user@example-domain.com',
        'user123@test123.io',
        'simple@example.co',
        'a@b.co',
        'test@long-domain-name.com',
        'user@example.museum',
      ];

      for (final email in validEmails) {
        test('Debería aceptar email válido: $email', () {
          // Arrange & Act
          final emailVos = EmailVos(email);

          // Assert
          expect(emailVos.isValid(), isTrue);
          emailVos.when(
            isLeft: (failure) => fail('Debería ser válido: $email'),
            isRight: (value) => expect(value, equals(email.trim())),
          );
        });
      }
    });

    group('Emails inválidos', () {
      final invalidEmails = [
        // Email vacío
        '',
        '   ',

        // Falta @
        'testexample.com',
        'user.name.domain.com',

        // Falta dominio después de @
        'test@',
        'user@.',
        'test@.com', // Este era el problema original
        'user@.example.com',

        // Falta parte local (antes de @)
        '@example.com',
        '@.com',

        // Formato incorrecto
        'test@@example.com',
        'test@example',
        'test@example.',
        'test@.example.',
        'test@example..com',
        'missing@.com',
        'test@example.c', // Extensión muy corta
        // Caracteres inválidos en dominio
        'test@exam ple.com',
        'test@example.com.',

        // Casos edge
        'test@-example.com',
        'test@example-.com',
      ];

      for (final email in invalidEmails) {
        test('Debería rechazar email inválido: "$email"', () {
          // Arrange & Act
          final emailVos = EmailVos(email);

          // Assert
          expect(emailVos.isValid(), isFalse);
          expect(emailVos.isInvalid(), isTrue);
        });
      }
    });

    group('Casos específicos de validación', () {
      test('Debería manejar espacios en blanco correctamente', () {
        // Arrange & Act
        final emailWithSpaces = EmailVos('  test@example.com  ');

        // Assert
        expect(emailWithSpaces.isValid(), isTrue);
        emailWithSpaces.when(
          isLeft: (failure) => fail('Debería ser válido'),
          isRight: (value) => expect(value, equals('test@example.com')),
        );
      });

      test('Debería retornar EmailFailure.empty para email vacío', () {
        // Arrange & Act
        final emptyEmail = EmailVos('');

        // Assert
        expect(emptyEmail.isValid(), isFalse);
        emptyEmail.when(
          isLeft: (failure) => expect(failure, isA<EmailFailureEmpty>()),
          isRight: (value) => fail('Debería retornar failure para email vacío'),
        );
      });

      test('Debería retornar EmailFailure.invalid para formato incorrecto', () {
        // Arrange & Act
        final invalidEmail = EmailVos('missing@.com');

        // Assert
        expect(invalidEmail.isValid(), isFalse);
        invalidEmail.when(
          isLeft: (failure) => expect(failure, isA<EmailFailureInvalid>()),
          isRight: (value) =>
              fail('Debería retornar failure para email inválido'),
        );
      });

      test('Debería rechazar específicamente missing@.com', () {
        // Arrange & Act
        final problematicEmail = EmailVos('missing@.com');

        // Assert
        expect(problematicEmail.isValid(), isFalse);

        // Verificar que es un EmailFailureInvalid
        problematicEmail.when(
          isLeft: (failure) => expect(failure, isA<EmailFailureInvalid>()),
          isRight: (value) =>
              fail('Debería retornar failure para email inválido'),
        );
      });

      test('Debería rechazar otros casos similares problemáticos', () {
        // Arrange
        final problematicEmails = [
          'user@.com',
          'test@.org',
          'admin@.net',
          'info@.io',
        ];

        for (final email in problematicEmails) {
          // Act
          final emailVos = EmailVos(email);

          // Assert
          expect(
            emailVos.isValid(),
            isFalse,
            reason: 'Email "$email" debería ser inválido',
          );
        }
      });
    });

    group('Tests de regex específicos', () {
      test('Debería exigir al menos un carácter entre @ y .', () {
        // Arrange - Casos que deberían fallar
        final shouldFail = [
          'test@.com',
          'user@.example.com',
          'admin@.net',
        ];

        // Arrange - Casos que deberían pasar
        final shouldPass = [
          'test@a.com',
          'user@example.com',
          'admin@domain.net',
        ];

        // Act & Assert - Casos que deberían fallar
        for (final email in shouldFail) {
          final emailVos = EmailVos(email);
          expect(
            emailVos.isValid(),
            isFalse,
            reason: 'Email "$email" debería ser rechazado',
          );
        }

        // Act & Assert - Casos que deberían pasar
        for (final email in shouldPass) {
          final emailVos = EmailVos(email);
          expect(
            emailVos.isValid(),
            isTrue,
            reason: 'Email "$email" debería ser aceptado',
          );
        }
      });

      test('Debería manejar subdominios correctamente', () {
        // Arrange
        final subdomainEmails = [
          'test@mail.example.com',
          'user@subdomain.domain.co.uk',
          'admin@a.b.c.com',
        ];

        for (final email in subdomainEmails) {
          // Act
          final emailVos = EmailVos(email);

          // Assert
          expect(
            emailVos.isValid(),
            isTrue,
            reason: 'Email con subdominio "$email" debería ser válido',
          );
        }
      });

      test('Debería exigir extensión de al menos 2 caracteres', () {
        // Arrange
        final shortExtensions = [
          'test@example.c',
          'user@domain.x',
        ];

        final validExtensions = [
          'test@example.co',
          'user@domain.com',
          'admin@site.museum',
        ];

        // Act & Assert - Extensiones cortas deberían fallar
        for (final email in shortExtensions) {
          final emailVos = EmailVos(email);
          expect(
            emailVos.isValid(),
            isFalse,
            reason: 'Email "$email" con extensión corta debería ser rechazado',
          );
        }

        // Act & Assert - Extensiones válidas deberían pasar
        for (final email in validExtensions) {
          final emailVos = EmailVos(email);
          expect(
            emailVos.isValid(),
            isTrue,
            reason: 'Email "$email" con extensión válida debería ser aceptado',
          );
        }
      });
    });
  });
}
