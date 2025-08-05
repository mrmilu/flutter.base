import 'package:flutter/material.dart';

import '../../../utils/styles/colors/colors_context.dart';
import '../../common/image_asset_widget.dart';

/// Widget de botón de texto personalizado del design system
///
/// Uso:
/// ```dart
/// CustomTextButton.primary(
///   key: Key('my-text-button'),
///   label: 'Mi Botón',
///   onPressed: () {},
/// )
/// ```
class CustomTextButton extends StatelessWidget {
  /// Estilo del botón
  final CustomTextButtonStyle _style;

  /// Texto del botón
  final String label;

  /// Función que se ejecuta al presionar el botón
  final VoidCallback? onPressed;

  /// Si el botón está habilitado
  final bool enabled;

  /// Estilo de texto personalizado
  final TextStyle? textStyle;

  /// Color del texto personalizado
  final Color? colorText;

  /// Ruta del icono (solo para estilo icon)
  final String? iconPath;

  const CustomTextButton._({
    super.key,
    required CustomTextButtonStyle style,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.textStyle,
    this.colorText,
    this.iconPath,
  }) : _style = style;

  /// Crea un botón de texto con estilo primario
  const CustomTextButton.primary({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool enabled = true,
    TextStyle? textStyle,
    Color? colorText,
  }) : this._(
         key: key,
         style: CustomTextButtonStyle.primary,
         label: label,
         onPressed: onPressed,
         enabled: enabled,
         textStyle: textStyle,
         colorText: colorText,
       );

  /// Crea un botón de texto con estilo blanco/negro
  const CustomTextButton.secondary({
    Key? key,
    required String label,
    required VoidCallback? onPressed,
    bool enabled = true,
    TextStyle? textStyle,
    Color? colorText,
  }) : this._(
         key: key,
         style: CustomTextButtonStyle.secondary,
         label: label,
         onPressed: onPressed,
         enabled: enabled,
         textStyle: textStyle,
         colorText: colorText,
       );

  /// Crea un botón de texto con icono
  const CustomTextButton.icon({
    Key? key,
    required String label,
    required String iconPath,
    required VoidCallback? onPressed,
    bool enabled = true,
    TextStyle? textStyle,
    Color? colorText,
  }) : this._(
         key: key,
         style: CustomTextButtonStyle.icon,
         label: label,
         onPressed: onPressed,
         enabled: enabled,
         textStyle: textStyle,
         colorText: colorText,
         iconPath: iconPath,
       );

  /// Crea un botón de texto con icono secundario
  const CustomTextButton.iconSecondary({
    Key? key,
    required String label,
    required String iconPath,
    required VoidCallback? onPressed,
    bool enabled = true,
    TextStyle? textStyle,
  }) : this._(
         key: key,
         style: CustomTextButtonStyle.iconSecondary,
         label: label,
         onPressed: onPressed,
         enabled: enabled,
         textStyle: textStyle,
         iconPath: iconPath,
       );

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = enabled ? onPressed : null;
    final textColor = _getTextColor(context);

    return TextButton(
      onPressed: effectiveOnPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        foregroundColor: textColor,
        disabledForegroundColor: context.colors.disabled,
        // overlayColor: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Text(label, style: textStyle)),
          if ((_style == CustomTextButtonStyle.icon ||
                  _style == CustomTextButtonStyle.iconSecondary) &&
              iconPath?.isNotEmpty == true) ...[
            const SizedBox(width: 8),
            ImageAssetWidget(
              path: iconPath!,
              height: 16,
              width: 16,
              color: _getTextColor(context),
            ),
          ],
        ],
      ),
    );
  }

  Color? _getTextColor(BuildContext context) {
    if (!enabled) return context.colors.disabled;

    // Si se especifica un color personalizado, usarlo
    if (colorText != null) return colorText!;

    if (_style == CustomTextButtonStyle.secondary ||
        _style == CustomTextButtonStyle.iconSecondary) {
      // Si es estilo secundario, usar color específico
      final brightness = Theme.of(context).brightness;
      return brightness == Brightness.dark
          ? context.colors.specificBasicWhite
          : context.colors.specificBasicBlack;
    }

    // Si no, usar el color primario que se adapta al tema
    return context.colors.primary;
  }
}

/// Estilos disponibles para CustomTextButton
enum CustomTextButtonStyle { primary, secondary, icon, iconSecondary }
