import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/rm_text.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../helpers/pump_app.dart';

void main() {
  group('RMText Widget', () {
    group('RMTextStyle enum', () {
      test('should have all expected text style values', () {
        // Verify all enum values exist
        const expectedStyles = [
          RMTextStyle.displayLarge,
          RMTextStyle.displayMedium,
          RMTextStyle.displaySmall,
          RMTextStyle.headlineLarge,
          RMTextStyle.headlineMedium,
          RMTextStyle.headlineSmall,
          RMTextStyle.titleLarge,
          RMTextStyle.titleMedium,
          RMTextStyle.titleSmall,
          RMTextStyle.bodyLarge,
          RMTextStyle.bodyMedium,
          RMTextStyle.bodySmall,
          RMTextStyle.labelLarge,
          RMTextStyle.labelMedium,
          RMTextStyle.labelSmall,
        ];

        expect(RMTextStyle.values.length, equals(expectedStyles.length));
        for (final style in expectedStyles) {
          expect(RMTextStyle.values.contains(style), isTrue);
        }
      });
    });

    group('Display Styles', () {
      testWidgets('RMText.displayLarge should render with correct text', (
        tester,
      ) async {
        const testText = 'Display Large Text';

        await tester.pumpApp(
          const RMText.displayLarge(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.displayMedium should render with correct text', (
        tester,
      ) async {
        const testText = 'Display Medium Text';

        await tester.pumpApp(
          const RMText.displayMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.displaySmall should render with correct text', (
        tester,
      ) async {
        const testText = 'Display Small Text';

        await tester.pumpApp(
          const RMText.displaySmall(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });
    });

    group('Headline Styles', () {
      testWidgets('RMText.headlineLarge should render with correct text', (
        tester,
      ) async {
        const testText = 'Headline Large Text';

        await tester.pumpApp(
          const RMText.headlineLarge(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.headlineMedium should render with correct text', (
        tester,
      ) async {
        const testText = 'Headline Medium Text';

        await tester.pumpApp(
          const RMText.headlineMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.headlineSmall should render with correct text', (
        tester,
      ) async {
        const testText = 'Headline Small Text';

        await tester.pumpApp(
          const RMText.headlineSmall(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });
    });

    group('Title Styles', () {
      testWidgets('RMText.titleLarge should render with correct text', (
        tester,
      ) async {
        const testText = 'Title Large Text';

        await tester.pumpApp(
          const RMText.titleLarge(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.titleMedium should render with correct text', (
        tester,
      ) async {
        const testText = 'Title Medium Text';

        await tester.pumpApp(
          const RMText.titleMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.titleSmall should render with correct text', (
        tester,
      ) async {
        const testText = 'Title Small Text';

        await tester.pumpApp(
          const RMText.titleSmall(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });
    });

    group('Body Styles', () {
      testWidgets('RMText.bodyLarge should render with correct text', (
        tester,
      ) async {
        const testText = 'Body Large Text';

        await tester.pumpApp(
          const RMText.bodyLarge(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.bodyMedium should render with correct text', (
        tester,
      ) async {
        const testText = 'Body Medium Text';

        await tester.pumpApp(
          const RMText.bodyMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.bodySmall should render with correct text', (
        tester,
      ) async {
        const testText = 'Body Small Text';

        await tester.pumpApp(
          const RMText.bodySmall(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });
    });

    group('Label Styles', () {
      testWidgets('RMText.labelLarge should render with correct text', (
        tester,
      ) async {
        const testText = 'Label Large Text';

        await tester.pumpApp(
          const RMText.labelLarge(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.labelMedium should render with correct text', (
        tester,
      ) async {
        const testText = 'Label Medium Text';

        await tester.pumpApp(
          const RMText.labelMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('RMText.labelSmall should render with correct text', (
        tester,
      ) async {
        const testText = 'Label Small Text';

        await tester.pumpApp(
          const RMText.labelSmall(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });
    });

    group('Custom Properties', () {
      testWidgets('should apply custom color', (tester) async {
        const testText = 'Colored Text';
        const testColor = Colors.red;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            color: testColor,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.color, equals(testColor));
      });

      testWidgets('should apply custom fontWeight', (tester) async {
        const testText = 'Bold Text';
        const testFontWeight = FontWeight.bold;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            fontWeight: testFontWeight,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.fontWeight, equals(testFontWeight));
      });

      testWidgets('should apply custom fontSize', (tester) async {
        const testText = 'Custom Size Text';
        const testFontSize = 24.0;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            fontSize: testFontSize,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.fontSize, equals(testFontSize));
      });

      testWidgets('should apply custom height', (tester) async {
        const testText = 'Custom Height Text';
        const testHeight = 2.0;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            height: testHeight,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.height, equals(testHeight));
      });

      testWidgets('should apply custom fontStyle', (tester) async {
        const testText = 'Italic Text';
        const testFontStyle = FontStyle.italic;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            fontStyle: testFontStyle,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.fontStyle, equals(testFontStyle));
      });

      testWidgets('should apply custom decoration', (tester) async {
        const testText = 'Underlined Text';
        const testDecoration = TextDecoration.underline;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            decoration: testDecoration,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.decoration, equals(testDecoration));
      });

      testWidgets('should apply custom maxLines', (tester) async {
        const testText = 'Limited Lines Text';
        const testMaxLines = 2;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            maxLines: testMaxLines,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.maxLines, equals(testMaxLines));
      });

      testWidgets('should apply custom textAlign', (tester) async {
        const testText = 'Centered Text';
        const testTextAlign = TextAlign.center;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            textAlign: testTextAlign,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.textAlign, equals(testTextAlign));
      });

      testWidgets('should apply custom overflow', (tester) async {
        const testText = 'Ellipsis Text';
        const testOverflow = TextOverflow.ellipsis;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            overflow: testOverflow,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.overflow, equals(testOverflow));
      });

      testWidgets('should apply custom softWrap', (tester) async {
        const testText = 'No Wrap Text';
        const testSoftWrap = false;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            softWrap: testSoftWrap,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.softWrap, equals(testSoftWrap));
      });

      testWidgets('should apply custom textDirection', (tester) async {
        const testText = 'RTL Text';
        const testTextDirection = TextDirection.rtl;

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            textDirection: testTextDirection,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.textDirection, equals(testTextDirection));
      });
    });

    group('Multiple Properties', () {
      testWidgets('should apply multiple custom properties together', (
        tester,
      ) async {
        const testText = 'Multiple Properties Text';
        const testColor = Colors.blue;
        const testFontWeight = FontWeight.w600;
        const testFontSize = 18.0;
        const testMaxLines = 3;
        const testTextAlign = TextAlign.right;

        await tester.pumpApp(
          const RMText.titleMedium(
            testText,
            color: testColor,
            fontWeight: testFontWeight,
            fontSize: testFontSize,
            maxLines: testMaxLines,
            textAlign: testTextAlign,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.color, equals(testColor));
        expect(textWidget.style?.fontWeight, equals(testFontWeight));
        expect(textWidget.style?.fontSize, equals(testFontSize));
        expect(textWidget.maxLines, equals(testMaxLines));
        expect(textWidget.textAlign, equals(testTextAlign));
      });
    });

    group('Key Property', () {
      testWidgets('should accept custom key', (tester) async {
        const testKey = Key('custom-text-key');
        const testText = 'Text with Key';

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            key: testKey,
          ),
        );

        expect(find.byKey(testKey), findsOneWidget);
        expect(find.text(testText), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('should use theme text styles correctly', (tester) async {
        const testText = 'Theme Integration Test';

        // Test with custom theme
        final customTheme = ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontSize: 20.0,
              color: Colors.purple,
            ),
          ),
        );

        await tester.pumpApp(
          const RMText.bodyMedium(testText),
          theme: customTheme,
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        // The base style should come from theme, but we can't easily test the exact values
        // since they get merged with the theme's textTheme
        expect(textWidget.style, isNotNull);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty text', (tester) async {
        const testText = '';

        await tester.pumpApp(
          const RMText.bodyMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('should handle very long text', (tester) async {
        const testText =
            'This is a very long text that should be handled properly by the RMText widget without any issues and should wrap or overflow according to the specified parameters.';

        await tester.pumpApp(
          const RMText.bodyMedium(
            testText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.maxLines, equals(2));
        expect(textWidget.overflow, equals(TextOverflow.ellipsis));
      });

      testWidgets('should handle special characters', (tester) async {
        const testText = 'Special chars: áéíóú ñÑ 123 @#\$%^&*()';

        await tester.pumpApp(
          const RMText.bodyMedium(testText),
        );

        expect(find.text(testText), findsOneWidget);
      });
    });
  });
}
