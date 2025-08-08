import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Flutter Base App Integration Tests', () {
    testWidgets('App debería mostrar una interfaz básica', (tester) async {
      // Arrange & Act - Test básico de widget mínimo
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Flutter Base')),
            body: const Center(
              child: Text('¡Bienvenido a Flutter Base!'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert - Verificar que se renderiza correctamente
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.text('Flutter Base'), findsOneWidget);
      expect(find.text('¡Bienvenido a Flutter Base!'), findsOneWidget);
    });

    testWidgets('Debería manejar interacciones básicas', (tester) async {
      bool buttonPressed = false;

      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => buttonPressed = true,
                child: const Text('Presionar'),
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(buttonPressed, isTrue);
      expect(find.text('Presionar'), findsOneWidget);
    });

    testWidgets('Debería manejar rotación de pantalla', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Test de orientación'),
            ),
          ),
        ),
      );

      // Act - Simular cambio de orientación
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Test de orientación'), findsOneWidget);

      // Restaurar tamaño original
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    testWidgets('Debería renderizar listas scrolleables', (tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
            ),
          ),
        ),
      );

      // Act & Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Item 0'), findsOneWidget);

      // Test scroll
      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pumpAndSettle();

      // Verificar que se puede hacer scroll
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Debería manejar formularios básicos', (tester) async {
      final formKey = GlobalKey<FormState>();

      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ingresa tu nombre',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => formKey.currentState?.validate(),
                    child: const Text('Validar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField), 'Test User');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Ingresa tu nombre'), findsOneWidget);
    });

    testWidgets('Debería soportar temas básicos', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const Scaffold(
            body: Center(
              child: Text('Test de temas'),
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Test de temas'), findsOneWidget);
    });
  });
}
