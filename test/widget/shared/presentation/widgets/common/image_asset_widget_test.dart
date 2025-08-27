import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/widgets/common/image_asset_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/pump_app.dart';

void main() {
  group('ImageAssetWidget', () {
    const svgPath = 'assets/icons/info.svg';
    const pngPath = 'assets/images/ente_partial.png';

    group('Default Constructor', () {
      testWidgets('should render SvgPicture for SVG files', (tester) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(Image), findsNothing);
      });

      testWidgets('should render Image for PNG files', (tester) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(SvgPicture), findsNothing);
      });

      testWidgets('should apply width and height to SvgPicture', (
        tester,
      ) async {
        const testWidth = 24.0;
        const testHeight = 24.0;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
            width: testWidth,
            height: testHeight,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.width, equals(testWidth));
        expect(svgWidget.height, equals(testHeight));
      });

      testWidgets('should apply width and height to Image', (tester) async {
        const testWidth = 32.0;
        const testHeight = 32.0;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
            width: testWidth,
            height: testHeight,
          ),
        );

        final imageWidget = tester.widget<Image>(find.byType(Image));
        expect(imageWidget.width, equals(testWidth));
        expect(imageWidget.height, equals(testHeight));
      });

      testWidgets('should apply custom color to SVG', (tester) async {
        const customColor = Colors.red;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
            color: customColor,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(customColor, BlendMode.srcIn)),
        );
      });

      testWidgets('should apply custom color to Image', (tester) async {
        const customColor = Colors.green;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
            color: customColor,
          ),
        );

        final imageWidget = tester.widget<Image>(find.byType(Image));
        expect(imageWidget.color, equals(customColor));
      });

      testWidgets('should apply custom BoxFit to SVG', (tester) async {
        const customFit = BoxFit.contain;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
            fit: customFit,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.fit, equals(customFit));
      });

      testWidgets('should apply custom BoxFit to Image', (tester) async {
        const customFit = BoxFit.fitWidth;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
            fit: customFit,
          ),
        );

        final imageWidget = tester.widget<Image>(find.byType(Image));
        expect(imageWidget.fit, equals(customFit));
      });

      testWidgets('should apply custom BlendMode to SVG', (tester) async {
        const customBlendMode = BlendMode.multiply;
        const customColor = Colors.blue;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
            color: customColor,
            colorBlendMode: customBlendMode,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(customColor, customBlendMode)),
        );
      });

      testWidgets('should apply custom BlendMode to Image', (tester) async {
        const customBlendMode = BlendMode.overlay;
        const customColor = Colors.purple;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
            color: customColor,
            colorBlendMode: customBlendMode,
          ),
        );

        final imageWidget = tester.widget<Image>(find.byType(Image));
        expect(imageWidget.colorBlendMode, equals(customBlendMode));
        expect(imageWidget.color, equals(customColor));
      });

      testWidgets('should use theme-based color for SVG in light mode', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
          ),
          theme: ThemeData.light(),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
        );
      });

      testWidgets('should use theme-based color for SVG in dark mode', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
          ),
          theme: ThemeData.dark(),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        );
      });

      testWidgets('should not apply automatic color to Image files', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
          ),
          theme: ThemeData.light(),
        );

        final imageWidget = tester.widget<Image>(find.byType(Image));
        expect(imageWidget.color, isNull);
      });

      testWidgets('should handle uppercase SVG extension', (tester) async {
        const uppercaseSvgPath = 'assets/icons/test.SVG';

        await tester.pumpApp(
          const ImageAssetWidget(
            path: uppercaseSvgPath,
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(Image), findsNothing);
      });
    });

    group('Named Constructor - icon', () {
      testWidgets('should create icon widget with theme-based colors', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget.icon(
            path: svgPath,
          ),
          theme: ThemeData.light(),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
        );
      });

      testWidgets('should use white color in dark theme', (tester) async {
        await tester.pumpApp(
          const ImageAssetWidget.icon(
            path: svgPath,
          ),
          theme: ThemeData.dark(),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
        );
      });

      testWidgets('should apply width and height', (tester) async {
        const testWidth = 32.0;
        const testHeight = 32.0;

        await tester.pumpApp(
          const ImageAssetWidget.icon(
            path: svgPath,
            width: testWidth,
            height: testHeight,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.width, equals(testWidth));
        expect(svgWidget.height, equals(testHeight));
      });

      testWidgets('should apply custom BoxFit', (tester) async {
        const customFit = BoxFit.scaleDown;

        await tester.pumpApp(
          const ImageAssetWidget.icon(
            path: svgPath,
            fit: customFit,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.fit, equals(customFit));
      });

      testWidgets('should apply custom BlendMode', (tester) async {
        const customBlendMode = BlendMode.overlay;

        await tester.pumpApp(
          const ImageAssetWidget.icon(
            path: svgPath,
            colorBlendMode: customBlendMode,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(Colors.black, customBlendMode)),
        );
      });

      testWidgets(
        'should force theme color for PNG files with icon constructor',
        (tester) async {
          await tester.pumpApp(
            const ImageAssetWidget.icon(
              path: pngPath,
            ),
            theme: ThemeData.light(),
          );

          final imageWidget = tester.widget<Image>(find.byType(Image));
          expect(imageWidget.color, equals(Colors.black));
        },
      );
    });

    group('Named Constructor - colored', () {
      testWidgets('should create colored widget with specific color', (
        tester,
      ) async {
        const specificColor = Colors.green;

        await tester.pumpApp(
          const ImageAssetWidget.colored(
            path: svgPath,
            color: specificColor,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(specificColor, BlendMode.srcIn)),
        );
      });

      testWidgets('should ignore theme and use specified color', (
        tester,
      ) async {
        const specificColor = Colors.orange;

        await tester.pumpApp(
          const ImageAssetWidget.colored(
            path: svgPath,
            color: specificColor,
          ),
          theme: ThemeData.dark(),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(specificColor, BlendMode.srcIn)),
        );
      });

      testWidgets('should apply width and height', (tester) async {
        const testWidth = 48.0;
        const testHeight = 48.0;
        const specificColor = Colors.purple;

        await tester.pumpApp(
          const ImageAssetWidget.colored(
            path: svgPath,
            color: specificColor,
            width: testWidth,
            height: testHeight,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.width, equals(testWidth));
        expect(svgWidget.height, equals(testHeight));
      });

      testWidgets('should apply custom BoxFit', (tester) async {
        const customFit = BoxFit.fitWidth;
        const specificColor = Colors.cyan;

        await tester.pumpApp(
          const ImageAssetWidget.colored(
            path: svgPath,
            color: specificColor,
            fit: customFit,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.fit, equals(customFit));
      });

      testWidgets('should apply custom BlendMode', (tester) async {
        const customBlendMode = BlendMode.difference;
        const specificColor = Colors.yellow;

        await tester.pumpApp(
          const ImageAssetWidget.colored(
            path: svgPath,
            color: specificColor,
            colorBlendMode: customBlendMode,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(specificColor, customBlendMode)),
        );
      });

      testWidgets('should work with PNG files', (tester) async {
        const specificColor = Colors.orange;

        await tester.pumpApp(
          const ImageAssetWidget.colored(
            path: pngPath,
            color: specificColor,
          ),
        );

        final imageWidget = tester.widget<Image>(find.byType(Image));
        expect(imageWidget.color, equals(specificColor));
      });
    });

    group('Logic Tests (without asset loading)', () {
      test('should detect SVG files correctly', () {
        const widget = ImageAssetWidget(path: 'test.svg');
        expect(widget.path.toLowerCase().endsWith('svg'), isTrue);
      });

      test('should detect PNG files correctly', () {
        const widget = ImageAssetWidget(path: 'test.png');
        expect(widget.path.toLowerCase().endsWith('png'), isTrue);
        expect(widget.path.toLowerCase().endsWith('svg'), isFalse);
      });

      test('should detect JPG files correctly', () {
        const widget = ImageAssetWidget(path: 'test.jpg');
        expect(widget.path.toLowerCase().endsWith('jpg'), isTrue);
        expect(widget.path.toLowerCase().endsWith('svg'), isFalse);
      });

      test('should handle mixed case SVG extension', () {
        const widget = ImageAssetWidget(path: 'test.Svg');
        expect(widget.path.toLowerCase().endsWith('svg'), isTrue);
      });

      test('should handle empty path', () {
        const widget = ImageAssetWidget(path: '');
        expect(widget.path.isEmpty, isTrue);
        expect(widget.path.toLowerCase().endsWith('svg'), isFalse);
      });

      test('should handle path without extension', () {
        const widget = ImageAssetWidget(path: 'test');
        expect(widget.path.toLowerCase().endsWith('svg'), isFalse);
      });

      test('should store properties correctly', () {
        const widget = ImageAssetWidget(
          path: 'test.png',
          width: 100,
          height: 200,
          color: Colors.red,
          fit: BoxFit.contain,
          colorBlendMode: BlendMode.multiply,
          useThemeColor: true,
        );

        expect(widget.path, equals('test.png'));
        expect(widget.width, equals(100));
        expect(widget.height, equals(200));
        expect(widget.color, equals(Colors.red));
        expect(widget.fit, equals(BoxFit.contain));
        expect(widget.colorBlendMode, equals(BlendMode.multiply));
        expect(widget.useThemeColor, isTrue);
      });

      test('should have correct default values', () {
        const widget = ImageAssetWidget(path: 'test.png');

        expect(widget.path, equals('test.png'));
        expect(widget.width, isNull);
        expect(widget.height, isNull);
        expect(widget.color, isNull);
        expect(widget.fit, equals(BoxFit.cover));
        expect(widget.colorBlendMode, equals(BlendMode.srcIn));
        expect(widget.useThemeColor, isFalse);
      });

      test('icon constructor should set useThemeColor to true', () {
        const widget = ImageAssetWidget.icon(path: 'test.svg');

        expect(widget.useThemeColor, isTrue);
        expect(widget.color, isNull);
        expect(widget.colorBlendMode, equals(BlendMode.srcIn));
        expect(widget.fit, equals(BoxFit.cover));
      });

      test('colored constructor should set useThemeColor to false', () {
        const widget = ImageAssetWidget.colored(
          path: 'test.svg',
          color: Colors.red,
        );

        expect(widget.useThemeColor, isFalse);
        expect(widget.color, equals(Colors.red));
        expect(widget.colorBlendMode, equals(BlendMode.srcIn));
        expect(widget.fit, equals(BoxFit.cover));
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle zero dimensions', (tester) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
            width: 0.0,
            height: 0.0,
          ),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.width, equals(0.0));
        expect(svgWidget.height, equals(0.0));
      });

      testWidgets('should prioritize useThemeColor over custom color', (
        tester,
      ) async {
        const customColor = Colors.red;

        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
            color: customColor,
            useThemeColor: true,
          ),
          theme: ThemeData.light(),
        );

        final svgWidget = tester.widget<SvgPicture>(find.byType(SvgPicture));
        expect(svgWidget.colorFilter, isNotNull);
        // Should use theme color (black) instead of custom color (red)
        expect(
          svgWidget.colorFilter,
          equals(const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
        );
      });
    });

    group('Widget Structure', () {
      testWidgets('should have correct widget hierarchy for SVG', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(Image), findsNothing);
      });

      testWidgets('should render only SvgPicture for SVG files', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: svgPath,
          ),
        );

        final svgWidgets = find.byType(SvgPicture);
        final imageWidgets = find.byType(Image);

        expect(svgWidgets, findsOneWidget);
        expect(imageWidgets, findsNothing);
      });

      testWidgets('should have correct widget hierarchy for PNG', (
        tester,
      ) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(SvgPicture), findsNothing);
      });

      testWidgets('should render only Image for PNG files', (tester) async {
        await tester.pumpApp(
          const ImageAssetWidget(
            path: pngPath,
          ),
        );

        final svgWidgets = find.byType(SvgPicture);
        final imageWidgets = find.byType(Image);

        expect(imageWidgets, findsOneWidget);
        expect(svgWidgets, findsNothing);
      });
    });
  });
}
