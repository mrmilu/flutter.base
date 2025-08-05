import 'package:flutter/material.dart';

import 'colors_base.dart';

/// Implementación de colores para tema claro
class AppColorsLight extends AppColors {
  const AppColorsLight._();

  /// Instancia singleton para tema claro
  static const AppColorsLight instance = AppColorsLight._();

  // =============================================================================
  // 🎨 COLORES PRINCIPALES
  // =============================================================================

  @override
  Color get primary => const Color(0xFF12EB93);

  @override
  Color get secondary => const Color(0xFFFFCE2B);

  @override
  Color get tertiary => const Color(0xFF00779F);

  // =============================================================================
  // 🌈 COLORES DE FONDO
  // =============================================================================

  @override
  Color get background => const Color(0xFFF8F8F8);

  @override
  Color get onBackground => const Color(0xFF172121);

  @override
  Color get grey => const Color(0xFF888498);

  @override
  Color get disabled => const Color(0xFFDADADA);

  @override
  Color get onDisabled => const Color(0xFFB0B0B0);

  // =============================================================================
  // ⚫ COLORES BÁSICOS
  // =============================================================================

  @override
  Color get specificBasicBlack => const Color(0xff000000);

  @override
  Color get specificBasicSemiBlack => const Color(0xFF676767);

  @override
  Color get specificBasicWhite => const Color(0xffFFFFFF);

  @override
  Color get specificBasicGrey => const Color(0xFFDADADA);

  // =============================================================================
  // 📝 COLORES DE CONTENIDO
  // =============================================================================

  @override
  Color get specificContentHigh => const Color(0xff322D2A);

  @override
  Color get specificContentMid => const Color(0xff7D7A78);

  @override
  Color get specificContentLow => const Color(0xff96969A);

  @override
  Color get specificContentExtraLow =>
      const Color(0xffFFFFFF).withAlpha((0.8 * 255).toInt());

  @override
  Color get specificContentInverse => const Color(0xffFFFFFF);

  // =============================================================================
  // 🚨 COLORES SEMÁNTICOS
  // =============================================================================

  @override
  Color get specificSemanticError => const Color(0xFFD92D20);

  @override
  Color get specificSemanticWarning => const Color(0xFFC35605);

  @override
  Color get specificSemanticSuccess => const Color(0xFF288240);

  // =============================================================================
  // 🎭 COLORES DE SUPERFICIE
  // =============================================================================

  @override
  Color get specificSurfaceInverse => const Color(0xff000000);

  @override
  Color get specificSurfaceHigh => const Color(0xffF9ECE1);

  @override
  Color get specificSurfaceMid =>
      const Color(0xff000000).withAlpha((0.05 * 255).toInt());

  @override
  Color get specificSurfaceMidMainPage => const Color(0xffDBC7B8);

  @override
  Color get specificSurfaceLow => const Color(0xffFFFFFF);

  @override
  Color get specificSurfaceExtraLow =>
      const Color(0xffFFFFFF).withAlpha((0.12 * 255).toInt());

  // =============================================================================
  // 🔲 COLORES DE BORDE
  // =============================================================================

  @override
  Color get specificBorderMid => const Color(0xffC6C6CE);

  @override
  Color get specificBorderLow => const Color(0xffDDDDE2);

  // =============================================================================
  // 🎯 COLORES ESPECÍFICOS
  // =============================================================================

  @override
  Color get specificBeige10 => const Color(0xffF0EBE2);

  @override
  Color get specificBeige80 => const Color(0xffB2A6A1);

  @override
  Color get specificTurquoise60 => const Color(0xff336380);

  @override
  Color get specificTurquoise10 => const Color(0xffE0E8EC);

  @override
  Color get specificOlive60 => const Color(0xff687B4F);

  @override
  Color get specificOlive10 => const Color(0xffF0F2ED);

  @override
  Color get specificMustardSixty => const Color(0xffD2AF04);

  @override
  Color get iconBlack => const Color(0xff12131A);

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
  Color get primaryVerdeMedio => const Color(0xFFCCFFE2);

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
      Color(0xFFCCFFE2),
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
  Color get specificBackgroundBase => const Color(0xffFAF8F5);

  @override
  Color get specificBackgroundOverlay1 =>
      const Color(0xff000000).withAlpha((0.25 * 255).toInt());

  @override
  Color get specificBackgroundOverlay2 =>
      const Color(0xffFFFFFF).withAlpha((0.5 * 255).toInt());
}
