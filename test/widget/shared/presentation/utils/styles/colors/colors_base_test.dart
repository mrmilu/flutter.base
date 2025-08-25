import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors/colors_base.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors/colors_dark.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors/colors_light.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors Static Methods', () {
    group('light getter', () {
      test('should return AppColorsLight instance', () {
        // Act
        final result = AppColors.light;

        // Assert
        expect(result, isA<AppColorsLight>());
        expect(result, equals(AppColorsLight.instance));
      });

      test('should always return the same instance (singleton)', () {
        // Act
        final first = AppColors.light;
        final second = AppColors.light;

        // Assert
        expect(first, same(second));
      });
    });

    group('dark getter', () {
      test('should return AppColorsDark instance', () {
        // Act
        final result = AppColors.dark;

        // Assert
        expect(result, isA<AppColorsDark>());
        expect(result, equals(AppColorsDark.instance));
      });

      test('should always return the same instance (singleton)', () {
        // Act
        final first = AppColors.dark;
        final second = AppColors.dark;

        // Assert
        expect(first, same(second));
      });
    });

    group('of method', () {
      testWidgets('should return light colors when theme brightness is light', (
        tester,
      ) async {
        // Arrange
        late AppColors colors;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Builder(
              builder: (context) {
                colors = AppColors.of(context);
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(colors, isA<AppColorsLight>());
        expect(colors, equals(AppColors.light));
      });

      testWidgets('should return dark colors when theme brightness is dark', (
        tester,
      ) async {
        // Arrange
        late AppColors colors;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Builder(
              builder: (context) {
                colors = AppColors.of(context);
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(colors, isA<AppColorsDark>());
        expect(colors, equals(AppColors.dark));
      });

      testWidgets('should return light colors for light theme', (tester) async {
        // Arrange
        late AppColors colors;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Builder(
              builder: (context) {
                colors = AppColors.of(context);
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(colors, isA<AppColorsLight>());
      });

      testWidgets('should return dark colors for dark theme', (tester) async {
        // Arrange
        late AppColors colors;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Builder(
              builder: (context) {
                colors = AppColors.of(context);
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(colors, isA<AppColorsDark>());
      });

      testWidgets('should access specific colors correctly from context', (
        tester,
      ) async {
        // Arrange
        late Color primaryColor;
        late Color backgroundColor;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Builder(
              builder: (context) {
                final colors = AppColors.of(context);
                primaryColor = colors.primary;
                backgroundColor = colors.background;
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(
          primaryColor,
          equals(const Color(0xFF12EB93)),
        ); // Light theme primary
        expect(
          backgroundColor,
          equals(const Color(0xFFF8F8F8)),
        ); // Light theme background
      });

      testWidgets('should access dark theme colors correctly from context', (
        tester,
      ) async {
        // Arrange
        late Color primaryColor;
        late Color backgroundColor;

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Builder(
              builder: (context) {
                final colors = AppColors.of(context);
                primaryColor = colors.primary;
                backgroundColor = colors.background;
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(
          primaryColor,
          equals(const Color.fromARGB(255, 48, 30, 181)),
        ); // Dark theme primary
        expect(
          backgroundColor,
          equals(const Color(0xFF121212)),
        ); // Dark theme background
      });

      testWidgets('should work with custom theme data brightness', (
        tester,
      ) async {
        // Arrange
        late AppColors colors;

        final customDarkTheme = ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        );

        // Act
        await tester.pumpWidget(
          MaterialApp(
            theme: customDarkTheme,
            home: Builder(
              builder: (context) {
                colors = AppColors.of(context);
                return const SizedBox();
              },
            ),
          ),
        );

        // Assert
        expect(colors, isA<AppColorsDark>());
        expect(colors, equals(AppColors.dark));
      });
    });
  });
}
