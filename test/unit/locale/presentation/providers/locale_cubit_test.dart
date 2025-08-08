import 'package:flutter/material.dart';
import 'package:flutter_base/src/locale/domain/i_locale_repository.dart';
import 'package:flutter_base/src/locale/presentation/providers/locale_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock simple del repositorio
class MockLocaleRepository implements ILocaleRepository {
  String? _savedLanguageCode;

  @override
  Future<void> changeLanguageCode(String languageCode) async {
    _savedLanguageCode = languageCode;
  }

  @override
  Future<String?> findLanguageCode() async {
    return _savedLanguageCode;
  }
}

void main() {
  group('LocaleCubit', () {
    late LocaleCubit localeCubit;
    late MockLocaleRepository mockLocaleRepository;

    setUp(() {
      mockLocaleRepository = MockLocaleRepository();
      localeCubit = LocaleCubit(localeRepository: mockLocaleRepository);
    });

    tearDown(() {
      localeCubit.close();
    });

    test('estado inicial debe ser español', () {
      expect(localeCubit.state.languageCode, equals('es'));
      expect(localeCubit.state.locale.languageCode, equals('es'));
    });

    test('changeLanguage debería cambiar el idioma correctamente', () async {
      // Act
      await localeCubit.changeLanguage('en');

      // Assert
      expect(localeCubit.state.languageCode, equals('en'));
      expect(appLocaleCode, equals('en'));
    });

    test(
      'changeLanguage debería actualizar appLocaleCode globalmente',
      () async {
        // Act
        await localeCubit.changeLanguage('ca');

        // Assert
        expect(localeCubit.state.languageCode, equals('ca'));
        expect(appLocaleCode, equals('ca'));
      },
    );

    test('changeLanguage debería manejar múltiples idiomas', () async {
      // Test español -> inglés
      await localeCubit.changeLanguage('en');
      expect(localeCubit.state.languageCode, equals('en'));

      // Test inglés -> catalán
      await localeCubit.changeLanguage('ca');
      expect(localeCubit.state.languageCode, equals('ca'));

      // Test catalán -> euskera
      await localeCubit.changeLanguage('eu');
      expect(localeCubit.state.languageCode, equals('eu'));

      // Test euskera -> gallego
      await localeCubit.changeLanguage('gl');
      expect(localeCubit.state.languageCode, equals('gl'));
    });

    test('loadLocale debería cargar idioma guardado cuando existe', () async {
      // Arrange - simular que hay un idioma guardado
      await mockLocaleRepository.changeLanguageCode('en');

      // Act
      localeCubit.loadLocale('es');

      // Wait a bit for async operations
      await Future.delayed(const Duration(milliseconds: 10));

      // Assert
      expect(localeCubit.state.languageCode, equals('en'));
    });

    test(
      'loadLocale debería usar idioma por defecto cuando no existe guardado',
      () async {
        // Act - no hay idioma guardado
        localeCubit.loadLocale('ca');

        // Wait a bit for async operations
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(localeCubit.state.languageCode, equals('ca'));
      },
    );

    test('LocaleState debería crear Locale correctamente', () {
      final state = LocaleState(languageCode: 'eu');
      expect(state.locale, equals(const Locale('eu')));

      final stateEn = LocaleState(languageCode: 'en');
      expect(stateEn.locale, equals(const Locale('en')));

      final stateCa = LocaleState(languageCode: 'ca');
      expect(stateCa.locale, equals(const Locale('ca')));

      final stateGl = LocaleState(languageCode: 'gl');
      expect(stateGl.locale, equals(const Locale('gl')));
    });

    test('estado inicial factory debería funcionar correctamente', () {
      final initialState = LocaleState.initial();
      expect(initialState.languageCode, equals('es'));
      expect(initialState.locale, equals(const Locale('es')));
    });

    test('debería manejar códigos de idioma vacíos', () async {
      await localeCubit.changeLanguage('');
      expect(localeCubit.state.languageCode, equals(''));
    });

    test(
      'debería mantener estado consistente después de múltiples operaciones',
      () async {
        // Sequence de operaciones reales
        await localeCubit.changeLanguage('en');
        localeCubit.loadLocale('es');

        // Wait a bit for async operations
        await Future.delayed(const Duration(milliseconds: 10));

        expect(
          localeCubit.state.languageCode,
          equals('en'),
        ); // Debe cargar el guardado

        await localeCubit.changeLanguage('ca');
        expect(localeCubit.state.languageCode, equals('ca'));
        expect(appLocaleCode, equals('ca'));
      },
    );
  });
}
