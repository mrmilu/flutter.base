import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/buttons/future_button.dart';
import 'package:flutter_test/flutter_test.dart';

/*
Este test comprueba que el onPressed es
llamado correctamente cuando se toca el botón, que el botón
se desactiva mientras isLoading es verdadero, y que se muestra
el widget de carga (loadingBuilder) cuando isLoading es verdadero.

By GPTChat & edited by amunoz
 */
void main() {
  testWidgets(
      'Cuando se pulsa el botón, isLoading cambia a true y a false al finalizar',
      (WidgetTester tester) async {
    bool onPressedCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: FutureButton(
          onPressed: () async {
            onPressedCalled = true;
            await Future.delayed(const Duration(milliseconds: 500));
          },
          childBuilder: (isLoading) => const Text('Press me'),
        ),
      ),
    );

    expect(find.byType(FutureButton), findsOneWidget);
    expect(find.text('Press me'), findsOneWidget);

    await tester.tap(find.byType(FutureButton));
    await tester.pump();

    expect(onPressedCalled, isTrue);

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Press me'), findsOneWidget);
  });

  testWidgets(
      'Cuando isLoading es true, se muestra un CircularProgressIndicator',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FutureButton(
          onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          childBuilder: (isLoading) => isLoading
              ? const CircularProgressIndicator()
              : const Text('Press me'),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(find.byType(FutureButton), findsOneWidget);
    expect(find.text('Press me'), findsOneWidget);

    await tester.tap(find.byType(FutureButton));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Press me'), findsNothing);

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Press me'), findsOneWidget);
  });

  testWidgets(
      'Si disableWhenIsLoading es true, el botón se deshabilita cuando isLoading es true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FutureButton(
          onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          childBuilder: (isLoading) => const Text('Press me'),
        ),
      ),
    );

    expect(find.byType(FutureButton), findsOneWidget);
    expect(find.text('Press me'), findsOneWidget);

    await tester.tap(find.byType(FutureButton));
    await tester.pump();

    expect(
      (tester.widget(find.byType(MaterialButton)) as MaterialButton).enabled,
      isFalse,
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(
      (tester.widget(find.byType(MaterialButton)) as MaterialButton).enabled,
      isTrue,
    );
  });

  testWidgets(
      'Si disableWhenIsLoading es false, el botón no se deshabilita cuando isLoading es true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FutureButton(
          onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          childBuilder: (isLoading) => const Text('Press me'),
          disableWhenIsLoading: false,
        ),
      ),
    );

    expect(find.byType(FutureButton), findsOneWidget);

    await tester.tap(find.byType(FutureButton));
    await tester.pump();

    expect(
      (tester.widget(find.byType(MaterialButton)) as MaterialButton).enabled,
      isTrue,
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(
      (tester.widget(find.byType(MaterialButton)) as MaterialButton).enabled,
      isTrue,
    );
  });
}
