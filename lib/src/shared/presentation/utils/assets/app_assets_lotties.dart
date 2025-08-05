/// Constantes para las animaciones Lottie de la aplicación
/// Generado automáticamente - NO EDITAR MANUALMENTE
class AppAssetsLotties {
  /// Previene instanciación de la clase
  AppAssetsLotties._();

  // =============================================================================
  // 🎭 ANIMACIONES LOTTIE
  // =============================================================================

  /// Ruta base para las animaciones Lottie
  static const String _lottiesPath = 'assets/lotties';

  /// Loading - assets/lotties/loading.json
  static const String loading = 'assets/lotties/loading.json';

  // =============================================================================
  // 🎯 UTILIDADES
  // =============================================================================

  /// Genera la ruta completa para una animación Lottie personalizada
  static String lottiePath(String lottieName) => '$_lottiesPath/$lottieName';
}
