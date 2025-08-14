/// Constantes para las imágenes de la aplicación
/// Generado automáticamente - NO EDITAR MANUALMENTE
class AppAssetsImages {
  /// Previene instanciación de la clase
  AppAssetsImages();

  // =============================================================================
  // 🖼️ IMÁGENES
  // =============================================================================

  /// Ruta base para las imágenes
  static const String _imagesPath = 'assets/images';

  /// Ente Partial - assets/images/ente_partial.png
  static const String entePartial = 'assets/images/ente_partial.png';

  // =============================================================================
  // 🎯 UTILIDADES
  // =============================================================================

  /// Genera la ruta completa para una imagen personalizada
  static String imagePath(String imageName) => '$_imagesPath/$imageName';
}
