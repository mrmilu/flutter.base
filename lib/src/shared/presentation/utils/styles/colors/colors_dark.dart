import 'package:flutter/material.dart';

import 'colors_base.dart';

/// Implementación de colores para tema oscuro
class AppColorsDark extends AppColors {
  const AppColorsDark._();

  /// Instancia singleton para tema oscuro
  static const AppColorsDark instance = AppColorsDark._();

  // =============================================================================
  // 🎨 COLORES PRINCIPALES
  // =============================================================================

  @override
  Color get primary => const Color.fromARGB(255, 48, 30, 181);

  @override
  Color get secondary => const Color(0xFFFFCE2B);

  @override
  Color get tertiary => const Color(0xFF00779F);

  // =============================================================================
  // 🌈 COLORES DE FONDO
  // =============================================================================

  @override
  Color get background => const Color(0xFF121212);

  @override
  Color get onBackground => const Color(0xFFE0E0E0);

  @override
  Color get grey => const Color(0xFF888498);

  @override
  Color get disabled => const Color(0xFF2C2C2C);

  @override
  Color get onDisabled => const Color(0xFF6A6A6A);

  // =============================================================================
  // ⚫ COLORES BÁSICOS
  // =============================================================================

  @override
  Color get specificBasicBlack => const Color(0xff000000);

  @override
  Color get specificBasicSemiBlack => const Color(0xFFB0B0B0);

  @override
  Color get specificBasicWhite => const Color(0xffFFFFFF);

  @override
  Color get specificBasicGrey => const Color(0xFF2C2C2C);

  // =============================================================================
  // 📝 COLORES DE CONTENIDO
  // =============================================================================

  @override
  Color get specificContentHigh => const Color(0xffE0E0E0);

  @override
  Color get specificContentMid => const Color(0xffB0B0B0);

  @override
  Color get specificContentLow => const Color(0xff888888);

  @override
  Color get specificContentExtraLow =>
      const Color(0xff000000).withAlpha((0.8 * 255).toInt());

  @override
  Color get specificContentInverse => const Color(0xff000000);

  // =============================================================================
  // 🚨 COLORES SEMÁNTICOS
  // =============================================================================

  @override
  Color get specificSemanticError => const Color(0xFFFF6B6B);

  @override
  Color get specificSemanticWarning => const Color(0xFFFFB347);

  @override
  Color get specificSemanticSuccess => const Color(0xFF51CF66);

  // =============================================================================
  // 🎭 COLORES DE SUPERFICIE
  // =============================================================================

  @override
  Color get specificSurfaceInverse => const Color(0xffFFFFFF);

  @override
  Color get specificSurfaceHigh => const Color(0xff2A2A2A);

  @override
  Color get specificSurfaceMid =>
      const Color(0xffFFFFFF).withAlpha((0.05 * 255).toInt());

  @override
  Color get specificSurfaceMidMainPage => const Color(0xff1E1E1E);

  @override
  Color get specificSurfaceLow => const Color(0xff1A1A1A);

  @override
  Color get specificSurfaceExtraLow =>
      const Color(0xff000000).withAlpha((0.12 * 255).toInt());

  // =============================================================================
  // 🔲 COLORES DE BORDE
  // =============================================================================

  @override
  Color get specificBorderMid => const Color(0xff4A4A4A);

  @override
  Color get specificBorderLow => const Color(0xff333333);

  // =============================================================================
  // 🎯 COLORES ESPECÍFICOS
  // =============================================================================

  @override
  Color get specificBeige10 => const Color(0xff2A2A2A);

  @override
  Color get specificBeige80 => const Color(0xff6A6A6A);

  @override
  Color get specificTurquoise60 => const Color(0xff4A9CCC);

  @override
  Color get specificTurquoise10 => const Color(0xff1A2A2E);

  @override
  Color get specificOlive60 => const Color(0xff8FA66F);

  @override
  Color get specificOlive10 => const Color(0xff2A2E1A);

  @override
  Color get specificMustardSixty => const Color(0xFFE6C537);

  @override
  Color get iconBlack => const Color(0xffE0E0E0);

  // =============================================================================
  // 🎨 COLORES PRIMARIOS ADICIONALES
  // =============================================================================

  @override
  Color get primaryAzulClaro => const Color(0xFF71DBFF);

  @override
  Color get primaryAzulSuave => const Color(0xFF83F3EA);

  @override
  Color get primaryVerdeAzulado => const Color(0xFF12EB93);

  @override
  Color get primaryVerdeMedio => const Color(0xFF4A7A4A);

  @override
  Color get primaryNaranja => const Color(0xFFFFCE2B);

  @override
  Color get primaryAmarillo => const Color(0xFFFEFF00);

  // =============================================================================
  // ✨ COLORES PERSONALIZADOS
  // =============================================================================

  @override
  Color get customVerde => const Color(0xFF4BFFB6);

  @override
  Color get customAzul => const Color(0xFF5DE2F4);

  // =============================================================================
  // 🌈 GRADIENTES
  // =============================================================================

  @override
  LinearGradient get gradientPrimary => const LinearGradient(
    colors: [
      Color(0xFF83F3EA),
      Color(0xFF71DBFF),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  LinearGradient get gradientSecondary => const LinearGradient(
    colors: [
      Color(0xFF12EB93),
      Color(0xFF4A7A4A),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  LinearGradient get gradientTertiary => const LinearGradient(
    colors: [
      Color(0xFFFEFF00),
      Color(0xFFFFCE2B),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // =============================================================================
  // 🔧 COLORES DE FONDO ESPECÍFICOS
  // =============================================================================

  @override
  Color get specificBackgroundBase => const Color(0xff121212);

  @override
  Color get specificBackgroundOverlay1 =>
      const Color(0xffFFFFFF).withAlpha((0.25 * 255).toInt());

  @override
  Color get specificBackgroundOverlay2 =>
      const Color(0xff000000).withAlpha((0.5 * 255).toInt());
}
