import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/checkboxs/custom_checkbox_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../helpers/pump_app.dart';

void main() {
  group('CustomCheckboxWidget', () {
    testWidgets('debería mostrar el texto del checkbox correctamente', (
      tester,
    ) async {
      // Arrange
      const checkboxText = 'Acepto los términos y condiciones';

      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          textCheckbox: checkboxText,
          value: false,
          onChanged: (value) {},
        ),
      );

      // Assert
      expect(find.text(checkboxText), findsOneWidget);
    });

    testWidgets('debería mostrar checkbox marcado cuando value es true', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          textCheckbox: 'Test checkbox',
          value: true,
          onChanged: (value) {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('no debería mostrar check cuando value es false', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          textCheckbox: 'Test checkbox',
          value: false,
          onChanged: (value) {},
        ),
      );

      // Assert
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('debería llamar onChanged cuando se toca', (tester) async {
      // Arrange
      bool? changedValue;

      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          textCheckbox: 'Test checkbox',
          value: false,
          onChanged: (value) => changedValue = value,
        ),
      );

      // Tap en el container del checkbox
      await tester.tap(find.byType(InkWell));

      // Assert
      expect(changedValue, isTrue);
    });

    testWidgets('debería mostrar título cuando se proporciona', (tester) async {
      // Arrange
      const title = 'Términos legales';

      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          title: title,
          textCheckbox: 'Acepto términos',
          value: false,
          onChanged: (value) {},
        ),
      );

      // Assert
      expect(find.text(title), findsOneWidget);
    });

    testWidgets('debería mostrar mensaje de error cuando showError es true', (
      tester,
    ) async {
      // Arrange
      const errorMessage = 'Debes aceptar los términos';

      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          textCheckbox: 'Acepto términos',
          value: false,
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
        const errorMessage = 'Debes aceptar los términos';

        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Acepto términos',
            value: false,
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
        const infoMessage = 'Lee los términos antes de aceptar';

        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Acepto términos',
            value: false,
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
      // Arrange
      bool wasCalled = false;

      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          textCheckbox: 'Test checkbox',
          value: false,
          enabled: false,
          onChanged: (value) => wasCalled = true,
        ),
      );

      // Intenta hacer tap
      await tester.tap(find.byType(InkWell));

      // Assert - no debería haber llamado al callback
      expect(wasCalled, isFalse);
    });

    testWidgets(
      'debería mostrar contenido personalizado cuando se proporciona childContent',
      (tester) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: false,
            onChanged: (value) {},
            childContent: const Text('Contenido personalizado'),
          ),
        );

        // Assert
        expect(find.text('Contenido personalizado'), findsOneWidget);
      },
    );

    testWidgets('debería alternar valor al hacer tap múltiples veces', (
      tester,
    ) async {
      // Arrange
      bool currentValue = false;

      await tester.pumpApp(
        StatefulBuilder(
          builder: (context, setState) {
            return CustomCheckboxWidget(
              textCheckbox: 'Test checkbox',
              value: currentValue,
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                });
              },
            );
          },
        ),
      );

      // Act & Assert - Primera tap
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Act & Assert - Segunda tap
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets(
      'debería tener diferentes estados visuales para enabled/disabled',
      (tester) async {
        // Test enabled
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox enabled',
            value: false,
            enabled: true,
            onChanged: (value) {},
          ),
        );

        expect(find.text('Test checkbox enabled'), findsOneWidget);

        // Test disabled
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox disabled',
            value: false,
            enabled: false,
            onChanged: (value) {},
          ),
        );

        expect(find.text('Test checkbox disabled'), findsOneWidget);
      },
    );

    testWidgets('debería manejar casos complejos con título, error e info', (
      tester,
    ) async {
      // Act
      await tester.pumpApp(
        CustomCheckboxWidget(
          title: 'Política de privacidad',
          textCheckbox: 'He leído y acepto la política de privacidad',
          value: true,
          onChanged: (value) {},
          showError: false,
          errorText: 'Debes aceptar la política',
          infoText: 'Tu información estará protegida',
        ),
      );

      // Assert
      expect(find.text('Política de privacidad'), findsOneWidget);
      expect(
        find.text('He leído y acepto la política de privacidad'),
        findsOneWidget,
      );
      expect(find.text('Tu información estará protegida'), findsOneWidget);
      expect(
        find.text('Debes aceptar la política'),
        findsNothing,
      ); // showError es false
      expect(find.byIcon(Icons.check), findsOneWidget); // value es true
    });
  });
}
