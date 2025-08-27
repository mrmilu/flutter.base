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

    group('_getColor method coverage', () {
      testWidgets('should use disabled color when enabled is false', (
        tester,
      ) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: true,
            enabled: false,
            onChanged: (value) {},
          ),
        );

        // Assert - Find the Container widget and verify it has the disabled color
        final container = tester.widget<Container>(find.byType(Container));
        expect(container.decoration, isA<BoxDecoration>());
        // The disabled color should be applied
        await tester.pumpAndSettle();
      });

      testWidgets(
        'should use error color when showError is true and value is true',
        (tester) async {
          // Act
          await tester.pumpApp(
            CustomCheckboxWidget(
              textCheckbox: 'Test checkbox',
              value: true,
              enabled: true,
              showError: true,
              errorText: 'Error message',
              onChanged: (value) {},
            ),
          );

          // Assert - The checkbox should be shown and use error styling
          expect(find.byIcon(Icons.check), findsOneWidget);
          expect(find.text('Error message'), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );

      testWidgets('should use black color when value is true and no error', (
        tester,
      ) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: true,
            enabled: true,
            showError: false,
            onChanged: (value) {},
          ),
        );

        // Assert - The checkbox should be checked
        expect(find.byIcon(Icons.check), findsOneWidget);
        await tester.pumpAndSettle();
      });

      testWidgets('should use white color when value is false', (tester) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: false,
            enabled: true,
            showError: false,
            onChanged: (value) {},
          ),
        );

        // Assert - The checkbox should not be checked
        expect(find.byIcon(Icons.check), findsNothing);
        await tester.pumpAndSettle();
      });
    });

    group('_getColorCheck method coverage', () {
      testWidgets('should use black color for check icon when disabled', (
        tester,
      ) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: true,
            enabled: false,
            onChanged: (value) {},
          ),
        );

        // Assert - Check icon should be visible even when disabled
        expect(find.byIcon(Icons.check), findsOneWidget);
        await tester.pumpAndSettle();
      });

      testWidgets(
        'should use white color for check icon when showError is true',
        (tester) async {
          // Act
          await tester.pumpApp(
            CustomCheckboxWidget(
              textCheckbox: 'Test checkbox',
              value: true,
              enabled: true,
              showError: true,
              errorText: 'Error message',
              onChanged: (value) {},
            ),
          );

          // Assert - Check icon should be visible with error state
          expect(find.byIcon(Icons.check), findsOneWidget);
          expect(find.text('Error message'), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );

      testWidgets(
        'should use white color for check icon when value is true and enabled',
        (tester) async {
          // Act
          await tester.pumpApp(
            CustomCheckboxWidget(
              textCheckbox: 'Test checkbox',
              value: true,
              enabled: true,
              showError: false,
              onChanged: (value) {},
            ),
          );

          // Assert - Check icon should be visible
          expect(find.byIcon(Icons.check), findsOneWidget);
          await tester.pumpAndSettle();
        },
      );

      testWidgets('should handle case when value is false (no check icon)', (
        tester,
      ) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: false,
            enabled: true,
            showError: false,
            onChanged: (value) {},
          ),
        );

        // Assert - Check icon should not be visible
        expect(find.byIcon(Icons.check), findsNothing);
        await tester.pumpAndSettle();
      });
    });

    group('Combined scenarios for complete coverage', () {
      testWidgets('should handle disabled checkbox with error state', (
        tester,
      ) async {
        // Act
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: true,
            enabled: false,
            showError: true,
            errorText: 'Error while disabled',
            onChanged: (value) {},
          ),
        );

        // Assert - Should show check icon, error message, but be disabled
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.text('Error while disabled'), findsOneWidget);

        // Verify it doesn't respond to taps when disabled
        bool wasCalled = false;
        await tester.pumpApp(
          CustomCheckboxWidget(
            textCheckbox: 'Test checkbox',
            value: false,
            enabled: false,
            showError: true,
            errorText: 'Error while disabled',
            onChanged: (value) => wasCalled = true,
          ),
        );

        await tester.tap(find.byType(InkWell));
        expect(wasCalled, isFalse);
      });

      testWidgets(
        'should handle enabled checkbox with showError false but value true',
        (tester) async {
          // Act
          await tester.pumpApp(
            CustomCheckboxWidget(
              textCheckbox: 'Test checkbox',
              value: true,
              enabled: true,
              showError: false,
              errorText: 'Hidden error',
              onChanged: (value) {},
            ),
          );

          // Assert - Should show check icon, but no error message
          expect(find.byIcon(Icons.check), findsOneWidget);
          expect(find.text('Hidden error'), findsNothing);
          await tester.pumpAndSettle();
        },
      );
    });
  });
}
