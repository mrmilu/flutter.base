import 'package:flutter/material.dart';

import 'colors_base.dart';

/// Extensión para obtener colores basados en el tema actual del contexto
extension AppColorsContext on BuildContext {
  /// Obtiene los colores correspondientes al tema actual
  AppColors get colors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark ? AppColors.dark : AppColors.light;
  }

  /// Alias más corto para acceder a los colores
  AppColors get appColors => colors;
}

/// Clase de utilidad para obtener colores sin contexto (para casos especiales)
class AppColorsResolver {
  static AppColors? _currentColors;

  /// Establece los colores actuales (llamar desde el widget principal)
  static void setCurrentColors(AppColors colors) {
    _currentColors = colors;
  }

  /// Obtiene los colores actuales (usar solo cuando no hay contexto disponible)
  static AppColors get current {
    assert(
      _currentColors != null,
      'AppColorsResolver no ha sido inicializado. Llama setCurrentColors() primero o usa context.colors en su lugar.',
    );
    return _currentColors!;
  }
}
