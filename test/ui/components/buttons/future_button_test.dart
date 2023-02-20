import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/buttons/future_button.dart';
import 'package:flutter_test/flutter_test.dart';

/*
This test verifies that the onPressed is
called correctly when the button is touched, that the button
is disabled while isLoading is true, and that is displayed
the loading widget (loadingBuilder) when isLoading is true.

By GPTChat & edited by amunoz
 */
void main() {
  testWidgets(
      "When the button is clicked, isLoading changes to true and false when it's complete",
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

  testWidgets('When isLoading is true, display a CircularProgressIndicator',
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
      'If disableWhenIsLoading is true, the button will be disabled when isLoading is true',
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
      'If disableWhenIsLoading is false, the button will not disabled when isLoading is true',
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
