/// Constantes para los assets del design system
class AppAssets {
  /// Previene instanciación de la clase
  AppAssets._();

  // =============================================================================
  // 🎨 ICONOS
  // =============================================================================

  /// Iconos del design system
  static const String _iconsPath = 'assets/icons';

  /// Icono de información
  static const String iconInfo = '$_iconsPath/info.svg';

  /// Icono de advertencia
  static const String iconWarning = '$_iconsPath/warning.svg';

  /// Icono de error (reutiliza el de warning)
  static const String iconError = '$_iconsPath/warning.svg';

  /// Icono de flecha hacia abajo
  static const String iconArrowDown = '$_iconsPath/arrow_ios_down.svg';

  // =============================================================================
  // 🎯 UTILIDADES PARA ICONOS PERSONALIZADOS
  // =============================================================================

  /// Genera la ruta completa para un icono personalizado del package
  ///
  /// Uso:
  /// ```dart
  /// AppAssets.iconPath('arrow_down.svg')
  /// // Retorna: 'packages/rainmakers_design_system/assets/icons/arrow_down.svg'
  /// ```
  static String iconPath(String iconName) => '$_iconsPath/$iconName';
}
