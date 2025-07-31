import 'package:flutter/material.dart';

/// Estilos de texto disponibles en el design system
enum RMTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// Widget de texto personalizado del design system
///
/// Uso:
/// ```dart
/// RMText.displayLarge(
///   'Título Principal',
///   key: Key('my-title'),
///   color: Colors.blue,
/// )
/// ```
class RMText extends StatelessWidget {
  /// El texto a mostrar
  final String text;

  /// El estilo de texto a aplicar
  final RMTextStyle _style;

  /// Color del texto
  final Color? color;

  /// Peso de la fuente
  final FontWeight? fontWeight;

  /// Tamaño de la fuente
  final double? fontSize;

  /// Altura de línea
  final double? height;

  /// Estilo de la fuente
  final FontStyle? fontStyle;

  /// Decoración del texto
  final TextDecoration? decoration;

  /// Número máximo de líneas
  final int? maxLines;

  /// Alineación del texto
  final TextAlign? textAlign;

  /// Comportamiento de overflow
  final TextOverflow? overflow;

  /// Si el texto debe hacer wrap suave
  final bool? softWrap;

  /// Dirección del texto
  final TextDirection? textDirection;

  // =============================================================================
  // 📏 DISPLAY STYLES (Títulos más grandes)
  // =============================================================================

  /// Crea un Text con estilo displayLarge del design system
  /// Para héroes y headers principales
  const RMText.displayLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.displayLarge;

  /// Crea un Text con estilo displayMedium del design system
  /// Headers de sección importantes
  const RMText.displayMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.displayMedium;

  /// Crea un Text con estilo displaySmall del design system
  /// Headers de subsección
  const RMText.displaySmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.displaySmall;

  // =============================================================================
  // 📰 HEADLINE STYLES (Títulos medianos)
  // =============================================================================

  /// Crea un Text con estilo headlineLarge del design system
  /// Títulos de página
  const RMText.headlineLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.headlineLarge;

  /// Crea un Text con estilo headlineMedium del design system
  /// Títulos de sección
  const RMText.headlineMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.headlineMedium;

  /// Crea un Text con estilo headlineSmall del design system
  /// Subtítulos importantes
  const RMText.headlineSmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.headlineSmall;

  // =============================================================================
  // 🏷️ TITLE STYLES (Títulos pequeños)
  // =============================================================================

  /// Crea un Text con estilo titleLarge del design system
  /// Títulos de cards
  const RMText.titleLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.titleLarge;

  /// Crea un Text con estilo titleMedium del design system
  /// Títulos de listas
  const RMText.titleMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.titleMedium;

  /// Crea un Text con estilo titleSmall del design system
  /// Títulos menores
  const RMText.titleSmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.titleSmall;

  // =============================================================================
  // 📝 BODY STYLES (Texto de contenido)
  // =============================================================================

  /// Crea un Text con estilo bodyLarge del design system
  /// Texto principal
  const RMText.bodyLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.bodyLarge;

  /// Crea un Text con estilo bodyMedium del design system
  /// Texto estándar
  const RMText.bodyMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.bodyMedium;

  /// Crea un Text con estilo bodySmall del design system
  /// Texto auxiliar
  const RMText.bodySmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.bodySmall;

  // =============================================================================
  // 🏷️ LABEL STYLES (Etiquetas y botones)
  // =============================================================================

  /// Crea un Text con estilo labelLarge del design system
  /// Botones grandes
  const RMText.labelLarge(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.labelLarge;

  /// Crea un Text con estilo labelMedium del design system
  /// Botones estándar
  const RMText.labelMedium(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.labelMedium;

  /// Crea un Text con estilo labelSmall del design system
  /// Etiquetas pequeñas
  const RMText.labelSmall(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.textDirection,
  }) : _style = RMTextStyle.labelSmall;

  @override
  Widget build(BuildContext context) {
    TextStyle? baseStyle;

    switch (_style) {
      case RMTextStyle.displayLarge:
        baseStyle = Theme.of(context).textTheme.displayLarge;
        break;
      case RMTextStyle.displayMedium:
        baseStyle = Theme.of(context).textTheme.displayMedium;
        break;
      case RMTextStyle.displaySmall:
        baseStyle = Theme.of(context).textTheme.displaySmall;
        break;
      case RMTextStyle.headlineLarge:
        baseStyle = Theme.of(context).textTheme.headlineLarge;
        break;
      case RMTextStyle.headlineMedium:
        baseStyle = Theme.of(context).textTheme.headlineMedium;
        break;
      case RMTextStyle.headlineSmall:
        baseStyle = Theme.of(context).textTheme.headlineSmall;
        break;
      case RMTextStyle.titleLarge:
        baseStyle = Theme.of(context).textTheme.titleLarge;
        break;
      case RMTextStyle.titleMedium:
        baseStyle = Theme.of(context).textTheme.titleMedium;
        break;
      case RMTextStyle.titleSmall:
        baseStyle = Theme.of(context).textTheme.titleSmall;
        break;
      case RMTextStyle.bodyLarge:
        baseStyle = Theme.of(context).textTheme.bodyLarge;
        break;
      case RMTextStyle.bodyMedium:
        baseStyle = Theme.of(context).textTheme.bodyMedium;
        break;
      case RMTextStyle.bodySmall:
        baseStyle = Theme.of(context).textTheme.bodySmall;
        break;
      case RMTextStyle.labelLarge:
        baseStyle = Theme.of(context).textTheme.labelLarge;
        break;
      case RMTextStyle.labelMedium:
        baseStyle = Theme.of(context).textTheme.labelMedium;
        break;
      case RMTextStyle.labelSmall:
        baseStyle = Theme.of(context).textTheme.labelSmall;
        break;
    }

    return Text(
      text,
      style: baseStyle?.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: height,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
    );
  }
}
