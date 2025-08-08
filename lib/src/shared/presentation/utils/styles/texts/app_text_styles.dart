import 'package:flutter/material.dart';

class Fonts {
  static const String abcdiatype = 'ABCDiatype';
  static const String recoleta = 'Recoleta';
}

// Estilos predefinidos usando la fuente del proyecto
class AppTextStyles {
  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.5,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.5,
  );

  // Headlines
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.5,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
  );

  // Títulos
  static const TextStyle titleLarge = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w500,
    fontSize: 22,
    height: 1.40,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    height: 1.24,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.24,
  );

  // Cuerpo de texto
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.24,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 1.21,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 1.21,
  );

  // Etiquetas
  static const TextStyle labelLarge = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: Fonts.abcdiatype,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
}

final appTextStylesDark = const TextTheme(
  displayLarge: AppTextStyles.displayLarge,
  displayMedium: AppTextStyles.displayMedium,
  displaySmall: AppTextStyles.displaySmall,
  headlineLarge: AppTextStyles.headlineLarge,
  headlineMedium: AppTextStyles.headlineMedium,
  headlineSmall: AppTextStyles.headlineSmall,
  titleLarge: AppTextStyles.titleLarge,
  titleMedium: AppTextStyles.titleMedium,
  titleSmall: AppTextStyles.titleSmall,
  bodyLarge: AppTextStyles.bodyLarge,
  bodyMedium: AppTextStyles.bodyMedium,
  bodySmall: AppTextStyles.bodySmall,
  labelLarge: AppTextStyles.labelLarge,
  labelMedium: AppTextStyles.labelMedium,
  labelSmall: AppTextStyles.labelSmall,
);

final appTextStylesLight = const TextTheme(
  displayLarge: AppTextStyles.displayLarge,
  displayMedium: AppTextStyles.displayMedium,
  displaySmall: AppTextStyles.displaySmall,
  headlineLarge: AppTextStyles.headlineLarge,
  headlineMedium: AppTextStyles.headlineMedium,
  headlineSmall: AppTextStyles.headlineSmall,
  titleLarge: AppTextStyles.titleLarge,
  titleMedium: AppTextStyles.titleMedium,
  titleSmall: AppTextStyles.titleSmall,
  bodyLarge: AppTextStyles.bodyLarge,
  bodyMedium: AppTextStyles.bodyMedium,
  bodySmall: AppTextStyles.bodySmall,
  labelLarge: AppTextStyles.labelLarge,
  labelMedium: AppTextStyles.labelMedium,
  labelSmall: AppTextStyles.labelSmall,
);
