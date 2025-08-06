/// Constantes para las animaciones Rive de la aplicación
/// Generado automáticamente - NO EDITAR MANUALMENTE
class AppAssetsRive {
  /// Previene instanciación de la clase
  AppAssetsRive._();

  // =============================================================================
  // 🎮 ANIMACIONES RIVE
  // =============================================================================

  /// Ruta base para las animaciones Rive
  static const String _rivePath = 'assets/rive';

  /// Niba Loading - assets/rive/niba_loading.riv
  static const String nibaLoading = 'assets/rive/niba_loading.riv';

  /// Niba Splash - assets/rive/niba_splash.riv
  static const String nibaSplash = 'assets/rive/niba_splash.riv';

  // =============================================================================
  // 🎯 UTILIDADES
  // =============================================================================

  /// Genera la ruta completa para una animación Rive personalizada
  static String rivePath(String riveName) => '$_rivePath/$riveName';
}
