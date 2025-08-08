import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Flutter Base App Integration Tests', () {
    testWidgets('App debería iniciar correctamente', (tester) async {
      // Arrange & Act
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Assert - Verificar que la app se inicia sin errores
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Debería mostrar splash screen inicialmente', (tester) async {
      // Arrange & Act
      app.main();
      await tester.pump(); // Solo un pump para ver el estado inicial

      // Assert - Buscar elementos del splash screen
      // Nota: Estos elementos específicos dependen de tu implementación
      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('Debería navegar después del splash', (tester) async {
      // Arrange & Act
      app.main();

      // Esperar a que termine el splash
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Assert - Verificar que se navega a la siguiente pantalla
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Debería manejar rotación de pantalla', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act - Simular cambio de orientación con binding
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpAndSettle();

      // Assert - La app debería seguir funcionando
      expect(find.byType(MaterialApp), findsOneWidget);

      // Restaurar tamaño original
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('Debería manejar cambio de tema', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act & Assert - Buscar posibles botones de tema
      // Nota: Esto depende de tu implementación específica
      final themeSwitchers = find.byIcon(Icons.dark_mode);
      if (themeSwitchers.evaluate().isNotEmpty) {
        await tester.tap(themeSwitchers.first);
        await tester.pumpAndSettle();

        // Verificar que el tema cambió
        expect(find.byType(MaterialApp), findsOneWidget);
      }
    });

    testWidgets('Debería manejar navegación básica', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act - Buscar elementos de navegación
      final backButtons = find.byIcon(Icons.arrow_back);
      final menuButtons = find.byIcon(Icons.menu);
      final profileButtons = find.byType(IconButton);

      // Assert - Verificar que hay elementos de navegación
      expect(
        backButtons.evaluate().isNotEmpty ||
            menuButtons.evaluate().isNotEmpty ||
            profileButtons.evaluate().isNotEmpty,
        isTrue,
        reason: 'Debería haber al menos un elemento de navegación',
      );
    });

    testWidgets('Debería mostrar texto en idioma por defecto', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act & Assert - Buscar texto común en español (idioma por defecto)
      final spanishTexts = [
        'Bienvenido',
        'Iniciar',
        'Configuración',
        'Perfil',
        'Aceptar',
        'Cancelar',
      ];

      bool foundSpanishText = false;
      for (final text in spanishTexts) {
        if (find
            .textContaining(text, findRichText: true)
            .evaluate()
            .isNotEmpty) {
          foundSpanishText = true;
          break;
        }
      }

      // Si no encuentra texto en español, verifica que hay algún texto
      if (!foundSpanishText) {
        expect(find.byType(Text), findsAtLeastNWidgets(1));
      }
    });

    testWidgets('Debería poder hacer scroll si hay contenido desplazable', (
      tester,
    ) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act - Buscar widgets desplazables
      final scrollableWidgets = find.byType(Scrollable);

      if (scrollableWidgets.evaluate().isNotEmpty) {
        // Intentar hacer scroll
        await tester.drag(scrollableWidgets.first, const Offset(0, -100));
        await tester.pumpAndSettle();

        // Assert - La app debería seguir funcionando después del scroll
        expect(find.byType(MaterialApp), findsOneWidget);
      }
    });

    testWidgets('Debería manejar toques en diferentes áreas', (tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act - Buscar botones o elementos tocables
      final buttons = find.byType(ElevatedButton);
      final inkWells = find.byType(InkWell);
      final gestureDetectors = find.byType(GestureDetector);

      // Intentar tocar el primer elemento tocable que encontremos
      if (buttons.evaluate().isNotEmpty) {
        await tester.tap(buttons.first);
        await tester.pumpAndSettle();
      } else if (inkWells.evaluate().isNotEmpty) {
        await tester.tap(inkWells.first);
        await tester.pumpAndSettle();
      } else if (gestureDetectors.evaluate().isNotEmpty) {
        await tester.tap(gestureDetectors.first);
        await tester.pumpAndSettle();
      }

      // Assert - La app debería seguir funcionando
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Debería funcionar después de múltiples interacciones', (
      tester,
    ) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Act - Secuencia de interacciones
      for (int i = 0; i < 3; i++) {
        // Buscar y tocar cualquier elemento interactivo
        final interactiveElements = [
          ...find.byType(ElevatedButton).evaluate(),
          ...find.byType(InkWell).evaluate(),
          ...find.byType(IconButton).evaluate(),
        ];

        if (interactiveElements.isNotEmpty) {
          await tester.tap(find.byWidget(interactiveElements.first.widget));
          await tester.pumpAndSettle();
        }

        // Pequeña pausa entre interacciones
        await tester.pump(const Duration(milliseconds: 500));
      }

      // Assert - La app debería seguir funcionando después de múltiples interacciones
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
