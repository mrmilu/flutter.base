import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors/colors_base.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors/colors_light.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColorsLight', () {
    group('Singleton Pattern', () {
      test('should return same instance each time', () {
        // Act
        final first = AppColorsLight.instance;
        final second = AppColorsLight.instance;

        // Assert
        expect(first, same(second));
      });

      test('should be const constructor', () {
        // Act
        const instance = AppColorsLight.instance;

        // Assert
        expect(instance, isA<AppColorsLight>());
        expect(instance, isA<AppColors>());
      });
    });

    group('Main Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct primary color', () {
        expect(colors.primary, equals(const Color(0xFF12EB93)));
      });

      test('should have correct secondary color', () {
        expect(colors.secondary, equals(const Color(0xFFFFCE2B)));
      });

      test('should have correct tertiary color', () {
        expect(colors.tertiary, equals(const Color(0xFF00779F)));
      });
    });

    group('Background Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct background color', () {
        expect(colors.background, equals(const Color(0xFFF8F8F8)));
      });

      test('should have correct onBackground color', () {
        expect(colors.onBackground, equals(const Color(0xFF172121)));
      });

      test('should have correct grey color', () {
        expect(colors.grey, equals(const Color(0xFF888498)));
      });

      test('should have correct disabled color', () {
        expect(colors.disabled, equals(const Color(0xFFDADADA)));
      });

      test('should have correct onDisabled color', () {
        expect(colors.onDisabled, equals(const Color(0xFFB0B0B0)));
      });
    });

    group('Basic Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct basic black color', () {
        expect(colors.specificBasicBlack, equals(const Color(0xff000000)));
      });

      test('should have correct basic semi-black color', () {
        expect(colors.specificBasicSemiBlack, equals(const Color(0xFF676767)));
      });

      test('should have correct basic white color', () {
        expect(colors.specificBasicWhite, equals(const Color(0xffFFFFFF)));
      });

      test('should have correct basic grey color', () {
        expect(colors.specificBasicGrey, equals(const Color(0xFFDADADA)));
      });
    });

    group('Content Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct content high color', () {
        expect(colors.specificContentHigh, equals(const Color(0xff322D2A)));
      });

      test('should have correct content mid color', () {
        expect(colors.specificContentMid, equals(const Color(0xff7D7A78)));
      });

      test('should have correct content low color', () {
        expect(colors.specificContentLow, equals(const Color(0xff96969A)));
      });

      test('should have correct content extra low color with alpha', () {
        final expectedColor = const Color(
          0xffFFFFFF,
        ).withAlpha((0.8 * 255).toInt());
        expect(colors.specificContentExtraLow, equals(expectedColor));
      });

      test('should have correct content inverse color', () {
        expect(colors.specificContentInverse, equals(const Color(0xffFFFFFF)));
      });
    });

    group('Semantic Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct semantic error color', () {
        expect(colors.specificSemanticError, equals(const Color(0xFFD92D20)));
      });

      test('should have correct semantic warning color', () {
        expect(colors.specificSemanticWarning, equals(const Color(0xFFC35605)));
      });

      test('should have correct semantic success color', () {
        expect(colors.specificSemanticSuccess, equals(const Color(0xFF288240)));
      });
    });

    group('Surface Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct surface inverse color', () {
        expect(colors.specificSurfaceInverse, equals(const Color(0xff000000)));
      });

      test('should have correct surface high color', () {
        expect(colors.specificSurfaceHigh, equals(const Color(0xffF9ECE1)));
      });

      test('should have correct surface mid color with alpha', () {
        final expectedColor = const Color(
          0xff000000,
        ).withAlpha((0.05 * 255).toInt());
        expect(colors.specificSurfaceMid, equals(expectedColor));
      });

      test('should have correct surface mid main page color', () {
        expect(
          colors.specificSurfaceMidMainPage,
          equals(const Color(0xffDBC7B8)),
        );
      });

      test('should have correct surface low color', () {
        expect(colors.specificSurfaceLow, equals(const Color(0xffFFFFFF)));
      });

      test('should have correct surface extra low color with alpha', () {
        final expectedColor = const Color(
          0xffFFFFFF,
        ).withAlpha((0.12 * 255).toInt());
        expect(colors.specificSurfaceExtraLow, equals(expectedColor));
      });
    });

    group('Border Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct border mid color', () {
        expect(colors.specificBorderMid, equals(const Color(0xffC6C6CE)));
      });

      test('should have correct border low color', () {
        expect(colors.specificBorderLow, equals(const Color(0xffDDDDE2)));
      });
    });

    group('Specific Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct beige 10 color', () {
        expect(colors.specificBeige10, equals(const Color(0xffF0EBE2)));
      });

      test('should have correct beige 80 color', () {
        expect(colors.specificBeige80, equals(const Color(0xffB2A6A1)));
      });

      test('should have correct turquoise 60 color', () {
        expect(colors.specificTurquoise60, equals(const Color(0xff336380)));
      });

      test('should have correct turquoise 10 color', () {
        expect(colors.specificTurquoise10, equals(const Color(0xffE0E8EC)));
      });

      test('should have correct olive 60 color', () {
        expect(colors.specificOlive60, equals(const Color(0xff687B4F)));
      });

      test('should have correct olive 10 color', () {
        expect(colors.specificOlive10, equals(const Color(0xffF0F2ED)));
      });

      test('should have correct mustard sixty color', () {
        expect(colors.specificMustardSixty, equals(const Color(0xffD2AF04)));
      });

      test('should have correct icon black color', () {
        expect(colors.iconBlack, equals(const Color(0xff12131A)));
      });
    });

    group('Additional Primary Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct primary azul claro color', () {
        expect(colors.primaryAzulClaro, equals(const Color(0xFF71DBFF)));
      });

      test('should have correct primary azul suave color', () {
        expect(colors.primaryAzulSuave, equals(const Color(0xFF83F3EA)));
      });

      test('should have correct primary verde azulado color', () {
        expect(colors.primaryVerdeAzulado, equals(const Color(0xFF12EB93)));
      });

      test('should have correct primary verde medio color', () {
        expect(colors.primaryVerdeMedio, equals(const Color(0xFFCCFFE2)));
      });

      test('should have correct primary naranja color', () {
        expect(colors.primaryNaranja, equals(const Color(0xFFFFCE2B)));
      });

      test('should have correct primary amarillo color', () {
        expect(colors.primaryAmarillo, equals(const Color(0xFFFEFF00)));
      });
    });

    group('Custom Colors', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct custom verde color', () {
        expect(colors.customVerde, equals(const Color(0xFF4BFFB6)));
      });

      test('should have correct custom azul color', () {
        expect(colors.customAzul, equals(const Color(0xFF5DE2F4)));
      });
    });

    group('Gradients', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct primary gradient', () {
        final gradient = colors.gradientPrimary;
        expect(gradient, isA<LinearGradient>());
        expect(
          gradient.colors,
          equals([
            const Color(0xFF83F3EA),
            const Color(0xFF71DBFF),
          ]),
        );
        expect(gradient.begin, equals(Alignment.centerLeft));
        expect(gradient.end, equals(Alignment.centerRight));
      });

      test('should have correct secondary gradient', () {
        final gradient = colors.gradientSecondary;
        expect(gradient, isA<LinearGradient>());
        expect(
          gradient.colors,
          equals([
            const Color(0xFF12EB93),
            const Color(0xFFCCFFE2),
          ]),
        );
        expect(gradient.begin, equals(Alignment.centerLeft));
        expect(gradient.end, equals(Alignment.centerRight));
      });

      test('should have correct tertiary gradient', () {
        final gradient = colors.gradientTertiary;
        expect(gradient, isA<LinearGradient>());
        expect(
          gradient.colors,
          equals([
            const Color(0xFFFEFF00),
            const Color(0xFFFFCE2B),
          ]),
        );
        expect(gradient.begin, equals(Alignment.centerLeft));
        expect(gradient.end, equals(Alignment.centerRight));
      });
    });

    group('Background Colors Specific', () {
      late AppColorsLight colors;

      setUp(() {
        colors = AppColorsLight.instance;
      });

      test('should have correct background base color', () {
        expect(colors.specificBackgroundBase, equals(const Color(0xffFAF8F5)));
      });

      test('should have correct background overlay 1 color with alpha', () {
        final expectedColor = const Color(
          0xff000000,
        ).withAlpha((0.25 * 255).toInt());
        expect(colors.specificBackgroundOverlay1, equals(expectedColor));
      });

      test('should have correct background overlay 2 color with alpha', () {
        final expectedColor = const Color(
          0xffFFFFFF,
        ).withAlpha((0.5 * 255).toInt());
        expect(colors.specificBackgroundOverlay2, equals(expectedColor));
      });
    });

    group('Color Consistency', () {
      test('should maintain color values across multiple accesses', () {
        // Arrange
        final colors = AppColorsLight.instance;

        // Act
        final primary1 = colors.primary;
        final primary2 = colors.primary;

        // Assert
        expect(primary1, equals(primary2));
        expect(primary1, same(primary2));
      });

      test('should have different values than dark theme', () {
        // This test ensures light theme has distinct values
        final colors = AppColorsLight.instance;

        // These should be different from dark theme equivalents
        expect(
          colors.background,
          isNot(equals(const Color(0xFF121212))),
        ); // Dark background
        expect(
          colors.onBackground,
          isNot(equals(const Color(0xFFE0E0E0))),
        ); // Dark onBackground
      });
    });
  });
}
