import 'package:flutter_base/src/locale/data/locale_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocaleRepositoryImpl', () {
    late LocaleRepositoryImpl repository;

    setUp(() {
      repository = LocaleRepositoryImpl();
    });

    group('changeLanguageCode', () {
      testWidgets('debería guardar el código de idioma correctamente', (
        tester,
      ) async {
        // Arrange
        SharedPreferences.setMockInitialValues({});
        const languageCode = 'en';

        // Act
        await repository.changeLanguageCode(languageCode);

        // Assert
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('languageCode'), equals(languageCode));
      });

      testWidgets('debería sobrescribir código de idioma anterior', (
        tester,
      ) async {
        // Arrange
        SharedPreferences.setMockInitialValues({'languageCode': 'es'});

        // Act
        await repository.changeLanguageCode('ca');

        // Assert
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('languageCode'), equals('ca'));
      });

      testWidgets('debería manejar idiomas soportados por la app', (
        tester,
      ) async {
        // Arrange
        SharedPreferences.setMockInitialValues({});
        final supportedLanguages = ['es', 'en', 'ca', 'eu', 'gl'];

        for (final lang in supportedLanguages) {
          // Act
          await repository.changeLanguageCode(lang);

          // Assert
          final prefs = await SharedPreferences.getInstance();
          expect(prefs.getString('languageCode'), equals(lang));
        }
      });
    });

    group('findLanguageCode', () {
      testWidgets('debería retornar null cuando no hay idioma guardado', (
        tester,
      ) async {
        // Arrange
        SharedPreferences.setMockInitialValues({});

        // Act
        final result = await repository.findLanguageCode();

        // Assert
        expect(result, isNull);
      });

      testWidgets('debería retornar el idioma guardado cuando existe', (
        tester,
      ) async {
        // Arrange
        const savedLanguage = 'en';
        SharedPreferences.setMockInitialValues({'languageCode': savedLanguage});

        // Act
        final result = await repository.findLanguageCode();

        // Assert
        expect(result, equals(savedLanguage));
      });

      testWidgets('debería retornar idiomas diferentes correctamente', (
        tester,
      ) async {
        // Test múltiples idiomas
        final testCases = {
          'es': 'Español',
          'en': 'English',
          'ca': 'Català',
          'eu': 'Euskera',
          'gl': 'Galego',
        };

        for (final entry in testCases.entries) {
          // Arrange
          SharedPreferences.setMockInitialValues({'languageCode': entry.key});

          // Act
          final result = await repository.findLanguageCode();

          // Assert
          expect(
            result,
            equals(entry.key),
            reason: 'Failed for language: ${entry.value}',
          );
        }
      });

      testWidgets('debería manejar SharedPreferences con otros datos', (
        tester,
      ) async {
        // Arrange - simular que hay otros datos en SharedPreferences
        SharedPreferences.setMockInitialValues({
          'languageCode': 'ca',
          'otherKey': 'otherValue',
          'someNumber': 42,
          'someBool': true,
        });

        // Act
        final result = await repository.findLanguageCode();

        // Assert
        expect(result, equals('ca'));
      });
    });

    group('integración completa', () {
      testWidgets(
        'debería funcionar el flujo completo de guardar y recuperar',
        (tester) async {
          // Arrange
          SharedPreferences.setMockInitialValues({});

          // Act & Assert - Inicialmente no hay idioma
          var result = await repository.findLanguageCode();
          expect(result, isNull);

          // Act & Assert - Guardar español
          await repository.changeLanguageCode('es');
          result = await repository.findLanguageCode();
          expect(result, equals('es'));

          // Act & Assert - Cambiar a inglés
          await repository.changeLanguageCode('en');
          result = await repository.findLanguageCode();
          expect(result, equals('en'));

          // Act & Assert - Cambiar a catalán
          await repository.changeLanguageCode('ca');
          result = await repository.findLanguageCode();
          expect(result, equals('ca'));
        },
      );

      testWidgets('debería manejar secuencia de cambios rápidos', (
        tester,
      ) async {
        // Arrange
        SharedPreferences.setMockInitialValues({});

        // Act - Cambios rápidos
        await repository.changeLanguageCode('es');
        await repository.changeLanguageCode('en');
        await repository.changeLanguageCode('ca');
        await repository.changeLanguageCode('eu');
        await repository.changeLanguageCode('gl');

        // Assert - Debería conservar el último cambio
        final result = await repository.findLanguageCode();
        expect(result, equals('gl'));
      });

      testWidgets('debería ser persistente entre instancias del repositorio', (
        tester,
      ) async {
        // Arrange
        SharedPreferences.setMockInitialValues({});
        final repo1 = LocaleRepositoryImpl();
        final repo2 = LocaleRepositoryImpl();

        // Act - Guardar con el primer repositorio
        await repo1.changeLanguageCode('eu');

        // Assert - Leer con el segundo repositorio
        final result = await repo2.findLanguageCode();
        expect(result, equals('eu'));
      });

      testWidgets('debería manejar valores edge case', (tester) async {
        // Arrange
        SharedPreferences.setMockInitialValues({});

        // Test con string vacío
        await repository.changeLanguageCode('');
        var result = await repository.findLanguageCode();
        expect(result, equals(''));

        // Test con string muy largo (aunque no sea realista)
        const longString = 'es-ES-valencia-u-nu-latn-cu-eur';
        await repository.changeLanguageCode(longString);
        result = await repository.findLanguageCode();
        expect(result, equals(longString));
      });
    });
  });
}
