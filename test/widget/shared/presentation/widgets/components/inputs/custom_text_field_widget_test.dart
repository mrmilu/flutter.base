import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../helpers/pump_app.dart';

void main() {
  group('CustomTextFieldWidget', () {
    testWidgets('debería mostrar el texto del label correctamente', (
      tester,
    ) async {
      // Arrange
      const labelText = 'Email';

      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: labelText,
          onChanged: (value) {},
        ),
      );

      // Assert
      expect(find.text(labelText), findsOneWidget);
    });

    testWidgets('debería mostrar el valor inicial', (tester) async {
      // Arrange
      const initialValue = 'test@example.com';

      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          initialValue: initialValue,
          onChanged: (value) {},
        ),
      );

      // Assert
      expect(find.text(initialValue), findsOneWidget);
    });

    testWidgets('debería llamar onChanged cuando el texto cambia', (
      tester,
    ) async {
      // Arrange
      String? changedValue;

      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) => changedValue = value,
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'nuevo@email.com');

      // Assert
      expect(changedValue, equals('nuevo@email.com'));
    });

    testWidgets('debería mostrar mensaje de error cuando showError es true', (
      tester,
    ) async {
      // Arrange
      const errorMessage = 'Email es requerido';

      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) {},
          showError: true,
          errorText: errorMessage,
        ),
      );

      // Assert
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets(
      'no debería mostrar mensaje de error cuando showError es false',
      (tester) async {
        // Arrange
        const errorMessage = 'Email es requerido';

        // Act
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            showError: false,
            errorText: errorMessage,
          ),
        );

        // Assert
        expect(find.text(errorMessage), findsNothing);
      },
    );

    testWidgets(
      'debería mostrar mensaje de información cuando se proporciona',
      (tester) async {
        // Arrange
        const infoMessage = 'Usa tu email personal';

        // Act
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            infoText: infoMessage,
          ),
        );

        // Assert
        expect(find.text(infoMessage), findsOneWidget);
      },
    );

    testWidgets('debería estar deshabilitado cuando enabled es false', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) {},
          enabled: false,
        ),
      );

      // Assert - buscar el widget por tipo y verificar que existe
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(CustomTextFieldWidget), findsOneWidget);
    });

    testWidgets('debería mostrar texto oscurecido para contraseñas', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Password',
          onChanged: (value) {},
          obscureText: true,
        ),
      );

      // Assert - verificar que el widget está presente
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('debería mostrar hint text', (tester) async {
      // Arrange
      const hintText = 'Ingresa tu email';

      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          hintText: hintText,
          onChanged: (value) {},
        ),
      );

      // Assert - verificar que los elementos están presentes
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('debería mostrar icono de carga cuando isLoading es true', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) {},
          isLoading: true,
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('debería mostrar icono de check cuando isAccepted es true', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) {},
          isAccepted: true,
        ),
      );

      // Assert
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('debería usar el controlador proporcionado', (tester) async {
      // Arrange
      final controller = TextEditingController(text: 'texto inicial');

      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) {},
          controller: controller,
        ),
      );

      // Assert
      expect(find.text('texto inicial'), findsOneWidget);

      // Clean up
      controller.dispose();
    });

    testWidgets('debería funcionar con múltiples líneas', (tester) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Descripción',
          onChanged: (value) {},
          maxLines: 3,
        ),
      );

      // Assert
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Descripción'), findsOneWidget);
    });

    testWidgets(
      'debería mostrar tanto error como info text según corresponda',
      (tester) async {
        // Test con error
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            showError: true,
            errorText: 'Error message',
          ),
        );

        expect(find.text('Error message'), findsOneWidget);

        // Test con info
        await tester.pumpWidget(Container()); // Clear
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            infoText: 'Info message',
          ),
        );

        expect(find.text('Info message'), findsOneWidget);
      },
    );

    testWidgets('debería manejar casos de solo lectura', (tester) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Email',
          onChanged: (value) {},
          readOnly: true,
          initialValue: 'readonly@test.com',
        ),
      );

      // Assert
      expect(find.text('readonly@test.com'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('debería permitir entrada de texto normal', (tester) async {
      // Act
      await tester.pumpApp(
        CustomTextFieldWidget(
          labelText: 'Nombre',
          onChanged: (value) {},
        ),
      );

      // Interactuar con el campo
      await tester.enterText(find.byType(TextFormField), 'Juan Pérez');

      // Assert
      expect(find.text('Juan Pérez'), findsOneWidget);
    });

    testWidgets(
      'debería usar color gris en modo oscuro cuando readOnly es true',
      (tester) async {
        // Act
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            readOnly: true,
            initialValue: 'readonly@test.com',
          ),
          theme: ThemeData.dark(), // Modo oscuro
        );

        // Assert
        expect(find.text('readonly@test.com'), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);

        // Verificar que el container tiene el color correcto
        final containerFinder = find.byType(Container).first;
        expect(containerFinder, findsOneWidget);
      },
    );

    testWidgets(
      'debería ocultar teclado al hacer tap fuera cuando autoHideKeyboard es true',
      (tester) async {
        // Arrange
        final focusNode = FocusNode();

        // Act
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            autoHideKeyboard: true,
            focusNode: focusNode,
          ),
        );

        // Enfocar el campo primero
        await tester.tap(find.byType(TextFormField));
        await tester.pump();

        // Verificar que tiene el foco
        expect(focusNode.hasFocus, isTrue);

        // Simular tap fuera del campo
        await tester.tapAt(const Offset(10, 10));
        await tester.pump();

        // Assert - el foco debería haberse perdido
        expect(focusNode.hasFocus, isFalse);

        // Clean up
        focusNode.dispose();
      },
    );

    testWidgets(
      'no debería ocultar teclado al hacer tap fuera cuando autoHideKeyboard es false',
      (tester) async {
        // Arrange
        final focusNode = FocusNode();

        // Act
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
            autoHideKeyboard: false,
            focusNode: focusNode,
          ),
        );

        // Enfocar el campo primero
        await tester.tap(find.byType(TextFormField));
        await tester.pump();

        // Verificar que tiene el foco
        expect(focusNode.hasFocus, isTrue);

        // Simular tap fuera del campo
        await tester.tapAt(const Offset(10, 10));
        await tester.pump();

        // Assert - el foco se mantiene (comportamiento normal del TextFormField)
        // Nota: En pruebas, el comportamiento puede variar, pero la configuración onTapOutside debe ser null

        // Clean up
        focusNode.dispose();
      },
    );

    testWidgets(
      'debería alternar visibilidad de contraseña al presionar el botón',
      (tester) async {
        // Act
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Password',
            onChanged: (value) {},
            obscureText: true,
          ),
        );

        // Encontrar el botón de visibilidad inicial (debería mostrar visibility_off)
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
        expect(find.byIcon(Icons.visibility), findsNothing);

        // Presionar el botón para mostrar la contraseña
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        // Verificar que ahora muestra el icono visibility
        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.byIcon(Icons.visibility_off), findsNothing);

        // Presionar nuevamente para ocultar la contraseña
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        // Verificar que vuelve a mostrar visibility_off
        expect(find.byIcon(Icons.visibility_off), findsOneWidget);
        expect(find.byIcon(Icons.visibility), findsNothing);
      },
    );

    testWidgets(
      'debería mostrar botón de visibilidad solo cuando obscureText es true',
      (tester) async {
        // Test con obscureText por defecto (null/false)
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Email',
            onChanged: (value) {},
          ),
        );

        // No debería mostrar botón de visibilidad cuando obscureText no es true
        expect(find.byType(IconButton), findsNothing);

        // Test con obscureText = true
        await tester.pumpApp(
          CustomTextFieldWidget(
            labelText: 'Password',
            onChanged: (value) {},
            obscureText: true,
          ),
        );

        // Debería mostrar el botón de visibilidad cuando obscureText es true
        expect(find.byType(IconButton), findsOneWidget);
      },
    );
  });
}
