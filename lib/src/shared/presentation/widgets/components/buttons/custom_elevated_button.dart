import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../common/button_scale_widget.dart';
import '../../common/image_asset_widget.dart';

/// Widget elevado personalizado del design system
///
/// Uso:
/// ```dart
/// CustomElevatedButton.primary(
///   key: Key('my-button'),
///   label: 'Mi Botón',
///   onPressed: () {},
/// )
/// ```
class CustomElevatedButton extends StatelessWidget {
  /// Estilo del botón
  final CustomElevatedButtonStyle _style;

  /// Texto del botón
  final String label;

  /// Función que se ejecuta al presionar el botón
  final VoidCallback onPressed;

  /// Color de fondo personalizado
  final Color? backgroundColor;

  /// Color del texto personalizado
  final Color? foregroundColor;

  /// Padding interno del botón
  final EdgeInsets? padding;

  /// Si el botón está deshabilitado
  final bool isDisabled;

  /// Si el botón está en estado de carga
  final bool isLoading;

  /// Ruta del icono (opcional)
  final String? iconPath;

  /// Si el icono va a la derecha del texto
  final bool iconRight;

  /// Alineación del texto
  final TextAlign? textAlign;

  /// Estilo de texto
  final TextStyle? textStyle;

  /// Color del icono
  final Color? iconColor;

  const CustomElevatedButton._({
    super.key,
    required CustomElevatedButtonStyle style,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.isDisabled = false,
    this.isLoading = false,
    this.iconPath,
    this.iconRight = false,
    this.textAlign,
    this.textStyle,
    this.iconColor,
  }) : _style = style;

  /// Crea un botón elevado con estilo primario
  const CustomElevatedButton.primary({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    bool isDisabled = false,
    bool isLoading = false,
    String? iconPath,
    bool iconRight = false,
    TextAlign? textAlign,
    TextStyle? textStyle,
    Color? iconColor,
  }) : this._(
         key: key,
         style: CustomElevatedButtonStyle.primary,
         label: label,
         onPressed: onPressed,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         padding: padding,
         isDisabled: isDisabled,
         isLoading: isLoading,
         iconPath: iconPath,
         iconRight: iconRight,
         textAlign: textAlign,
         textStyle: textStyle,
         iconColor: iconColor,
       );

  /// Crea un botón elevado con estilo inverso
  const CustomElevatedButton.inverse({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    bool isDisabled = false,
    bool isLoading = false,
    String? iconPath,
    bool iconRight = false,
    TextAlign? textAlign,
    TextStyle? textStyle,
    Color? iconColor,
  }) : this._(
         key: key,
         style: CustomElevatedButtonStyle.inverse,
         label: label,
         onPressed: onPressed,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         padding: padding,
         isDisabled: isDisabled,
         isLoading: isLoading,
         iconPath: iconPath,
         iconRight: iconRight,
         textAlign: textAlign,
         textStyle: textStyle,
         iconColor: iconColor,
       );

  @override
  Widget build(BuildContext context) {
    return ButtonScaleWidget(
      onTap: isDisabled
          ? null
          : () {
              if (isLoading) return;
              onPressed();
            },
      child: ElevatedButton(
        onPressed: !isDisabled
            ? () {
                if (isLoading || isDisabled) return;
                onPressed();
              }
            : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.disabled,
          // disabledForegroundColor: Colors.white,
          backgroundColor: _getBackgroundColor(context),
          foregroundColor: _getForegroundColor(context),
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _getForegroundColor(context),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!iconRight && iconPath != null) ...[
                    ImageAssetWidget(
                      path: iconPath!,
                      width: 20,
                      height: 20,
                      color: iconColor ?? _getDefaultIconColor(context),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(label, textAlign: textAlign, style: textStyle),
                  ),
                  if (iconRight && iconPath != null) ...[
                    const SizedBox(width: 8),
                    ImageAssetWidget(
                      path: iconPath!,
                      width: 20,
                      height: 20,
                      color: iconColor ?? _getDefaultIconColor(context),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isDisabled) return AppColors.disabled;
    if (backgroundColor != null) return backgroundColor!;

    switch (_style) {
      case CustomElevatedButtonStyle.primary:
        return AppColors.primary;
      case CustomElevatedButtonStyle.inverse:
        // En inverse, el fondo debe adaptarse al tema
        final brightness = Theme.of(context).brightness;
        return brightness == Brightness.dark
            ? Colors.white
            : AppColors.onBackground;
    }
  }

  Color? _getForegroundColor(BuildContext context) {
    if (isDisabled) return Colors.white;
    if (foregroundColor != null) return foregroundColor!;

    switch (_style) {
      case CustomElevatedButtonStyle.primary:
        // Para primary, el texto debe ser legible sobre el color primario
        // Generalmente el primario es un color, así que texto blanco es más seguro
        return null;
      case CustomElevatedButtonStyle.inverse:
        // En inverse, el texto debe ser contrario al fondo
        final brightness = Theme.of(context).brightness;
        return brightness == Brightness.dark ? Colors.black : Colors.white;
    }
  }

  Color? _getDefaultIconColor(BuildContext context) {
    switch (_style) {
      case CustomElevatedButtonStyle.primary:
        // Para primary, el icono debe coincidir con el texto (blanco)
        return null;
      case CustomElevatedButtonStyle.inverse:
        // Para inverse, el icono debe coincidir con el texto
        final brightness = Theme.of(context).brightness;
        return brightness == Brightness.dark ? Colors.black : Colors.white;
    }
  }
}

/// Estilos disponibles para CustomElevatedButton
enum CustomElevatedButtonStyle { primary, inverse }
