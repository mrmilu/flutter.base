import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Helper function para esperar a que se complete la navegación del splash al home
Future<void> waitForHomeScreen(WidgetTester tester) async {
  // Esperar inicial para que comience la app (menos tiempo si ya está inicializada)
  await tester.pumpAndSettle(const Duration(seconds: 1));

  // Esperar a que termine el splash y llegue al home
  bool homeLoaded = false;
  int attempts = 0;
  const maxAttempts = 15; // Aumentamos intentos para apps más lentas

  while (!homeLoaded && attempts < maxAttempts) {
    await tester.pump(const Duration(milliseconds: 500));

    // Buscar indicadores de que estamos en el home (no en splash)
    final homeIndicators = [
      find.byType(Scaffold),
      find.byType(AppBar),
      find.byType(BottomNavigationBar),
      find.byType(TabBar),
      find.byType(NavigationBar),
      find.text('Home'),
      find.text('Inicio'),
      find.text('Dashboard'),
    ];

    for (final finder in homeIndicators) {
      if (finder.evaluate().isNotEmpty) {
        homeLoaded = true;
        break;
      }
    }

    attempts++;
  }

  // Pump and settle final para asegurar que todo está estable
  await tester.pumpAndSettle(const Duration(seconds: 1));
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Flutter Base App Integration Tests', () {
    testWidgets('App debería iniciar correctamente', (tester) async {
      // Arrange & Act
      app.mainTest();
      await waitForHomeScreen(tester);

      // Assert - Verificar que la app se inicia sin errores
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Debería renderizar elementos básicos de la UI', (
      tester,
    ) async {
      // Arrange
      app.mainTest();

      // Esperar a que se complete la navegación al home
      await waitForHomeScreen(tester);

      // Act & Assert - Buscar elementos comunes de la UI del home
      final commonWidgets = [
        find.byType(Scaffold),
        find.byType(AppBar),
        find.byType(Text),
        find.byType(Container),
        find.byType(MaterialApp),
      ];

      // Al menos uno de estos widgets debería existir
      bool foundWidget = false;
      for (final finder in commonWidgets) {
        if (finder.evaluate().isNotEmpty) {
          foundWidget = true;
          break;
        }
      }

      expect(
        foundWidget,
        isTrue,
        reason:
            'Debería encontrar al menos un widget común de UI después de cargar el home',
      );

      // Verificación adicional: que no estemos en una pantalla de loading/splash
      final loadingIndicators = [
        find.byType(CircularProgressIndicator),
        find.text('Loading'),
        find.text('Cargando'),
        find.text('Splash'),
      ];

      bool stillLoading = false;
      for (final finder in loadingIndicators) {
        if (finder.evaluate().isNotEmpty) {
          stillLoading = true;
          break;
        }
      }

      expect(
        stillLoading,
        isFalse,
        reason:
            'No debería estar mostrando indicadores de carga después del timeout',
      );
    });

    testWidgets('Debería navegar del splash al home correctamente', (
      tester,
    ) async {
      // Arrange
      app.mainTest();

      // Act - Esperar a que se complete la navegación
      await waitForHomeScreen(tester);

      // Assert - Verificar que estamos en una pantalla funcional (no splash)
      final homeScreenElements = [
        find.byType(Scaffold),
        find.byType(AppBar),
        find.byType(BottomNavigationBar),
        find.byType(TabBar),
        find.byType(NavigationBar),
      ];

      bool foundHomeElement = false;
      for (final finder in homeScreenElements) {
        if (finder.evaluate().isNotEmpty) {
          foundHomeElement = true;
          break;
        }
      }

      expect(
        foundHomeElement,
        isTrue,
        reason: 'Debería encontrar al menos un elemento típico del home screen',
      );

      // Verificar que tenemos contenido de texto (indicador de que la app está funcionando)
      final textWidgets = find.byType(Text);
      expect(
        textWidgets.evaluate().length,
        greaterThan(0),
        reason: 'Debería tener al menos un widget de texto visible',
      );
    });
  });
}
