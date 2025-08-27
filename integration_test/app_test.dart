import 'package:flutter/material.dart';
import 'package:flutter_base/main.dart' as app;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Helper function para limpiar el almacenamiento seguro antes de los tests
Future<void> clearAppStorage() async {
  const storage = FlutterSecureStorage();
  await storage.deleteAll();
}

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
      // Limpiar storage antes del test
      await clearAppStorage();

      // Arrange & Act
      app.mainTest();
      await waitForHomeScreen(tester);

      // Assert - Verificar que la app se inicia sin errores
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets(
      'Debería navegar del splash al initial page correctamente y realizar un login',
      (
        tester,
      ) async {
        // Limpiar storage antes del test
        await clearAppStorage();

        // Arrange
        app.mainTest();

        // Act - Esperar a que se complete la navegación
        await waitForHomeScreen(tester);

        // Assert - Verificar que estamos específicamente en la initial page
        final initialPageScaffold = find.byKey(const Key('initial_page'));
        expect(
          initialPageScaffold,
          findsOneWidget,
          reason: 'Debería encontrar el Scaffold con key "initial_page"',
        );

        // Verificar que tenemos contenido de texto (indicador de que la app está funcionando)
        final textWidgets = find.byType(Text);
        expect(
          textWidgets.evaluate().length,
          greaterThan(0),
          reason: 'Debería tener al menos un widget de texto visible',
        );
      },
    );

    testWidgets(
      'Debería realizar flujo de interacción completo en pantallas de autenticación',
      (
        tester,
      ) async {
        // Limpiar storage antes del test
        await clearAppStorage();

        // Arrange
        await app.mainTest();

        // Act - Esperar a que se complete la navegación
        await waitForHomeScreen(tester);

        // Assert - Verificar que estamos en la initial page
        final initialPageScaffold = find.byKey(const Key('initial_page'));
        expect(
          initialPageScaffold,
          findsOneWidget,
          reason: 'Debería encontrar el Scaffold con key "initial_page"',
        );

        await tester.pump(const Duration(milliseconds: 1000));

        // Paso 1: Encontrar y hacer clic en el botón "¿Ya eres cliente? Inicia sesión"
        final signInButton = find.text('¿Ya eres cliente? Inicia sesión');
        expect(
          signInButton,
          findsOneWidget,
          reason: 'Debería encontrar el botón de inicio de sesión',
        );
        await tester.tap(signInButton);
        await tester.pumpAndSettle();

        await tester.pump(const Duration(milliseconds: 1000));

        // Paso 3: Verificar que estamos de vuelta en la pantalla de login y escribir un email
        final emailField = find.byType(TextField).first;
        expect(
          emailField,
          findsOneWidget,
          reason: 'Debería encontrar el campo de email',
        );
        await tester.enterText(emailField, 'test@example.com');
        await tester.pumpAndSettle();

        // Verificar que el email se escribió correctamente
        expect(
          find.text('test@example.com'),
          findsOneWidget,
          reason: 'El email debería estar visible en el campo de entrada',
        );

        // Paso 4: Hacer clic en el botón "Continuar" para ir a la pantalla de contraseña
        final continueButton = find.text('Continuar');
        expect(
          continueButton,
          findsOneWidget,
          reason: 'Debería encontrar el botón Continuar',
        );
        await tester.tap(continueButton);
        await tester.pumpAndSettle();

        await tester.pump(const Duration(milliseconds: 1000));

        // Paso 5: Verificar que estamos en la pantalla de contraseña y escribir una contraseña
        final passwordFields = find.byType(TextField);
        expect(
          passwordFields,
          findsAtLeastNWidgets(2),
          reason: 'Debería encontrar al menos 2 campos (email y contraseña)',
        );

        // El segundo campo debe ser el de contraseña
        final passwordField = passwordFields.at(1);
        await tester.enterText(passwordField, 'MiPassword123!');
        await tester.pumpAndSettle();

        // Paso 6: Hacer clic en el segundo botón "Continuar" para intentar hacer login
        final loginButton = find.text('Continuar').last;
        expect(
          loginButton,
          findsOneWidget,
          reason: 'Debería encontrar el botón Continuar para hacer login',
        );
        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        // Esperar un momento para que el login se procese
        await tester.pump(const Duration(milliseconds: 2000));

        // Paso 7: Verificar que se redirigió correctamente a la pantalla de home
        // Esperar un poco más para que la navegación se complete
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Buscar indicadores de que estamos en la pantalla de home
        final homeWelcomeText = find.textContaining('¡Hola,');
        final appBarDataText = find.text('data');

        // Al menos uno de estos elementos debe estar presente para confirmar que estamos en home
        final isNowInHomePage =
            homeWelcomeText.evaluate().isNotEmpty ||
            appBarDataText.evaluate().isNotEmpty ||
            find.byType(CustomScrollView).evaluate().isNotEmpty;

        expect(
          isNowInHomePage,
          isTrue,
          reason:
              'Debería estar en la pantalla de home después del login exitoso',
        );

        // Verificación adicional: no debería estar más en la pantalla de autenticación
        final authPageNotPresent = find
            .byKey(const Key('initial_page'))
            .evaluate()
            .isEmpty;
        expect(
          authPageNotPresent,
          isTrue,
          reason: 'No debería estar más en la pantalla de autenticación',
        );
      },
    );
  });
}
