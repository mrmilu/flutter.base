import 'package:flutter/material.dart';

import 'colors_base.dart';
import 'colors_context.dart';

/// Widget que proporciona acceso automático a los colores basados en el tema
class AppColorsProvider extends StatelessWidget {
  final Widget child;

  const AppColorsProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Actualizar el resolver con los colores actuales
    final colors = context.colors;
    AppColorsResolver.setCurrentColors(colors);

    return child;
  }
}

/// InheritedWidget para pasar colores a través del árbol de widgets
class AppColorsInherited extends InheritedWidget {
  final AppColors colors;

  const AppColorsInherited({
    super.key,
    required this.colors,
    required super.child,
  });

  static AppColors of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<AppColorsInherited>();
    if (inherited != null) {
      return inherited.colors;
    }
    // Fallback a detectar desde el tema
    return context.colors;
  }

  @override
  bool updateShouldNotify(AppColorsInherited oldWidget) {
    return colors != oldWidget.colors;
  }
}
