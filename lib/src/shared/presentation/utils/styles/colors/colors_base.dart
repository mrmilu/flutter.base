import 'package:flutter/material.dart';

import 'colors_dark.dart';
import 'colors_light.dart';

/// Clase abstracta base para definir la estructura de colores de la aplicación
/// Permite implementaciones específicas para temas claro y oscuro
abstract class AppColors {
  /// Constructor constante para permitir herencia con const
  const AppColors();

  // =============================================================================
  // 🎨 COLORES PRINCIPALES
  // =============================================================================

  /// Color primario de la aplicación
  Color get primary;

  /// Color secundario de la aplicación
  Color get secondary;

  /// Color terciario de la aplicación
  Color get tertiary;

  // =============================================================================
  // 🌈 COLORES DE FONDO
  // =============================================================================

  /// Color de fondo principal
  Color get background;

  /// Color sobre el fondo
  Color get onBackground;

  /// Color gris general
  Color get grey;

  /// Color para elementos deshabilitados
  Color get disabled;

  /// Color sobre elementos deshabilitados
  Color get onDisabled;

  // =============================================================================
  // ⚫ COLORES BÁSICOS
  // =============================================================================

  /// Negro específico
  Color get specificBasicBlack;

  /// Semi-negro específico
  Color get specificBasicSemiBlack;

  /// Blanco específico
  Color get specificBasicWhite;

  /// Gris específico
  Color get specificBasicGrey;

  // =============================================================================
  // 📝 COLORES DE CONTENIDO
  // =============================================================================

  /// Contenido de alto contraste
  Color get specificContentHigh;

  /// Contenido de contraste medio
  Color get specificContentMid;

  /// Contenido de bajo contraste
  Color get specificContentLow;

  /// Contenido de contraste extra bajo
  Color get specificContentExtraLow;

  /// Contenido inverso
  Color get specificContentInverse;

  // =============================================================================
  // 🚨 COLORES SEMÁNTICOS
  // =============================================================================

  /// Color para errores
  Color get specificSemanticError;

  /// Color para advertencias
  Color get specificSemanticWarning;

  /// Color para éxito
  Color get specificSemanticSuccess;

  // =============================================================================
  // 🎭 COLORES DE SUPERFICIE
  // =============================================================================

  /// Superficie inversa
  Color get specificSurfaceInverse;

  /// Superficie de alto contraste
  Color get specificSurfaceHigh;

  /// Superficie de contraste medio
  Color get specificSurfaceMid;

  /// Superficie media para página principal
  Color get specificSurfaceMidMainPage;

  /// Superficie de bajo contraste
  Color get specificSurfaceLow;

  /// Superficie de contraste extra bajo
  Color get specificSurfaceExtraLow;

  // =============================================================================
  // 🔲 COLORES DE BORDE
  // =============================================================================

  /// Borde de contraste medio
  Color get specificBorderMid;

  /// Borde de bajo contraste
  Color get specificBorderLow;

  // =============================================================================
  // 🎯 COLORES ESPECÍFICOS
  // =============================================================================

  /// Beige claro
  Color get specificBeige10;

  /// Beige oscuro
  Color get specificBeige80;

  /// Turquesa medio
  Color get specificTurquoise60;

  /// Turquesa claro
  Color get specificTurquoise10;

  /// Oliva medio
  Color get specificOlive60;

  /// Oliva claro
  Color get specificOlive10;

  /// Mostaza
  Color get specificMustardSixty;

  /// Icono negro
  Color get iconBlack;

  // =============================================================================
  // 🎨 COLORES PRIMARIOS ADICIONALES
  // =============================================================================

  Color get primaryAzulClaro;
  Color get primaryAzulSuave;
  Color get primaryVerdeAzulado;
  Color get primaryVerdeMedio;
  Color get primaryNaranja;
  Color get primaryAmarillo;

  // =============================================================================
  // ✨ COLORES PERSONALIZADOS
  // =============================================================================

  Color get customVerde;
  Color get customAzul;

  // =============================================================================
  // 🌈 GRADIENTES
  // =============================================================================

  LinearGradient get gradientPrimary;
  LinearGradient get gradientSecondary;
  LinearGradient get gradientTertiary;

  // =============================================================================
  // 🔧 COLORES DE FONDO ESPECÍFICOS
  // =============================================================================

  Color get specificBackgroundBase;
  Color get specificBackgroundOverlay1;
  Color get specificBackgroundOverlay2;

  // =============================================================================
  // 🎯 MÉTODOS ESTÁTICOS DE CONVENIENCIA
  // =============================================================================

  /// Obtiene la instancia de colores para tema claro
  static AppColorsLight get light => AppColorsLight.instance;

  /// Obtiene la instancia de colores para tema oscuro
  static AppColorsDark get dark => AppColorsDark.instance;

  /// Obtiene los colores correspondientes al tema actual desde el contexto
  /// Uso: AppColors.of(context).primary
  static AppColors of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }
}
