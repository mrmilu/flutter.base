import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget para mostrar imágenes de assets (PNG, JPG, SVG)
///
/// Automáticamente detecta el tipo de archivo y usa el widget apropiado.
/// Para SVG, si no se especifica color, usa automáticamente:
/// - Negro en tema light
/// - Blanco en tema dark
class ImageAssetWidget extends StatelessWidget {
  /// Ruta del asset
  final String path;

  /// Ancho del widget
  final double? width;

  /// Alto del widget
  final double? height;

  /// Color a aplicar al icono
  ///
  /// Si es null, para SVG se aplicará automáticamente:
  /// - Negro en tema light
  /// - Blanco en tema dark
  final Color? color;

  /// Modo de mezcla para el color
  final BlendMode colorBlendMode;

  /// Ajuste de la imagen
  final BoxFit fit;

  /// Si es true, fuerza el uso del color automático según el tema
  /// incluso si se proporciona un color específico
  final bool useThemeColor;
  const ImageAssetWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.fit = BoxFit.cover,
    this.useThemeColor = false,
  });

  /// Constructor de conveniencia para iconos que se adaptan automáticamente al tema
  ///
  /// Ideal para iconos SVG que deben cambiar de color según el tema:
  /// - Negro en tema light
  /// - Blanco en tema dark
  const ImageAssetWidget.icon({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.colorBlendMode = BlendMode.srcIn,
    this.fit = BoxFit.cover,
  }) : color = null,
       useThemeColor = true;

  /// Constructor para forzar un color específico independientemente del tema
  const ImageAssetWidget.colored({
    super.key,
    required this.path,
    required this.color,
    this.width,
    this.height,
    this.colorBlendMode = BlendMode.srcIn,
    this.fit = BoxFit.cover,
  }) : useThemeColor = false;

  @override
  Widget build(BuildContext context) {
    // Determinar el color a usar
    Color? effectiveColor = _getEffectiveColor(context);

    if (_hasSvgExtension(path)) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        colorFilter: effectiveColor != null
            ? ColorFilter.mode(effectiveColor, colorBlendMode)
            : null,
      );
    } else {
      return Image.asset(
        path,
        width: width,
        height: height,
        color: effectiveColor,
        fit: fit,
        colorBlendMode: colorBlendMode,
      );
    }
  }

  /// Determina el color efectivo a usar basado en el tema y configuración
  Color? _getEffectiveColor(BuildContext context) {
    // Si useThemeColor es true, siempre usar color del tema
    if (useThemeColor) {
      return _getThemeBasedColor(context);
    }

    // Si se proporciona un color específico, usarlo
    if (color != null) {
      return color;
    }

    // Para SVG sin color específico, usar color automático del tema
    if (_hasSvgExtension(path)) {
      return _getThemeBasedColor(context);
    }

    // Para imágenes normales sin color, no aplicar ninguno
    return null;
  }

  /// Obtiene el color apropiado según el tema actual
  Color _getThemeBasedColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  bool _hasSvgExtension(String path) => path.toLowerCase().endsWith('svg');
}
