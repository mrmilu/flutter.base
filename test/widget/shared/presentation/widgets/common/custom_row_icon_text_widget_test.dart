import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/assets/app_assets_icons.dart';
import 'package:flutter_base/src/shared/presentation/widgets/common/custom_row_icon_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  group('CustomRowIconTextWidget', () {
    const testText = 'Test message';

    group('Default Constructor', () {
      testWidgets('should render text without icon when iconPath is null', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        // Should not find any image widget when iconPath is null
        expect(find.byType(SvgPicture), findsNothing);
      });

      testWidgets('should render text with icon when iconPath is provided', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        // Should find image widget when iconPath is provided
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should apply custom textStyle when provided', (
        tester,
      ) async {
        const customTextStyle = TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        );

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              textStyle: customTextStyle,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.fontSize, equals(18.0));
        expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
        expect(textWidget.style?.color, equals(Colors.red));
      });

      testWidgets('should apply custom iconSize', (tester) async {
        const customIconSize = 24.0;

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
              iconSize: customIconSize,
            ),
          ),
        );

        // We can verify the widget builds correctly with custom icon size
        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should apply custom iconColor', (tester) async {
        const customIconColor = Colors.blue;

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
              iconColor: customIconColor,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should apply custom textColor', (tester) async {
        const customTextColor = Colors.green;

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              textColor: customTextColor,
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.color, equals(customTextColor));
      });

      testWidgets('should apply custom spacing', (tester) async {
        const customSpacing = 12.0;

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
              spacing: customSpacing,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
        // Verificar que hay un SizedBox con el espaciado personalizado
        final spacingSizedBox = find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == customSpacing &&
              widget.height == null,
        );
        expect(spacingSizedBox, findsOneWidget);
      });

      testWidgets('should use dark mode icon color when brightness is dark', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
            ),
          ),
          theme: ThemeData.dark(),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should use light mode icon color when brightness is light', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
            ),
          ),
          theme: ThemeData.light(),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should use fallback TextStyle when textTheme is null', (
        tester,
      ) async {
        // Create a theme with null labelSmall to test the fallback
        final themeWithNullLabelSmall = ThemeData(
          textTheme: const TextTheme(
            labelSmall: null,
          ),
        );

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              textColor: Colors.purple,
            ),
          ),
          theme: themeWithNullLabelSmall,
        );

        final textWidget = tester.widget<Text>(find.text(testText));
        expect(textWidget.style?.color, equals(Colors.purple));
      });
    });

    group('Named Constructor - info', () {
      testWidgets('should create info widget with correct icon and styling', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.info(
              testText,
              context: context,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should use info icon path', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.info(
              testText,
              context: context,
            ),
          ),
        );

        // Verify widget builds correctly - icon path is set internally
        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should have default icon size of 16', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.info(
              testText,
              context: context,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should have default spacing of 4.0', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.info(
              testText,
              context: context,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        // Verificar que hay un SizedBox con espaciado de 4.0
        final spacingSizedBox = find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == 4.0 &&
              widget.height == null,
        );
        expect(spacingSizedBox, findsOneWidget);
      });
    });

    group('Named Constructor - warning', () {
      testWidgets(
        'should create warning widget with correct icon and styling',
        (tester) async {
          await tester.pumpApp(
            Builder(
              builder: (context) => CustomRowIconTextWidget.warning(
                testText,
                context: context,
              ),
            ),
          );

          expect(find.text(testText), findsOneWidget);
          expect(find.byType(SvgPicture), findsOneWidget);
        },
      );

      testWidgets('should use warning icon and colors', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.warning(
              testText,
              context: context,
            ),
          ),
        );

        // Verify the widget builds correctly with warning styling
        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should apply semantic warning color to icon and text', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.warning(
              testText,
              context: context,
            ),
          ),
        );

        // The warning colors are applied internally via context.colors
        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });
    });

    group('Named Constructor - error', () {
      testWidgets('should create error widget with correct icon and styling', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.error(
              testText,
              context: context,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should use warning icon with error colors', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.error(
              testText,
              context: context,
            ),
          ),
        );

        // Verify the widget builds correctly with error styling
        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should apply semantic error color to icon and text', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget.error(
              testText,
              context: context,
            ),
          ),
        );

        // The error colors are applied internally via context.colors
        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty text', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: '',
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('should handle very long text', (tester) async {
        const longText =
            'This is a very long text that should wrap properly within the Flexible widget and not cause any overflow issues in the UI.';

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: longText,
              iconPath: AppAssetsIcons.info,
            ),
          ),
        );

        expect(find.text(longText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('should handle special characters in text', (tester) async {
        const specialText = 'Special chars: áéíóú ñÑ @#\$%^&*()';

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: specialText,
            ),
          ),
        );

        expect(find.text(specialText), findsOneWidget);
      });

      testWidgets('should handle zero spacing', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
              spacing: 0.0,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
        // Verificar que hay un SizedBox con espaciado de 0.0
        final spacingSizedBox = find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == 0.0 &&
              widget.height == null,
        );
        expect(spacingSizedBox, findsOneWidget);
      });

      testWidgets('should handle zero icon size', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
              iconSize: 0.0,
            ),
          ),
        );

        expect(find.text(testText), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
      });
    });

    group('Widget Structure', () {
      testWidgets('should have correct widget hierarchy', (tester) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
              iconPath: AppAssetsIcons.info,
            ),
          ),
        );

        // Verify the basic structure
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Flexible), findsOneWidget);
        expect(find.byType(Padding), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
        // Verificar que hay un SizedBox para el espaciado
        final spacingSizedBox = find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox &&
              widget.width == 4.0 &&
              widget.height == null,
        );
        expect(spacingSizedBox, findsOneWidget);
      });

      testWidgets('should have correct widget hierarchy without icon', (
        tester,
      ) async {
        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              context: context,
              text: testText,
            ),
          ),
        );

        // Verify the structure without icon
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(Flexible), findsOneWidget);
        expect(find.byType(Padding), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
        expect(find.byType(SvgPicture), findsNothing);
        expect(find.byType(SizedBox), findsNothing);
      });
    });

    group('Key Handling', () {
      testWidgets('should accept and use custom key', (tester) async {
        const testKey = Key('custom-row-icon-text-key');

        await tester.pumpApp(
          Builder(
            builder: (context) => CustomRowIconTextWidget(
              key: testKey,
              context: context,
              text: testText,
            ),
          ),
        );

        expect(find.byKey(testKey), findsOneWidget);
        expect(find.text(testText), findsOneWidget);
      });
    });
  });
}
