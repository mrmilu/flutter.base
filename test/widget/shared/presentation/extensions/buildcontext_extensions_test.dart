import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/src/locale/presentation/utils/custom_localization_delegate.dart';
import 'package:flutter_base/src/shared/presentation/extensions/buildcontext_extensions.dart';
import 'package:flutter_base/src/shared/presentation/l10n/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  group('ContextExtension', () {
    testWidgets('l10n should return S localization instance', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpApp(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      final l10n = capturedContext.l10n;
      expect(l10n, isA<S>());
    });

    testWidgets('cl should return CustomLocalization instance', (tester) async {
      late BuildContext capturedContext;

      // Crear app con CustomLocalizationDelegate
      final app = MaterialApp(
        localizationsDelegates: [
          S.delegate,
          CustomLocalizationDelegate('es'),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
          Locale('en', 'US'),
        ],
        home: Scaffold(
          body: Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final cl = capturedContext.cl;
      expect(cl, isA<CustomLocalization>());
    });

    testWidgets('locale should return current locale', (tester) async {
      late BuildContext capturedContext;

      await tester.pumpApp(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      final locale = capturedContext.locale;
      expect(locale, isA<Locale>());
      // Verifica que sea uno de los locales soportados
      expect(['es', 'en'], contains(locale.languageCode));
    });

    group('paddingBottomPlus', () {
      testWidgets('should return correct padding for Android', (tester) async {
        late BuildContext capturedContext;

        await tester.pumpApp(
          Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        );

        final paddingBottomPlus = capturedContext.paddingBottomPlus;
        final expectedPadding =
            MediaQuery.paddingOf(capturedContext).bottom +
            (Platform.isAndroid ? 24 : 24);

        expect(paddingBottomPlus, equals(expectedPadding));
        expect(paddingBottomPlus, isA<double>());
      });

      testWidgets('should include bottom padding from MediaQuery', (
        tester,
      ) async {
        late BuildContext capturedContext;

        // Simular padding bottom específico
        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(
              padding: EdgeInsets.only(bottom: 50.0),
            ),
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    capturedContext = context;
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        );

        final paddingBottomPlus = capturedContext.paddingBottomPlus;
        final expectedPadding = 50.0 + (Platform.isAndroid ? 24 : 24);

        expect(paddingBottomPlus, equals(expectedPadding));
      });

      testWidgets('should add 24 pixels regardless of platform', (
        tester,
      ) async {
        late BuildContext capturedContext;

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(
              padding: EdgeInsets.only(bottom: 0.0),
            ),
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    capturedContext = context;
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        );

        final paddingBottomPlus = capturedContext.paddingBottomPlus;
        // Verifica que siempre suma 24 (tanto para Android como para iOS)
        expect(paddingBottomPlus, equals(24.0));
      });
    });

    testWidgets('textTheme should return current text theme', (tester) async {
      late BuildContext capturedContext;
      final customTheme = ThemeData.light().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );

      // Crear app manualmente para asegurar que el tema se aplique
      await tester.pumpWidget(
        MaterialApp(
          theme: customTheme,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                capturedContext = context;
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );

      final textTheme = capturedContext.textTheme;
      expect(textTheme, isA<TextTheme>());

      // Verificar que el textTheme contiene el estilo personalizado
      expect(textTheme.bodyLarge?.color, equals(Colors.red));
      expect(textTheme.bodyLarge?.fontSize, equals(16));
    });

    testWidgets('textTheme should return default theme when no custom theme', (
      tester,
    ) async {
      late BuildContext capturedContext;

      await tester.pumpApp(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      final textTheme = capturedContext.textTheme;
      expect(textTheme, isA<TextTheme>());
      expect(textTheme, isNotNull);
    });

    group('isDarkMode', () {
      testWidgets('should return true when theme brightness is dark', (
        tester,
      ) async {
        late BuildContext capturedContext;

        // Crear app con tema oscuro
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedContext = context;
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );

        final isDarkMode = capturedContext.isDarkMode;
        expect(isDarkMode, isTrue);
        expect(Theme.of(capturedContext).brightness, equals(Brightness.dark));
      });

      testWidgets('should return false when theme brightness is light', (
        tester,
      ) async {
        late BuildContext capturedContext;

        // Crear app con tema claro
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedContext = context;
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );

        final isDarkMode = capturedContext.isDarkMode;
        expect(isDarkMode, isFalse);
        expect(Theme.of(capturedContext).brightness, equals(Brightness.light));
      });

      testWidgets('should return false with default theme', (tester) async {
        late BuildContext capturedContext;

        await tester.pumpApp(
          Builder(
            builder: (context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        );

        final isDarkMode = capturedContext.isDarkMode;
        // El tema por defecto es claro
        expect(isDarkMode, isFalse);
        expect(Theme.of(capturedContext).brightness, equals(Brightness.light));
      });

      testWidgets('should return correct value with custom theme brightness', (
        tester,
      ) async {
        late BuildContext capturedContext;

        // Crear tema personalizado con brightness específico
        final customDarkTheme = ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: customDarkTheme,
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedContext = context;
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );

        final isDarkMode = capturedContext.isDarkMode;
        expect(isDarkMode, isTrue);
        expect(Theme.of(capturedContext).brightness, equals(Brightness.dark));
      });
    });
  });
}
